import { Module } from "@nestjs/common";
import { UserService } from "./user.service";
import { UserController } from "./user.controller";
import { DatabaseModule } from "src/database/database.module";
import { RoleModule } from "src/role/role.module";
import { JwtModule } from "src/jwt/jwt.module";

@Module({
  imports: [DatabaseModule, RoleModule, JwtModule],
  providers: [UserService],
  controllers: [UserController],
})
export class UserModule {}
