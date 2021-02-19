import { Module } from "@nestjs/common";
import { AuthController } from "./auth.controller";
import { AuthService } from "./auth.service";
import { DatabaseModule } from "src/database/database.module";
import { RoleModule } from "src/role/role.module";
import { JwtModule } from "src/jwt/jwt.module";
import { MulterModule } from "@nestjs/platform-express";
import { StorageModule } from "src/storage/storage.module";
import MulterConfigService from "src/storage/multer-config.service";

@Module({
  imports: [
    DatabaseModule,
    RoleModule,
    JwtModule,
    MulterModule.registerAsync({
      imports: [StorageModule],
      useClass: MulterConfigService,
    }),
    StorageModule,
  ],
  controllers: [AuthController],
  providers: [AuthService],
})
export class AuthModule {}
