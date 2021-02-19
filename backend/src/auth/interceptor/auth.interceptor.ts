import {
  CallHandler,
  ExecutionContext,
  Injectable,
  NestInterceptor,
  HttpException,
  InternalServerErrorException,
} from "@nestjs/common";
import { Response } from "express";
import { DatabaseService } from "src/database/database.service";
import AuthenticatedUser from "../authenticated-user.model";
import { Reflector } from "@nestjs/core";
import Unauthorized from "src/shared/exceptions/unauthorized.exception";
import AuthTokenEntity from "../entity/auth-token.entity";
import UserNotVerified from "src/shared/exceptions/user-not-verified.exception";
import JwtService from "src/jwt/jwt.service";

@Injectable()
export class AuthInterceptor implements NestInterceptor {
  constructor(
    private jwtService: JwtService,
    private dbService: DatabaseService,
    private reflector: Reflector
  ) {}

  public async intercept(context: ExecutionContext, next: CallHandler) {
    const isProtected = this.reflector.get<boolean>(
      "protected",
      context.getHandler()
    );
    if (
      !this.reflector
        .getAll<boolean[]>("authenticate", [
          context.getHandler(),
          context.getClass(),
        ])
        .some((x) => x)
    ) {
      if (isProtected) {
        throw new InternalServerErrorException();
      }
      return next.handle();
    }

    const req: Request = context.switchToHttp().getRequest();
    const res: Response = context.switchToHttp().getResponse();
    const jwt = req.headers["authorization"]?.split(" ")[1];
    try {
      const tokenId = (
        await this.jwtService.decodeJwt(jwt).catch(() => {
          throw new Unauthorized();
        })
      ).tokenId;
      const authTokenRepository = await this.dbService.getRepository(
        AuthTokenEntity
      );
      const authToken = await authTokenRepository.findOne(tokenId);
      if (!authToken) {
        throw new Unauthorized();
      }

      const user = authToken.user;
      if (!user) {
        throw new Unauthorized();
      }
      if (!user.verified) {
        throw new UserNotVerified();
      }
      res.locals.authenticatedUser = new AuthenticatedUser(user, authToken);
      return next.handle();
    } catch (e) {
      if (isProtected) {
        throw e instanceof HttpException
          ? e
          : new InternalServerErrorException();
      }
      return next.handle();
    }
  }
}
