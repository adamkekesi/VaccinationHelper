import Response from "src/shared/Response";
import UserEntity from "src/user/user.entity";
import { Serializable } from "typescript-json-serializer";

@Serializable()
export default class LoginResponse extends Response {
  public data: { user: UserEntity; jwt?: string };

  constructor(user: UserEntity, jwt?: string) {
    super({ data: { user, jwt } });
  }
}
