import {
  Controller,
  Post,
  Body,
  UseInterceptors,
  UploadedFile,
} from "@nestjs/common";
import { AuthService } from "./auth.service";
import LoginDto from "./dto/login.dto";
import AuthenticatedUser from "./authenticated-user.model";
import Response from "src/shared/Response";
import InvalidAuthToken from "src/auth/exception/invalid-auth-token.exception";
import LoginResponse from "./response/login.response";
import { Authenticate } from "./decorator/authenticate.decorator";
import { User } from "./decorator/authenticated-user.decorator";
import PatientRegisterDto from "./dto/patient-register.dto";
import DoctorRegisterDto from "./dto/doctor-register.dto";
import { UploadCleanupInterceptor } from "src/storage/interceptors/upload-cleanup.interceptor";
import { BeforeSerialization } from "src/shared/decorators/before-serialization.decorator";
import {
  FileFieldsInterceptor,
  FileInterceptor,
} from "@nestjs/platform-express";
import InvalidFields from "src/shared/exceptions/invalid-fields.exception";

@Controller("auth")
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post("/login")
  @Authenticate()
  public async login(
    @Body() loginDto: LoginDto,
    @User() authenticatedUser: AuthenticatedUser
  ) {
    if (authenticatedUser) {
      return new LoginResponse(authenticatedUser.user, undefined);
    }
    const result = await this.authService.login(loginDto);
    return new LoginResponse(result.user, result.jwt);
  }

  @Post("/logout")
  @Authenticate()
  public async logout(@User() authenticatedUser: AuthenticatedUser) {
    if (authenticatedUser) {
      await this.authService.logout(authenticatedUser);
    }
  }

  @Post("/jwtlogin")
  @Authenticate()
  public async jwtlogin(@User() authenticatedUser: AuthenticatedUser) {
    if (!authenticatedUser) {
      throw new InvalidAuthToken();
    }
    return new LoginResponse(authenticatedUser.user, undefined);
  }

  @Post("/register-patient")
  /* @UseInterceptors(UploadCleanupInterceptor)
  @BeforeSerialization(FileInterceptor("profilePicture")) */
  public async registerPatient(
    @Body() registerDto: PatientRegisterDto,
    @UploadedFile() file: Express.Multer.File
  ) {
    /* if (!file) {
      throw InvalidFields.fromOneInvalidField("profilePicture", [
        "profilePicture-empty",
      ]);
    } */
    const user = await this.authService.registerPatient(registerDto, file);
    return new Response({ data: user });
  }

  @Post("/register-doctor")
  /* @UseInterceptors(UploadCleanupInterceptor)
  @BeforeSerialization(FileInterceptor("profilePicture")) */
  public async registerDoctor(
    @Body() registerDto: DoctorRegisterDto,
    @UploadedFile() file: Express.Multer.File
  ) {
    /* if (!file) {
      throw InvalidFields.fromOneInvalidField("profilePicture", [
        "profilePicture-empty",
      ]);
    } */
    if (!registerDto.isHomeDoctor && !registerDto.isVaccinatorDoctor) {
      throw InvalidFields.fromInvalidFields({
        isHomeDoctor: { errorCodes: ["isHomeDoctor-no-doctor-type-selected"] },
        isVaccinatorDoctor: {
          errorCodes: ["isVaccinatorDoctor-no-doctor-type-selected"],
        },
      });
    }
    const user = await this.authService.registerDoctor(registerDto, file);
    return new Response({ data: user });
  }
}
