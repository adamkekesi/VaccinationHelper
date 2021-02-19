import 'dart:io';

import 'package:vaccination_helper/core/auth/dtos/email_verification_dto.dart';
import 'package:vaccination_helper/core/auth/dtos/email_verification_request_dto.dart';
import 'package:vaccination_helper/core/auth/dtos/login_dto.dart';
import 'package:vaccination_helper/core/auth/dtos/password_reset_dto.dart';
import 'package:vaccination_helper/core/auth/dtos/password_reset_request_dto.dart';
import 'package:vaccination_helper/core/auth/dtos/register_dto.dart';
import 'package:vaccination_helper/core/auth/responses/login_response.dart';
import 'package:vaccination_helper/core/user/user_entity.dart';
import 'package:vaccination_helper/helpers/rest/rest_client.dart';

class AuthService {
  static Future<LoginResponse> login(LoginDto payload) async {
    return await RestClient.httpPost("auth/login",
        body: payload, responseDeserializer: LoginResponse.fromJson);
  }

  static Future<void> logout() async {
    await RestClient.httpPost("auth/logout");
  }

  static Future<LoginResponse> jwtlogin() async {
    return await RestClient.httpPost("auth/jwtlogin",
        responseDeserializer: LoginResponse.fromJson);
  }

  static Future<UserEntity> register(RegisterDto payload) async {
    return await RestClient.httpPost("auth/register",
        responseDeserializer: UserEntity.fromJson, body: payload);
  }

  static Future<void> sendPasswordReset(PasswordResetRequestDto payload) async {
    await RestClient.httpPost("auth/request-password-reset", body: payload);
  }

  static Future<void> resetPassword(PasswordResetDto payload) async {
    await RestClient.httpPost("auth/reset-password", body: payload);
  }

  static Future<void> sendEmailVerification(
      EmailVerificationRequestDto payload) async {
    await RestClient.httpPost("auth/request-email-verification", body: payload);
  }

  static Future<void> verifyEmail(EmailVerificationDto payload) async {
    await RestClient.httpPost("auth/verify-email", body: payload);
  }
}
