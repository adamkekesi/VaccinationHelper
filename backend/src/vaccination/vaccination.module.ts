import { Module } from "@nestjs/common";
import { VaccinationService } from "./vaccination.service";
import { VaccinationController } from "./vaccination.controller";
import { DatabaseModule } from "src/database/database.module";
import { RoleModule } from "src/role/role.module";

@Module({
  imports: [DatabaseModule, RoleModule],
  providers: [VaccinationService],
  controllers: [VaccinationController],
})
export class VaccinationModule {}
