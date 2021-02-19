import { Module } from "@nestjs/common";
import { DatabaseService } from "./database.service";
import DatabaseEventHandler from "./handlers/database-events.handler";
import { CqrsModule } from "@nestjs/cqrs";

@Module({
  imports: [CqrsModule],
  providers: [DatabaseService, DatabaseEventHandler],
  exports: [DatabaseService],
})
export class DatabaseModule {}
