import {
  ArgumentsHost,
  Catch,
  ExceptionFilter,
  HttpException,
} from "@nestjs/common";
import { Response } from "express";
import { IPayloadException } from "src/types";

@Catch(HttpException)
export class HttpExceptionFilter implements ExceptionFilter {
  catch(exception: HttpException, host: ArgumentsHost) {
    const response: Response = host.switchToHttp().getResponse();
    var err: any;
    if (((exception as unknown) as IPayloadException).serializeForSend) {
      err = ((exception as unknown) as IPayloadException).serializeForSend();
      err.type = exception.constructor.name;
    } else {
      err = { type: exception.constructor.name };
    }
    response.status(exception.getStatus()).json({ error: err });
  }
}
