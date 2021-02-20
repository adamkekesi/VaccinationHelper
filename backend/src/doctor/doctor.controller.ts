import { Controller, Get, Param } from "@nestjs/common";
import { DoctorService } from "./doctor.service";

@Controller("doctor")
export class DoctorController {
  constructor(doctorService: DoctorService) {}

  @Get("/:id")
  public async getDoctorById(@Param("id") id: string) {}
}
