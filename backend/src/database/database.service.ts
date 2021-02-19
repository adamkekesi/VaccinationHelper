import { Injectable, Logger } from "@nestjs/common";
import {
  createConnection,
  Connection,
  getRepository,
  getManager,
} from "typeorm";
import { interval } from "rxjs";
import { mergeMap, takeWhile } from "rxjs/operators";
import { EventBus } from "@nestjs/cqrs";
import DbConnectionChangedEvent from "./events/connected-to-db.event";
import { Constructable } from "src/types";
import ServiceUnavailable from "src/shared/exceptions/service-unavailable.exception";
import { dbConfig } from "src/database/database.config";
import ErrorEvent from "src/shared/events/error.event";

@Injectable()
export class DatabaseService {
  public connected = false;

  constructor(private eventBus: EventBus) {}

  private connection: Connection;

  public async getRepository<T>(entity: Constructable<T>) {
    if (!this.connection?.isConnected) {
      throw new ServiceUnavailable();
    }
    return getRepository<T>(entity);
  }

  public async startConnecting() {
    if (await this.connectToDb()) {
      return;
    }
    interval(10 * 1000)
      .pipe(
        mergeMap(
          (() => {
            return this.connectToDb();
          }).bind(this)
        )
      )
      .pipe(takeWhile((x) => !x))
      .subscribe();
  }

  public async disconnect() {
    Logger.log("Disconnecting from database...", "DatabaseService");
    await this.connection?.close();
  }

  public async initDb() {}

  private async connectToDb() {
    try {
      this.connection = await createConnection(dbConfig);
      this.eventBus.publish(new DbConnectionChangedEvent(true));
      this.connected = true;
      this.initDb();
      return true;
    } catch (e) {
      this.eventBus.publish(new ErrorEvent(e));
      this.eventBus.publish(new DbConnectionChangedEvent(false));
      this.connected = false;
      return false;
    }
  }
}
