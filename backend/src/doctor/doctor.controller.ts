import { Controller, Delete, Get, Param, Put } from "@nestjs/common";
import AuthenticatedUser from "src/auth/authenticated-user.model";
import { Authenticate } from "src/auth/decorator/authenticate.decorator";
import { User } from "src/auth/decorator/authenticated-user.decorator";
import { Protected } from "src/auth/decorator/protected.decorator";
import Response from "src/shared/Response";
import { DoctorService } from "./doctor.service";

@Controller("doctor")
export class DoctorController {
  constructor(private doctorService: DoctorService) {}

  @Get("/:id")
  @Authenticate()
  @Protected()
  public async getDoctorById(
    @Param("id") id: string,
    @User() authenticatedUser: AuthenticatedUser
  ) {
    const result = await this.doctorService.getDoctorById(
      id,
      authenticatedUser.user
    );

    return new Response({ data: result });
  }

  @Get("/home-doctors")
  @Authenticate()
  @Protected()
  public async getAllHomeDoctors(@User() authenticatedUser: AuthenticatedUser) {
    const result = await this.doctorService.getAllHomeDoctors(
      authenticatedUser.user
    );

    return new Response({ data: result });
  }

  @Get("/vaccinator-doctors")
  @Authenticate()
  @Protected()
  public async getAllVaccinatorDoctors(
    @User() authenticatedUser: AuthenticatedUser
  ) {
    const result = await this.doctorService.getAllVaccinatorDoctors(
      authenticatedUser.user
    );

    return new Response({ data: result });
  }

  @Put("/accept-patient/:connId")
  @Authenticate()
  @Protected()
  public async acceptPatient(
    @User() authenticatedUser: AuthenticatedUser,
    @Param("connId") connId: string
  ) {
    const result = await this.doctorService.acceptPatient(
      connId,
      authenticatedUser.user
    );

    return new Response({ data: result });
  }

  @Delete("/patient-connection/:connId")
  @Authenticate()
  @Protected()
  public async deleteConnection(
    @User() authenticatedUser: AuthenticatedUser,
    @Param("connId") connId: string
  ) {
    await this.doctorService.deleteConnection(connId, authenticatedUser.user);
  }
}
