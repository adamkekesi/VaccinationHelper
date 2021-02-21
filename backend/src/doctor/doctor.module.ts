import { Module } from "@nestjs/common";
import { DoctorService } from "./doctor.service";
import { DoctorController } from "./doctor.controller";
import { RoleModule } from "src/role/role.module";
import { DatabaseModule } from "src/database/database.module";

@Module({
  imports: [RoleModule, DatabaseModule],
  providers: [DoctorService],
  controllers: [DoctorController],
})
export class DoctorModule {}
