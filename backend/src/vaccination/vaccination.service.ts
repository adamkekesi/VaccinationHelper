import { Injectable, Param, Post } from "@nestjs/common";
import { promises } from "fs";
import { DatabaseService } from "src/database/database.service";
import DoctorEntity from "src/doctor/doctor.entity";
import PatientNotExists from "src/patient/exception/patient-not-exists.exception";
import PatientEntity from "src/patient/patient.entity";
import { AuthCb } from "src/role/decorator/auth-cb.decorator";
import { Authorize } from "src/role/decorator/authorize.decorator";
import { Requester } from "src/role/decorator/requester.decorator";
import { RequiredPermissions } from "src/role/decorator/required-permissions.decorator";
import BaseService from "src/shared/base.service";
import PermissionDenied from "src/shared/exceptions/permission-denied.exception";
import UserEntity from "src/user/user.entity";
import AcceptAppointmentDto from "./dto/accept-appointment.dto";
import ChooseVaccinatorDto from "./dto/choose-vaccinator.dto";
import OfferAppointmentsDto from "./dto/offer-appointments.dto";
import AlreadyRequestedVaccination from "./exception/already-requested-vaccination.exception";
import DateUnavailable from "./exception/date-unavailable.exception";
import EmptyConsentForm from "./exception/empty-consent-form.exception";
import VaccinationNotExists from "./exception/vaccination-not-exists.exception";
import VaccinationEntity from "./vaccination.entity";

@Injectable()
export class VaccinationService extends BaseService {
  constructor(private dbService: DatabaseService) {
    super();
  }

  @Authorize()
  @RequiredPermissions({
    resource: "vaccination",
    operation: "request-vaccination",
  })
  public async requestVaccination(
    patientId: string,
    @Requester() user: UserEntity,
    @AuthCb() authCb?: (owner?: string) => Promise<void>
  ) {
    const patientRepository = await this.dbService.getRepository(PatientEntity);
    const vaccinationRepository = await this.dbService.getRepository(
      VaccinationEntity
    );
    const patient = await patientRepository.findOne(patientId, {
      relations: ["doctorPatientConnection", "vaccinationsInProgress"],
    });
    if (!patient) {
      throw new PatientNotExists();
    }
    await authCb(patient.id);
    if (!patient.consentForm) {
      throw new EmptyConsentForm();
    }
    if (!patient.doctorPatientConnection) {
      throw new VaccinationNotExists();
    }
    if (patient.vaccinationsInProgress.length > 0) {
      throw new AlreadyRequestedVaccination();
    }
    const vaccination = await vaccinationRepository.save(
      new VaccinationEntity()
    );
    patient.vaccinationsInProgress.push(vaccination);

    await patientRepository.save(patient);

    return patient;
  }

  @Authorize()
  @RequiredPermissions({
    resource: "vaccination",
    operation: "choose-vaccinator",
  })
  public async chooseVaccinator(
    payload: ChooseVaccinatorDto,
    @Requester() user: UserEntity,
    @AuthCb() authCb?: (owner?: string) => Promise<void>
  ) {
    const vaccinationRepository = await this.dbService.getRepository(
      VaccinationEntity
    );
    const doctorRepository = await this.dbService.getRepository(DoctorEntity);

    const vaccinator = await doctorRepository.findOne(payload.vaccinatorId);

    const vaccination = await vaccinationRepository.findOne(
      payload.vaccinationId
    );
    if (!vaccination) {
      throw new VaccinationNotExists();
    }
    await authCb(vaccination.patient.doctorPatientConnection.doctor.id);
    vaccination.vaccinator = vaccinator;
    await vaccinationRepository.save(vaccination);
    return vaccination;
  }

  @Authorize()
  @RequiredPermissions({
    resource: "vaccination",
    operation: "offer-appointments",
  })
  public async offerAppointments(
    payload: OfferAppointmentsDto,
    @Requester() user: UserEntity,
    @AuthCb() authCb?: (owner?: string) => Promise<void>
  ) {
    const vaccinationRepository = await this.dbService.getRepository(
      VaccinationEntity
    );
    const vaccination = await vaccinationRepository.findOne(
      payload.vaccinationId
    );
    if (!vaccination) {
      throw new VaccinationNotExists();
    }
    await authCb(vaccination.vaccinator?.id);
    vaccination.offeredAppointments = payload.offeredAppointments;
    await vaccinationRepository.save(vaccination);
    return vaccination;
  }

  @Authorize()
  @RequiredPermissions({
    resource: "vaccination",
    operation: "accept-appointment",
  })
  public async acceptAppointment(
    payload: AcceptAppointmentDto,
    @Requester() user: UserEntity,
    @AuthCb() authCb?: (owner?: string) => Promise<void>
  ) {
    const vaccinationRepository = await this.dbService.getRepository(
      VaccinationEntity
    );
    const vaccination = await vaccinationRepository.findOne(
      payload.vaccinationId
    );
    if (!vaccination) {
      throw new VaccinationNotExists();
    }
    await authCb(vaccination.patient.id);
    if (!vaccination.offeredAppointments.includes(payload.chosen)) {
      throw new DateUnavailable();
    }
    vaccination.scheduledDate = payload.chosen;
    vaccination.offeredAppointments = null;
    await vaccinationRepository.save(vaccination);
    return vaccination;
  }

  public async cancelAppointment(id: string, user: UserEntity) {
    const vaccinationRepository = await this.dbService.getRepository(
      VaccinationEntity
    );
    const vaccination = await vaccinationRepository.findOne(id);
    if (!vaccination) {
      throw new VaccinationNotExists();
    }
    if (user instanceof PatientEntity && vaccination.patient.id !== user.id) {
      throw new PermissionDenied();
    }
    if (user instanceof DoctorEntity) {
      if (
        user.isHomeDoctor &&
        vaccination.patient.doctorPatientConnection.doctor.id !== user.id
      ) {
        throw new PermissionDenied();
      }
      if (user.isVaccinatorDoctor && vaccination.vaccinator.id !== user.id) {
        throw new PermissionDenied();
      }
    }
    await vaccinationRepository.delete(vaccination);
  }
}
