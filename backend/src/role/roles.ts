import { IDictionary } from "src/types";
import Operation from "./models/operation.model";
import Resource from "./models/resource.model";
import RoleModel from "./models/role.model";

export const roles: IDictionary<RoleModel> = {
  patient: new RoleModel("patient", [
    new Resource("patient", [
      new Operation("change-home-doctor", false),
      new Operation("set-consent-form", false),
    ]),
    new Resource("vaccination", [
      new Operation("request-vaccination", false),
      new Operation("accept-appointment", false),
    ]),
  ]),

  vaccinatorDoctor: new RoleModel("vaccinatorDoctor", [
    new Resource("vaccination", [new Operation("offer-dates", false)]),
  ]),

  homeDoctor: new RoleModel("homeDoctor", [
    new Resource("doctor", [
      new Operation("get-all-vaccinator-doctors", true),
      new Operation("accept-patient", false),
    ]),
    new Resource("vaccination", [new Operation("choose-vaccinator", false)]),
  ]),
};
