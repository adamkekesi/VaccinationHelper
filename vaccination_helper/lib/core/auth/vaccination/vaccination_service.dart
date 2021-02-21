import 'package:vaccination_helper/core/auth/vaccination/dto/accept_appointment_dto.dart';
import 'package:vaccination_helper/core/auth/vaccination/dto/choose_vaccinator_dto.dart';
import 'package:vaccination_helper/core/auth/vaccination/dto/offer_appointments_dto.dart';
import 'package:vaccination_helper/core/auth/vaccination/vaccination_entity.dart';
import 'package:vaccination_helper/helpers/rest/rest_client.dart';

class VaccinationService {
  static Future<VaccinationEntity> chooseVaccinator(
      ChooseVaccinatorDto payload) async {
    return await RestClient.httpPut("vaccination/choose-vaccinator",
        body: payload, responseDeserializer: VaccinationEntity.fromJson);
  }

  static Future<VaccinationEntity> offerAppointments(
      OfferAppointmentsDto payload) async {
    return await RestClient.httpPut("vaccination/offer-appointments",
        body: payload, responseDeserializer: VaccinationEntity.fromJson);
  }

  static Future<VaccinationEntity> acceptAppointment(
      AcceptAppointmentDto payload) async {
    return await RestClient.httpPut("vaccination/accept-appointment",
        body: payload, responseDeserializer: VaccinationEntity.fromJson);
  }

  static Future<void> cancelAppointment(String vaccId) async {
    return await RestClient.httpDelete(
        "vaccination/cancel-appointment/" + vaccId,
        responseDeserializer: VaccinationEntity.fromJson);
  }

  static Future<VaccinationEntity> requestVaccination(String patientId) async {
    return await RestClient.httpPost("vaccination/:id",
        responseDeserializer: VaccinationEntity.fromJson);
  }
}
