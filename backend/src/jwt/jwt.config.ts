import { SignOptions } from "jsonwebtoken";

export const jwtConfig = {
  secret: "secret",
  signOptions: {
    issuer: "test",
    algorithm: "HS512",
  } as SignOptions,
};
