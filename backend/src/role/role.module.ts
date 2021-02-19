import { Module } from "@nestjs/common";
import RoleHelper from "./role.helper";
import { DatabaseModule } from "src/database/database.module";

@Module({
  imports: [DatabaseModule],
  providers: [RoleHelper],
  controllers: [],
  exports: [RoleHelper]
})
export class RoleModule {}
