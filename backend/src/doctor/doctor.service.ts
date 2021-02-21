import { Injectable } from "@nestjs/common";
import { map } from "p-iteration";
import { DatabaseService } from "src/database/database.service";
import { AuthCb } from "src/role/decorator/auth-cb.decorator";
import { Authorize } from "src/role/decorator/authorize.decorator";
import { Requester } from "src/role/decorator/requester.decorator";
import { RequiredPermissions } from "src/role/decorator/required-permissions.decorator";
import BaseService from "src/shared/base.service";
import PermissionDenied from "src/shared/exceptions/permission-denied.exception";
import UserEntity from "src/user/user.entity";
import DoctorPatientConnectionEntity from "./doctor-patient-connection.entity";
import DoctorEntity from "./doctor.entity";
import DoctorNotExists from "./exception/doctor-not-exists.exception";
import DoctorPatientConnectionNotExists from "./exception/doctor-patient-connection-not-exists.exception";

@Injectable()
export class DoctorService extends BaseService {
  constructor(private dbService: DatabaseService) {
    super();
  }

  public async getDoctorById(id: string, user: UserEntity) {
    const doctorRepository = await this.dbService.getRepository(DoctorEntity);

    const doctor = await doctorRepository.findOne(id, {
      relations: ["doctorPatientConnections", "coordinatedVaccinations"],
    });
    if (!doctor) {
      throw new DoctorNotExists();
    }

    if (!doctor.isHomeDoctor) {
      const hasPermission =
        user.id === doctor.id ||
        user.roleNames.includes("homeDoctor") ||
        doctor.coordinatedVaccinations.some((v) => v.patient.id === user.id);

      if (!hasPermission) {
        throw new PermissionDenied();
      }
    }

    return this.prepareEntity(doctor, user);
  }

  public async getAllHomeDoctors(user: UserEntity) {
    const doctorRepository = await this.dbService.getRepository(DoctorEntity);

    const homeDoctors = await doctorRepository.find({
      where: {
        isHomeDoctor: true,
      },
    });

    return map(
      homeDoctors,
      async (doctor) => this.prepareEntity(doctor, user),
      this
    );
  }

  @Authorize()
  @RequiredPermissions({
    resource: "doctor",
    operation: "get-all-vaccinator-doctors",
  })
  public async getAllVaccinatorDoctors(@Requester() user: UserEntity) {
    const doctorRepository = await this.dbService.getRepository(DoctorEntity);

    const vaccinatorDoctors = await doctorRepository.find({
      where: {
        isVaccinatorDoctor: true,
      },
    });

    return map(
      vaccinatorDoctors,
      async (doctor) => this.prepareEntity(doctor, user),
      this
    );
  }

  @Authorize()
  @RequiredPermissions({
    resource: "doctor",
    operation: "acceptPatient",
  })
  public async acceptPatient(
    id: string,
    @Requester() user: UserEntity,
    @AuthCb() authCb?: (owner?: string) => Promise<void>
  ) {
    const doctorPatientConnectionRepository = await this.dbService.getRepository(
      DoctorPatientConnectionEntity
    );
    const conn = await doctorPatientConnectionRepository.findOne(id);
    if (!conn) {
      throw new DoctorPatientConnectionNotExists();
    }
    await authCb(conn.doctor.id);
    conn.isAccepted = true;
    await doctorPatientConnectionRepository.save(conn);
    return conn;
  }

  public async deleteConnection(id: string, user: UserEntity) {
    const doctorPatientConnectionRepository = await this.dbService.getRepository(
      DoctorPatientConnectionEntity
    );
    const conn = await doctorPatientConnectionRepository.findOne(id);
    if (!conn) {
      throw new DoctorPatientConnectionNotExists();
    }
    const hasPermission =
      conn.doctor.id === user.id || conn.patient.id === user.id;
    if (!hasPermission) {
      throw new PermissionDenied();
    }
    await doctorPatientConnectionRepository.delete(conn);
  }

  private prepareEntity(entity: DoctorEntity, requester: UserEntity) {
    if (entity.id === requester.id) {
      return entity;
    }

    delete entity.doctorPatientConnections;

    const isRequesterAPatient = entity.doctorPatientConnections.some(
      (c) => c.isAccepted && c.patient.id === requester.id
    );
    const isRequesterAHomeDoctor = requester.roleNames.includes("homeDoctor");

    if (isRequesterAPatient || isRequesterAHomeDoctor) {
      return entity;
    }

    delete entity.email;
    delete entity.phoneNumber;
    return entity;
  }
}
