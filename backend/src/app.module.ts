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
import { CaptchaModule } from "./captcha/captcha.module";
import ErrorHandler from "./shared/handlers/error.handler";
import { DatabaseModule } from "./database/database.module";
import { RoleModule } from "./role/role.module";
import { AuthModule } from "./auth/auth.module";
import { UserModule } from "./user/user.module";
import { EmailModule } from "./email/email.module";
import { CqrsModule } from "@nestjs/cqrs";
import { DatabaseService } from "./database/database.service";
import { EmailService } from "./email/email.service";

@Module({
  imports: [
    JwtModule,
    CaptchaModule,
    DatabaseModule,
    RoleModule,
    AuthModule,
    UserModule,
    EmailModule,
    CqrsModule,
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
