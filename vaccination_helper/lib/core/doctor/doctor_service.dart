import 'package:vaccination_helper/core/doctor/doctor_entity.dart';
import 'package:vaccination_helper/helpers/rest/rest_client.dart';

class DoctorService {
  static Future<DoctorEntity> getDoctorById(String id) async {
    return await RestClient.httpGet("doctor/" + id,
        responseDeserializer: DoctorEntity.fromJson);
  }

  static Future<List<DoctorEntity>> getAllHomeDoctors() async {
    return await RestClient.httpGet("doctor/home-doctors",
        responseDeserializer: DoctorEntity.fromJson);
  }

  static Future<List<DoctorEntity>> getAllVaccinatorDoctors() async {
    return await RestClient.httpGet("doctor/vaccinator-doctors",
        responseDeserializer: DoctorEntity.fromJson);
  }

  static Future<DoctorPatientConnectionEntity> acceptPatient(
      String connId) async {
    return await RestClient.httpPut("doctor/accept-patient/" + connId,
        responseDeserializer: DoctorPatientConnectionEntity.fromJson);
  }

  static Future<void> deleteConnection(String connId) async {
    await RestClient.httpDelete(
      "doctor/patient-connection/" + connId,
    );
  }
}
