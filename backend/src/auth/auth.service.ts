import { Injectable } from "@nestjs/common";
import { DatabaseService } from "src/database/database.service";
import UserEntity from "src/user/user.entity";
import LoginDto from "./dto/login.dto";
import { verify, hash } from "argon2";
import { hashingConfig } from "src/auth/config/hashing.config";
import AuthTokenEntity from "./entity/auth-token.entity";
import AuthenticatedUser from "./authenticated-user.model";
import BaseService from "src/shared/base.service";
import UserNotVerified from "src/shared/exceptions/user-not-verified.exception";
import UserAlreadyExists from "src/shared/exceptions/user-already-exists.exception";
import JwtService from "src/jwt/jwt.service";
import InvalidCredentials from "./exception/invalid-credentials.exception";
import PatientRegisterDto from "./dto/patient-register.dto";
import PatientEntity from "src/patient/patient.entity";
import AddressModel from "src/patient/address.model";
import DoctorEntity from "src/doctor/doctor.entity";
import DoctorRegisterDto from "./dto/doctor-register.dto";
import { StorageService } from "src/storage/storage.service";
import InvalidFields from "src/shared/exceptions/invalid-fields.exception";

@Injectable()
export class AuthService extends BaseService {
  constructor(
    private dbService: DatabaseService,
    private jwtService: JwtService,
    private storageService: StorageService
  ) {
    super();
  }

  public async login(credentials: LoginDto) {
    const userRepository = await this.dbService.getRepository(UserEntity);
    const authTokenRepository = await this.dbService.getRepository(
      AuthTokenEntity
    );
    const user = await userRepository.findOne({
      where: { email: credentials.email },
    });
    if (
      !user ||
      !(await verify(user.password, credentials.password, hashingConfig))
    ) {
      throw new InvalidCredentials();
    }
    const token = await authTokenRepository.save(new AuthTokenEntity(user));
    return {
      user: await this.prepareEntity(user),
      jwt: await this.jwtService.createJwt(token),
    };
  }

  public async logout(user: AuthenticatedUser) {
    const authTokenRepository = await this.dbService.getRepository(
      AuthTokenEntity
    );
    await authTokenRepository.delete(user.token.id);
  }

  public async registerPatient(
    registerDto: PatientRegisterDto,
    profilePicture: Express.Multer.File
  ) {
    const userRepository = await this.dbService.getRepository(UserEntity);
    const patientRepository = await this.dbService.getRepository(PatientEntity);

    if (
      (await userRepository.findOne({
        where: [{ email: registerDto.email }],
      })) ||
      (await patientRepository.findOne({
        where: [
          { identityCardNumber: registerDto.identityCardNumber },
          { ssn: registerDto.ssn },
        ],
      }))
    ) {
      throw new UserAlreadyExists();
    }

    const hashedPassword = await hash(registerDto.password, {
      ...hashingConfig,
      raw: false,
    });

    const patient = new PatientEntity(
      registerDto.email,
      registerDto.fullName,
      registerDto.phoneNumber,
      hashedPassword,
      new AddressModel(
        registerDto.address.zipCode,
        registerDto.address.city,
        registerDto.address.address
      ),
      registerDto.dateOfBirth,
      registerDto.identityCardNumber,
      registerDto.ssn
    );

    this.roleHelper.givePatientRole(patient);

    await patientRepository.save(patient);

    if (profilePicture) {
      await this.storageService.saveFiles([profilePicture], patient);
    }

    return this.prepareEntity(patient);
  }

  public async registerDoctor(
    registerDto: DoctorRegisterDto,
    profilePicture: Express.Multer.File
  ) {
    const userRepository = await this.dbService.getRepository(UserEntity);
    const doctorRepository = await this.dbService.getRepository(DoctorEntity);

    if (
      await userRepository.findOne({
        where: [{ email: registerDto.email }],
      })
    ) {
      throw new UserAlreadyExists();
    }

    const hashedPassword = await hash(registerDto.password, {
      ...hashingConfig,
      raw: false,
    });

    const doctor = await doctorRepository.save(
      new DoctorEntity(
        registerDto.email,
        registerDto.fullName,
        registerDto.phoneNumber,
        hashedPassword,
        registerDto.city,
        registerDto.isHomeDoctor,
        registerDto.isVaccinatorDoctor
      )
    );

    if (doctor.isHomeDoctor) {
      this.roleHelper.giveHomeDoctorRole(doctor);
    }

    if (doctor.isVaccinatorDoctor) {
      this.roleHelper.giveVaccinatorDoctorRole(doctor);
    }

    await this.storageService.saveFiles([profilePicture], doctor);

    return this.prepareEntity(doctor);
  }

  private async prepareEntity(entity: UserEntity) {
    if (entity instanceof DoctorEntity) {
      entity.type = "DoctorEntity";
    }
    if (entity instanceof PatientEntity) {
      entity.type = "PatientEntity";
    }
    return entity;
  }
}
