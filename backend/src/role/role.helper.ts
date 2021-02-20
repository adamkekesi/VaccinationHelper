import { Injectable } from "@nestjs/common";
import UserEntity from "src/user/user.entity";
import Resource from "./models/resource.model";
import RoleModel from "./models/role.model";

@Injectable()
export default class RoleHelper {
  constructor() {}

  public async checkPermissions(
    user: UserEntity,
    permissions: Array<Array<{ resource: string; operation: string }>>,
    resourceOwnerId?: string
  ) {
    const roles = user.roles;
    const grants = roles.reduce((previous: Resource[], current: RoleModel) => {
      previous.push(...current.grants);
      return previous;
    }, [] as Resource[]);

    return permissions.some((or) =>
      or.every((and) => {
        return grants.some(
          (g) =>
            g.name === and.resource &&
            g.operations.some(
              (o) =>
                o.name === and.operation &&
                (o.every || resourceOwnerId === user.id)
            )
        );
      })
    );
  }

  public givePatientRole(user: UserEntity) {
    user.roleNames.push("patient");
    user.populateRoles();
  }

  public giveHomeDoctorRole(user: UserEntity) {
    user.roleNames.push("homeDoctor");
    user.populateRoles();
  }

  public giveVaccinatorDoctorRole(user: UserEntity) {
    user.roleNames.push("vaccinatorDoctor");
    user.populateRoles();
  }
}
