import { Module } from "@nestjs/common";
import { PatientService } from "./patient.service";
import { PatientController } from "./patient.controller";
import { DatabaseModule } from "src/database/database.module";
import { RoleModule } from "src/role/role.module";

@Module({
  imports: [DatabaseModule, RoleModule],
  providers: [PatientService],
  controllers: [PatientController],
})
export class PatientModule {}
