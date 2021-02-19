import DbConnectionChangedEvent from "../events/connected-to-db.event";
import { IEventHandler, EventsHandler } from "@nestjs/cqrs";
import { Logger } from "@nestjs/common";

@EventsHandler(DbConnectionChangedEvent)
export default class DatabaseEventHandler
  implements IEventHandler<DbConnectionChangedEvent> {
  constructor() {}

  public handle(event: DbConnectionChangedEvent) {
    if (event.connected) {
      Logger.log("Database connection up.", "DatabaseEventHandler");
    } else {
      Logger.warn("Database connection down.", "DatabaseEventHandler");
    }
  }
}
