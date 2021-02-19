import 'dart:io';

import 'package:vaccination_helper/core/auth/dtos/doctor_register_dto.dart';
import 'package:vaccination_helper/core/auth/dtos/login_dto.dart';
import 'package:vaccination_helper/core/auth/dtos/patient_register_dto.dart';
import 'package:vaccination_helper/core/auth/responses/login_response.dart';
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

  static Future<LoginResponse> registerDoctor(DoctorRegisterDto payload) async {
    return await RestClient.httpPost("auth/register-doctor",
        body: payload, responseDeserializer: LoginResponse.fromJson);
  }

  static Future<LoginResponse> registerPatient(
      PatientRegisterDto payload) async {
    return await RestClient.httpPost("auth/register-patient",
        body: payload, responseDeserializer: LoginResponse.fromJson);
  }
}
