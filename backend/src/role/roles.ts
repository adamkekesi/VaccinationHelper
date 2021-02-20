import { IDictionary } from "src/types";
import RoleModel from "./models/role.model";

export const roles: IDictionary<RoleModel> = {
  patient: new RoleModel("patient", []),
  vaccinatorDoctor: new RoleModel("vaccinatorDoctor", []),

  homeDoctor: new RoleModel("homeDoctor", []),
};
