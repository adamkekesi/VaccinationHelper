import { Injectable } from "@nestjs/common";
import { DatabaseService } from "src/database/database.service";
import UserEntity from "src/user/user.entity";
import LoginDto from "./dto/login.dto";
import { verify, hash } from "argon2";
import { hashingConfig } from "src/auth/config/hashing.config";
import AuthTokenEntity from "./entity/auth-token.entity";
import AuthenticatedUser from "./authenticated-user.model";
import RegisterDto from "./dto/register.dto";
import { TokenType } from "src/types";
import TokenEntity from "./entity/token.entity";
import { EmailService } from "src/email/email.service";
import PasswordResetDto from "./dto/password-reset.dto";
import BaseService from "src/shared/base.service";
import UserNotVerified from "src/shared/exceptions/user-not-verified.exception";
import UserAlreadyExists from "src/shared/exceptions/user-already-exists.exception";
import UserNotExists from "src/shared/exceptions/user-not-exists.exception";
import JwtService from "src/jwt/jwt.service";
import InvalidCredentials from "./exception/invalid-credentials.exception";
import InvalidToken from "./exception/invalid-token.exception";

@Injectable()
export class AuthService extends BaseService {
  constructor(
    private dbService: DatabaseService,
    private jwtService: JwtService,
    private emailService: EmailService
  ) {
    super();
  }

  public async login(credentials: LoginDto) {
    const userRepository = await this.dbService.getRepository(UserEntity);
    const authTokenRepository = await this.dbService.getRepository(
      AuthTokenEntity
    );
    const user = await userRepository.findOne({
      where: { username: credentials.username },
    });
    if (
      !user ||
      !(await verify(user.password, credentials.password, hashingConfig))
    ) {
      throw new InvalidCredentials();
    }
    if (!user.verified) {
      throw new UserNotVerified();
    }
    const token = await authTokenRepository.save(new AuthTokenEntity(user));
    return { user, jwt: await this.jwtService.createJwt(token) };
  }

  public async logout(user: AuthenticatedUser) {
    const authTokenRepository = await this.dbService.getRepository(
      AuthTokenEntity
    );
    await authTokenRepository.delete(user.token.id);
  }

  public async register(registerDto: RegisterDto) {
    const userRepository = await this.dbService.getRepository(UserEntity);

    if (
      await userRepository.findOne({
        where: [
          { username: registerDto.username },
          { email: registerDto.email },
        ],
      })
    ) {
      throw new UserAlreadyExists();
    }

    const hashedPassword = await hash(registerDto.password, {
      ...hashingConfig,
      raw: false,
    });

    const user = await userRepository.save(
      new UserEntity(registerDto.email, registerDto.username, hashedPassword)
    );
    await this.sendEmailVerification(user);
    return user;
  }

  public async sendPasswordReset(email: string) {
    const userRepository = await this.dbService.getRepository(UserEntity);
    const target = await userRepository.findOne({ where: { email } });
    if (!target) {
      return;
    }
    const tokenRepository = await this.dbService.getRepository(TokenEntity);
    const resetToken = await tokenRepository.save(
      new TokenEntity(target, TokenType.PasswordReset, new Date(0, 0, 0, 2))
    );
    await this.emailService.sendPasswordReset(target, resetToken);
  }

  public async resetPassword(payload: PasswordResetDto) {
    const tokenRepository = await this.dbService.getRepository(TokenEntity);
    const token = await tokenRepository.findOne(payload.token);
    if (!token?.isValid(TokenType.PasswordReset)) {
      throw new InvalidToken();
    }
    const userRepository = await this.dbService.getRepository(UserEntity);
    const user = token.user;
    if (!user) {
      throw new UserNotExists();
    }
    await tokenRepository.delete(token);
    user.password = await hash(payload.password, {
      ...hashingConfig,
      raw: false,
    });
    await userRepository.save(user);
  }

  public async sendEmailVerification(email: string | UserEntity) {
    var target: UserEntity;
    if (typeof email === "string") {
      const userRepository = await this.dbService.getRepository(UserEntity);
      target = await userRepository.findOne({ where: { email } });
      if (!target) {
        return;
      }
    } else {
      target = email;
    }

    const tokenRepository = await this.dbService.getRepository(TokenEntity);
    const token = await tokenRepository.save(
      new TokenEntity(target, TokenType.EmailVerification, new Date(0, 0, 0, 6))
    );
    await this.emailService.sendEmailVerification(target, token);
  }

  public async verifyEmail(token: string) {
    const tokenRepository = await this.dbService.getRepository(TokenEntity);
    const verificationToken = await tokenRepository.findOne(token);
    if (!verificationToken?.isValid(TokenType.EmailVerification)) {
      throw new InvalidToken();
    }
    const userRepository = await this.dbService.getRepository(UserEntity);
    const user = verificationToken.user;
    if (!user) {
      throw new UserNotExists();
    }
    await tokenRepository.delete(verificationToken);
    user.verified = true;
    await userRepository.save(user);
  }
}
