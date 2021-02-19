import RoleHelper from "src/role/role.helper";
import { Inject, Injectable } from "@nestjs/common";

@Injectable()
export default class BaseService {
  @Inject(RoleHelper)
  protected roleHelper: RoleHelper;
}
