import 'package:vaccination_helper/core/patient/dto/change_home_doctor_dto.dart';
import 'package:vaccination_helper/core/patient/dto/set_consent_form_dto.dart';
import 'package:vaccination_helper/core/patient/patient_entity.dart';
import 'package:vaccination_helper/helpers/rest/rest_client.dart';

class PatientService {
  static Future<PatientEntity> changeHomeDoctor(
      ChangeHomeDoctorDto payload) async {
    return await RestClient.httpPut("patient/change-home-doctor",
        body: payload, responseDeserializer: PatientEntity.fromJson);
  }

  static Future<PatientEntity> setConsentForm(
      String id, SetConsentFormDtoDto payload) async {
    return await RestClient.httpPut("patient/consent-form/" + id,
        body: payload, responseDeserializer: PatientEntity.fromJson);
  }

  static Future<PatientEntity> getPatientById(String id) async {
    return await RestClient.httpGet("patient/" + id,
        responseDeserializer: PatientEntity.fromJson);
  }
}
