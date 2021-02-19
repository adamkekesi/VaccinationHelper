import { Controller, Post, Body } from "@nestjs/common";
import { AuthService } from "./auth.service";
import LoginDto from "./dto/login.dto";
import AuthenticatedUser from "./authenticated-user.model";
import { CaptchaCheckerPipe } from "src/captcha/captcha-checker.pipe";
import Response from "src/shared/Response";
import InvalidAuthToken from "src/auth/exception/invalid-auth-token.exception";
import RegisterDto from "./dto/register.dto";
import PasswordResetRequestDto from "./dto/password-reset-request.dto";
import PasswordResetDto from "./dto/password-reset.dto";
import EmailVerificationRequestDto from "./dto/email-verification-request.dto";
import EmailVerificationDto from "./dto/email-verification.dto";
import LoginResponse from "./response/login.response";
import { Authenticate } from "./decorator/authenticate.decorator";
import { User } from "./decorator/authenticated-user.decorator";

@Controller("auth")
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post("/login")
  @Authenticate()
  public async login(
    @Body(CaptchaCheckerPipe) loginDto: LoginDto,
    @User() authenticatedUser: AuthenticatedUser
  ) {
    if (authenticatedUser) {
      return new LoginResponse(authenticatedUser.user, undefined);
    }
    return await this.authService.login(loginDto);
  }

  @Post("/logout")
  @Authenticate()
  public async logout(@User() authenticatedUser: AuthenticatedUser) {
    if (authenticatedUser) {
      await this.authService.logout(authenticatedUser);
    }
  }

  @Post("/jwtlogin")
  @Authenticate()
  public async jwtlogin(@User() authenticatedUser: AuthenticatedUser) {
    if (!authenticatedUser) {
      throw new InvalidAuthToken();
    }
    return new LoginResponse(authenticatedUser.user, undefined);
  }

  @Post("/register")
  public async register(@Body(CaptchaCheckerPipe) registerDto: RegisterDto) {
    const user = await this.authService.register(registerDto);
    return new Response({ data: user });
  }

  @Post("/request-password-reset")
  public async sendPasswordReset(
    @Body(CaptchaCheckerPipe) payload: PasswordResetRequestDto
  ) {
    await this.authService.sendPasswordReset(payload.email);
  }

  @Post("/reset-password")
  public async resetPassword(
    @Body(CaptchaCheckerPipe) payload: PasswordResetDto
  ) {
    await this.authService.resetPassword(payload);
  }

  @Post("/request-email-verification")
  public async sendEmailVerification(
    @Body(CaptchaCheckerPipe) payload: EmailVerificationRequestDto
  ) {
    await this.authService.sendEmailVerification(payload.email);
  }

  @Post("/verify-email")
  public async verifyEmail(
    @Body(CaptchaCheckerPipe) payload: EmailVerificationDto
  ) {
    await this.authService.verifyEmail(payload.token);
  }
}
