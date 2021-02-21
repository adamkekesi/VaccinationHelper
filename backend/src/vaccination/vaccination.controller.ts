import { Body, Controller, Delete, Param, Post, Put } from "@nestjs/common";
import AuthenticatedUser from "src/auth/authenticated-user.model";
import { Authenticate } from "src/auth/decorator/authenticate.decorator";
import { User } from "src/auth/decorator/authenticated-user.decorator";
import { Protected } from "src/auth/decorator/protected.decorator";
import Response from "src/shared/Response";
import AcceptAppointmentDto from "./dto/accept-appointment.dto";
import ChooseVaccinatorDto from "./dto/choose-vaccinator.dto";
import OfferAppointmentsDto from "./dto/offer-appointments.dto";

import { VaccinationService } from "./vaccination.service";

@Controller("vaccination")
export class VaccinationController {
  constructor(private vaccinationService: VaccinationService) {}

  @Put("/choose-vaccinator")
  @Authenticate()
  @Protected()
  public async chooseVaccinator(
    @Body() payload: ChooseVaccinatorDto,
    @User() authenticatedUser: AuthenticatedUser
  ) {
    var result = await this.vaccinationService.chooseVaccinator(
      payload,
      authenticatedUser.user
    );
    return new Response({ data: result });
  }

  @Put("/offer-appointments")
  @Authenticate()
  @Protected()
  public async offerAppointments(
    @Body() payload: OfferAppointmentsDto,
    @User() authenticatedUser: AuthenticatedUser
  ) {
    var result = await this.vaccinationService.offerAppointments(
      payload,
      authenticatedUser.user
    );
    return new Response({ data: result });
  }

  @Put("/accept-appointment")
  @Authenticate()
  @Protected()
  public async acceptAppointment(
    @Body() payload: AcceptAppointmentDto,
    @User() authenticatedUser: AuthenticatedUser
  ) {
    var result = await this.vaccinationService.acceptAppointment(
      payload,
      authenticatedUser.user
    );
    return new Response({ data: result });
  }

  @Delete("/cancel-appointment/:id")
  @Authenticate()
  @Protected()
  public async cancelAppointment(
    @Param("id") id: string,
    @User() authenticatedUser: AuthenticatedUser
  ) {
    await this.vaccinationService.cancelAppointment(id, authenticatedUser.user);
  }
  @Post("/:id")
  @Authenticate()
  @Protected()
  public async requestVaccination(
    @Param("id") id: string,
    @User() authenticatedUser: AuthenticatedUser
  ) {
    var result = await this.vaccinationService.requestVaccination(
      id,
      authenticatedUser.user
    );
    return new Response({ data: result });
  }
}
