import AuthTokenEntity from "src/auth/entity/auth-token.entity";
import TokenEntity from "src/auth/entity/token.entity";
import RoleEntity from "src/role/role.entity";
import UserEntity from "src/user/user.entity";
import { PostgresConnectionOptions } from "typeorm/driver/postgres/PostgresConnectionOptions";

export const dbConfig: PostgresConnectionOptions = {
  type: "postgres",
  entities: [RoleEntity, UserEntity, AuthTokenEntity, TokenEntity],
  synchronize: true,
  url: process.env.POSTGRES_CONNECTION_STRING,
};
