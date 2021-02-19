import { Injectable } from "@nestjs/common";
import AuthTokenEntity from "src/auth/entity/auth-token.entity";
import { sign, Secret, SignOptions, verify, VerifyOptions } from "jsonwebtoken";
import { jwtConfig } from "src/jwt/jwt.config";

@Injectable()
export default class JwtService {
  public createJwt(authToken: AuthTokenEntity) {
    return asyncSign(
      { tokenId: authToken.id },
      Buffer.from(jwtConfig.secret, "base64"),
      jwtConfig.signOptions
    );
  }

  public async decodeJwt(jwt: string) {
    const result = await asyncVerify(
      jwt,
      Buffer.from(jwtConfig.secret, "base64"),
      jwtConfig.signOptions
    );
    return result;
  }
}

function asyncSign(payload: any, secret: Secret, options?: SignOptions) {
  return new Promise<string>((resolve, reject) => {
    sign(payload, secret, options, (err: Error, encoded: string) => {
      if (err) {
        return reject(err);
      }
      return resolve(encoded);
    });
  });
}

function asyncVerify(token: string, secret: Secret, options?: VerifyOptions) {
  return new Promise<{ iat: number; iss: string; tokenId: string }>(
    (resolve, reject) => {
      verify(token, secret, options, (err: Error, decoded: any) => {
        if (err) {
          return reject(err);
        }
        return resolve(decoded);
      });
    }
  );
}
