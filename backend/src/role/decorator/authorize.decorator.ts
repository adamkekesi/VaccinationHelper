import AclMetadata from "./metadata/acl.metadata";
import UserEntity from "src/user/user.entity";
import Unauthorized from "../../shared/exceptions/unauthorized.exception";
import RoleHelper from "src/role/role.helper";
import PermissionDenied from "../../shared/exceptions/permission-denied.exception";
import { InternalServerErrorException } from "@nestjs/common";

export function Authorize() {
  return (target: any, propertyKey: string, descriptor: PropertyDescriptor) => {
    const handler = descriptor.value;
    descriptor.value = async function (this: { roleHelper: RoleHelper }) {
      const meta: AclMetadata = Reflect.getMetadata("acl", target);
      if (!meta) {
        return handler.bind(this)(...arguments);
      }
      const handlerMeta = meta.handlers[propertyKey];
      if (!handlerMeta) {
        return handler.bind(this)(...arguments);
      }
      const args = [...arguments];
      const authCbIndex = handlerMeta.paramMetas["auth-cb"];
      if (handlerMeta.requiredPermissions.length === 0) {
        return handler.bind(this)(...arguments);
      }
      const authorizationCb = async (owner?: string) => {
        const userIndex = handlerMeta.paramMetas["user"];
        if (userIndex === undefined) {
          throw new InternalServerErrorException();
        }
        const user: UserEntity = args[userIndex];
        if (!user) {
          throw new Unauthorized();
        }
        if (
          !(await this.roleHelper.checkPermissions(
            user,
            handlerMeta.requiredPermissions,
            owner
          ))
        ) {
          throw new PermissionDenied();
        }
      };
      if (authCbIndex !== undefined) {
        args[authCbIndex] = authorizationCb;
        return handler.bind(this)(...args);
      } else {
        await authorizationCb();
        return handler.bind(this)(...args);
      }
    };
  };
}
