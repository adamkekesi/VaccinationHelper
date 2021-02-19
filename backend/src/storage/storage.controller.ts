import { Controller, Get, Param, Res } from "@nestjs/common";
import { StorageService } from "./storage.service";
import { DatabaseService } from "src/database/database.service";
import { response, Response } from "express";
import { isMongoId } from "class-validator";
import { Authenticate } from "src/auth/decorator/authenticate.decorator";
import { Protected } from "src/auth/decorator/protected.decorator";
import AuthenticatedUser from "src/auth/authenticated-user.model";
import { User } from "src/auth/decorator/authenticated-user.decorator";
import UserEntity from "src/user/user.entity";

@Controller("storage")
export class StorageController {
  constructor(
    private storageService: StorageService,
    private dbService: DatabaseService
  ) {}

  @Get("/user/:userId/profilePicture")
  @Authenticate()
  @Protected()
  public async getProfilePicture(
    @Param("userId") userId: string,
    @User() authenticatedUser: AuthenticatedUser
  ) {
    const userRepository = await this.dbService.getRepository(UserEntity);
    const user = await userRepository.findOne(userId);
    if (!user) {
    }
  }
}
