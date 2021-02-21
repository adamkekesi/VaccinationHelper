import 'package:json_annotation/json_annotation.dart';
import 'package:vaccination_helper/core/doctor/doctor_entity.dart';
import 'package:vaccination_helper/core/patient/patient_entity.dart';

part 'vaccination_entity.g.dart';

@JsonSerializable()
class VaccinationEntity {
  String id;
  PatientEntity patient;
  DoctorEntity vaccinator;
  DateTime scheduledDate;
  List<DateTime> offeredAppointments;

  VaccinationEntity();

  static VaccinationEntity fromJson(Map<String, dynamic> json) {
    return _$VaccinationEntityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VaccinationEntityToJson(this);
}
