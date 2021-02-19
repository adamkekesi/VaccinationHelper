import { Injectable } from "@nestjs/common";
import { DatabaseService } from "src/database/database.service";
import { Authorize } from "src/role/decorator/authorize.decorator";
import { RequiredPermissions } from "src/role/decorator/required-permissions.decorator";
import { Requester } from "src/role/decorator/requester.decorator";
import UserEntity from "./user.entity";
import { AuthCb } from "src/role/decorator/auth-cb.decorator";
import BaseService from "src/shared/base.service";

@Injectable()
export class UserService extends BaseService {
  constructor(private dbService: DatabaseService) {
    super();
  }

  @Authorize()
  @RequiredPermissions({ resource: "user", operation: "get-by-id" })
  public async getById(
    id: string,
    @Requester() user: UserEntity,
    @AuthCb() authCb?: (owner?: string) => Promise<void>
  ) {
    await authCb!(id);
    const userRepository = await this.dbService.getRepository(UserEntity);
    return userRepository.findOne(id);
  }
}
