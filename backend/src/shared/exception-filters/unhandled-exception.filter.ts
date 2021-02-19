import { ArgumentsHost, Catch, HttpException } from "@nestjs/common";
import { EventBus } from "@nestjs/cqrs";
import { Response } from "express";
import ErrorEvent from "../events/error.event";
import { HttpExceptionFilter } from "./http-exception.filter";

@Catch()
export class UnhandledExceptionFilter extends HttpExceptionFilter {
  constructor(private eventBus: EventBus) {
    super();
  }

  catch(exception: any, host: ArgumentsHost) {
    if (exception instanceof HttpException) {
      return super.catch(exception, host);
    }
    this.eventBus.publish(new ErrorEvent(exception));
    const response: Response = host.switchToHttp().getResponse();
    response.status(500).json({
      error: { type: "InternalServerError" },
    });
  }
}
