import { Injectable } from "@nestjs/common";
import { map } from "p-iteration";
import { doc } from "prettier";
import { DatabaseService } from "src/database/database.service";
import DoctorPatientConnectionEntity from "src/doctor/doctor-patient-connection.entity";
import DoctorEntity from "src/doctor/doctor.entity";
import DoctorNotExists from "src/doctor/exception/doctor-not-exists.exception";
import { AuthCb } from "src/role/decorator/auth-cb.decorator";
import { Authorize } from "src/role/decorator/authorize.decorator";
import { Requester } from "src/role/decorator/requester.decorator";
import { RequiredPermissions } from "src/role/decorator/required-permissions.decorator";
import BaseService from "src/shared/base.service";
import InvalidFields from "src/shared/exceptions/invalid-fields.exception";
import PermissionDenied from "src/shared/exceptions/permission-denied.exception";
import UserEntity from "src/user/user.entity";
import ChangeHomeDoctorDto from "./dto/change-home-doctor.dto";
import SetConsentFormDto from "./dto/set-consent-form.dto";
import PatientNotExists from "./exception/patient-not-exists.exception";
import AnswerModel from "./model/answer.model";
import ConsentFormModel from "./model/consent-form.model";
import PatientEntity from "./patient.entity";

@Injectable()
export class PatientService extends BaseService {
  constructor(private dbService: DatabaseService) {
    super();
  }

  public async getPatientById(id: string, user: UserEntity) {
    const patientRepository = await this.dbService.getRepository(PatientEntity);
    const patient = await patientRepository.findOne(id, {
      relations: ["doctorPatientConnection", "vaccinationsInProgress"],
    });
    if (!patient) {
      throw new PatientNotExists();
    }

    const isSelf = user.id === patient.id;
    const isHomeDoctorOfPatient =
      patient.doctorPatientConnection.doctor.id === user.id;
    const isVaccinatorOfPatient = patient.vaccinationsInProgress.some(
      (v) => v.vaccinator?.id === user.id
    );

    if (!(isSelf || isHomeDoctorOfPatient || isVaccinatorOfPatient)) {
      throw new PermissionDenied();
    }

    return this.prepareEntity(patient, user);
  }

  @Authorize()
  @RequiredPermissions({ operation: "patient", resource: "change-home-doctor" })
  public async changeHomeDoctor(
    payload: ChangeHomeDoctorDto,
    @Requester() user: UserEntity,
    @AuthCb() authCb?: (owner?: string) => Promise<void>
  ) {
    const patientRepository = await this.dbService.getRepository(PatientEntity);
    const doctorRepository = await this.dbService.getRepository(DoctorEntity);
    const doctorPatientConnectionRepository = await this.dbService.getRepository(
      DoctorPatientConnectionEntity
    );
    await authCb(payload.patientId);
    const patient = await patientRepository.findOne(payload.patientId, {
      relations: ["doctorPatientConnection", "vaccinationsInProgress"],
    });
    if (!patient) {
      throw new PatientNotExists();
    }
    const doctor = await doctorRepository.findOne(payload.doctorId, {
      relations: ["doctorPatientConnections", "coordinatedVaccinations"],
    });
    if (!doctor) {
      throw new DoctorNotExists();
    }
    if (!doctor.isHomeDoctor) {
      throw InvalidFields.fromOneInvalidField("doctorId", [
        "doctorId-not-home-doctor",
      ]);
    }
    if (patient.doctorPatientConnection) {
      await doctorPatientConnectionRepository.delete(
        patient.doctorPatientConnection
      );
    }
    const conn = await doctorPatientConnectionRepository.save(
      new DoctorPatientConnectionEntity(patient, doctor)
    );

    patient.doctorPatientConnection = conn;
    return this.prepareEntity(patient, user);
  }

  @Authorize()
  @RequiredPermissions({
    resource: "patient",
    operation: "set-consent-form",
  })
  public async setConsentForm(
    id: string,
    payload: SetConsentFormDto,
    @Requester() user: UserEntity,
    @AuthCb() authCb?: (owner?: string) => Promise<void>
  ) {
    const patientRepository = await this.dbService.getRepository(PatientEntity);
    const patient = await patientRepository.findOne(id);
    if (!patient) {
      throw new PatientNotExists();
    }
    await authCb(patient.id);
    patient.consentForm = new ConsentFormModel(
      payload.answers.map((a) => new AnswerModel(a.questionId, a.answer))
    );

    await patientRepository.save(patient);
    return patient;
  }

  private prepareEntity(entity: PatientEntity, requester: UserEntity) {
    return entity;
  }
}
