import { Module } from "@nestjs/common";
import { StorageService } from "./storage.service";
import { StorageController } from "./storage.controller";
import MulterConfigService from "./multer-config.service";
import { DatabaseModule } from "src/database/database.module";

@Module({
  imports: [DatabaseModule],
  providers: [MulterConfigService, StorageService],
  exports: [MulterConfigService, StorageService],
  controllers: [StorageController]
})
export class StorageModule {}
