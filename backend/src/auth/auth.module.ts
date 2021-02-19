import { Module } from "@nestjs/common";
import { AuthController } from "./auth.controller";
import { AuthService } from "./auth.service";
import { DatabaseModule } from "src/database/database.module";
import { EmailModule } from "src/email/email.module";
import { RoleModule } from "src/role/role.module";
import { JwtModule } from "src/jwt/jwt.module";

@Module({
  imports: [DatabaseModule, EmailModule, RoleModule, JwtModule],
  controllers: [AuthController],
  providers: [AuthService],
})
export class AuthModule {}
