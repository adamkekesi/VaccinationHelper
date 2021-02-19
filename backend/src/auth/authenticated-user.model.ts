import UserEntity from "src/user/user.entity";
import AuthTokenEntity from "./entity/auth-token.entity";

export default class AuthenticatedUser {
  constructor(
    public user: UserEntity,

    public token: AuthTokenEntity
  ) {}
}
