import {
  CallHandler,
  ExecutionContext,
  Injectable,
  NestInterceptor,
  Type,
  INestApplication,
  BadRequestException,
} from "@nestjs/common";
import { Request } from "express";
import { Observable } from "rxjs";
import CallHandlerObservable from "../observables/call-handler.observable";
import { reduce } from "p-iteration";
import { RouteParamtypes } from "@nestjs/common/enums/route-paramtypes.enum";
import { deserialize } from "typescript-json-serializer";
import { fromPairs } from "lodash";
import { validate } from "class-validator";
import { map } from "rxjs/operators";
import { serialize } from "typescript-json-serializer";
import InvalidFields from "../exceptions/invalid-fields.exception";
import { getApp } from "src/initApplication";
import InvalidRequestBody from "../exceptions/invalid-request-body.exception";

@Injectable()
export class SerializerInterceptor implements NestInterceptor {
  public async intercept(context: ExecutionContext, next: CallHandler) {
    const req: Request = context.switchToHttp().getRequest();
    const app = getApp();
    const beforeSerialization = this.getBeforeInterceptors(context).map(
      (i) => new i(...this.getInterceptorDependencies(i, app)),
      this
    );
    const responseStream = await reduce<NestInterceptor, Observable<any>>(
      beforeSerialization,
      async (observable, interceptor) => {
        return await interceptor.intercept(context, {
          handle() {
            return observable;
          },
        });
      },
      new CallHandlerObservable(next)
    );

    if (req.headers["content-type"]?.includes("text/plain")) {
      await this.parseTextBody(req);
    }
    req.body = this.deserializeDto(context, req.body, RouteParamtypes.BODY);
    var errors = await validate(req.body);
    if (errors.length !== 0) {
      throw new InvalidFields(errors);
    }
    req.query = this.deserializeDto(context, req.query, RouteParamtypes.QUERY);
    errors = await validate(req.query);
    if (errors.length !== 0) {
      throw new InvalidFields(errors);
    }
    if (responseStream instanceof CallHandlerObservable) {
      responseStream.run();
    }
    return responseStream.pipe(
      map((value) => {
        if (typeof value !== "object") {
          return value;
        }
        const meta = Reflect.getMetadata(
          "api:map:serializable",
          value.constructor
        );
        if (!meta) {
          return value;
        }
        return serialize(value, true);
      })
    );
  }

  private getBeforeInterceptors(context: ExecutionContext) {
    const Controller = context.getClass();
    const propertyKey = context.getHandler().name;
    return (
      (Reflect.getMetadata(
        "beforeSerialization",
        Controller.prototype,
        propertyKey
      ) as Type<NestInterceptor>[]) || []
    );
  }

  private getInterceptorDependencies(
    InterceptorType: Type<NestInterceptor>,
    app: INestApplication
  ) {
    const optionals: number[] = Reflect.getMetadata(
      "optional:paramtypes",
      InterceptorType
    );
    const paramTypes: Type<any>[] = Reflect.getMetadata(
      "design:paramtypes",
      InterceptorType
    );
    const selfParamtypes = Reflect.getMetadata(
      "self:paramtypes",
      InterceptorType
    ) as Array<{ index: number; param: string }>;

    const paramsToInject = paramTypes.map((Type, index) => {
      const custom = selfParamtypes.find((x) => x.index === index)?.param;
      const token = custom !== undefined ? custom : Type;
      const optional = optionals.some((o) => o === index);
      return { token, optional };
    });

    return paramsToInject.map((p) => {
      try {
        return app.get(p.token);
      } catch (e) {
        if (!p.optional) {
          throw e;
        }
      }
    });
  }

  private getDtoType(
    context: ExecutionContext,
    paramType: RouteParamtypes
  ): Type<any> {
    const handlerName = context.getHandler().name;
    const Controller = context.getClass();
    const routeArguments = Reflect.getMetadata(
      "__routeArguments__",
      Controller,
      handlerName
    );
    if (!routeArguments) {
      return;
    }
    const key = Object.keys(routeArguments)
      .map((key) => key.split(":"))
      .find((x) => x[0] === paramType.toString());
    if (!key) {
      return;
    }
    const index = key[1];
    const paramTypes: Type<any>[] = Reflect.getMetadata(
      "design:paramtypes",
      Controller.prototype,
      handlerName
    );
    return (paramTypes || [])[index];
  }

  private deserializeDto(
    context: ExecutionContext,
    raw: any,
    paramType: RouteParamtypes
  ) {
    const Type = this.getDtoType(context, paramType);
    if (!Type) {
      return raw;
    }

    if (raw == undefined || typeof raw !== "object") {
      raw = {};
    }

    const parsed = fromPairs(
      Object.keys(raw).reduce((accumulator, key) => {
        if (raw[key] != null) {
          var value = raw[key];
          try {
            value = JSON.parse(value);
          } catch (e) {}
          accumulator.push([key as string, value]);
        }
        return accumulator;
      }, [] as Array<[string, any]>)
    );
    return deserialize(parsed, Type);
  }

  private parseTextBody(req: Request) {
    return new Promise<void>((resolve, reject) => {
      var body = "";
      const onData = (data: Buffer) => {
        body += data.toString("utf8");
      };

      const unbind = () => {
        req.off("data", onData);
        req.off("close", onClose);
        req.off("error", onError);
        req.off("end", onEnd);
      };

      const onClose = () => {
        unbind();
        reject();
      };

      const onError = () => {
        unbind();
        reject(new InvalidRequestBody());
      };

      const onEnd = () => {
        try {
          unbind();
          req.body = JSON.parse(body);
          resolve();
        } catch (e) {
          reject(e);
        }
      };

      req.on("data", onData);
      req.on("close", onClose);
      req.on("error", onError);
      req.on("end", onEnd);
    });
  }
}
