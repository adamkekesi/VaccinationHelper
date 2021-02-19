import {
  Logger,
  Module,
  OnApplicationShutdown,
  OnModuleInit,
} from "@nestjs/common";
import { APP_FILTER, APP_INTERCEPTOR } from "@nestjs/core";
import { AppController } from "./app.controller";
import { AuthInterceptor } from "./auth/interceptor/auth.interceptor";
import { UnhandledExceptionFilter } from "./shared/exception-filters/unhandled-exception.filter";
import { JwtModule } from "./jwt/jwt.module";
import ErrorHandler from "./shared/handlers/error.handler";
import { DatabaseModule } from "./database/database.module";
import { RoleModule } from "./role/role.module";
import { AuthModule } from "./auth/auth.module";
import { UserModule } from "./user/user.module";
import { EmailModule } from "./email/email.module";
import { CqrsModule } from "@nestjs/cqrs";
import { DatabaseService } from "./database/database.service";
import { EmailService } from "./email/email.service";
import { PatientModule } from "./patient/patient.module";
import { DoctorModule } from "./doctor/doctor.module";
import { StorageModule } from "./storage/storage.module";

@Module({
  imports: [
    JwtModule,
    DatabaseModule,
    RoleModule,
    AuthModule,
    UserModule,
    EmailModule,
    CqrsModule,
    PatientModule,
    DoctorModule,
    StorageModule,
  ],
  controllers: [AppController],
  providers: [
    { provide: APP_INTERCEPTOR, useClass: AuthInterceptor },
    { provide: APP_FILTER, useClass: UnhandledExceptionFilter },
    ErrorHandler,
  ],
})
export class AppModule implements OnModuleInit, OnApplicationShutdown {
  constructor(
    private dbService: DatabaseService,
    private emailService: EmailService
  ) {}

  public onModuleInit() {
    this.dbService.startConnecting();
    this.emailService.initMailer();
  }

  public async onApplicationShutdown() {
    Logger.log("Application shutting down...", "AppModule");
    await this.dbService.disconnect();
  }
}
