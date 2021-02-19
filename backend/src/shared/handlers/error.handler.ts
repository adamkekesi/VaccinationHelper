import { IEventHandler, EventsHandler } from "@nestjs/cqrs";
import ErrorEvent from "../events/error.event";
import { Logger } from "@nestjs/common";

@EventsHandler(ErrorEvent)
export default class ErrorHandler implements IEventHandler<ErrorEvent> {
  constructor() {}

  public handle(event: ErrorEvent) {
    Logger.error(
      event.error.message,
      (event.error as Error).stack,
      "ErrorHandler",
    );
  }
}
