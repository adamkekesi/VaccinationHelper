import { Body, Controller, Get, Param, Put, Res } from "@nestjs/common";
import AuthenticatedUser from "src/auth/authenticated-user.model";
import { Authenticate } from "src/auth/decorator/authenticate.decorator";
import { User } from "src/auth/decorator/authenticated-user.decorator";
import { Protected } from "src/auth/decorator/protected.decorator";
import { Authorize } from "src/role/decorator/authorize.decorator";
import Response from "src/shared/Response";
import ChangeHomeDoctorDto from "./dto/change-home-doctor.dto";
import SetConsentFormDto from "./dto/set-consent-form.dto";
import { PatientService } from "./patient.service";

@Controller("patient")
export class PatientController {
  constructor(private patientService: PatientService) {}
  @Put("/change-home-doctor")
  @Authenticate()
  @Protected()
  public async changeHomeDoctor(
    @Body() payload: ChangeHomeDoctorDto,
    @User() authenticatedUser: AuthenticatedUser
  ) {
    const result = await this.patientService.changeHomeDoctor(
      payload,
      authenticatedUser.user
    );
    return new Response({ data: result });
  }

  @Put("/consent-form/:id")
  @Authenticate()
  @Protected()
  public async setConsentForm(
    @Param("id") id: string,
    @Body() payload: SetConsentFormDto,
    @User() authenticatedUser: AuthenticatedUser
  ) {
    const result = await this.patientService.setConsentForm(
      id,
      payload,
      authenticatedUser.user
    );
    return new Response({ data: result });
  }

  @Get("/:id")
  @Authenticate()
  @Protected()
  public async getPatientById(
    @Param("id") id: string,
    @User() authenticatedUser: AuthenticatedUser
  ) {
    const result = await this.patientService.getPatientById(
      id,
      authenticatedUser.user
    );
    return new Response({ data: result });
  }
}
