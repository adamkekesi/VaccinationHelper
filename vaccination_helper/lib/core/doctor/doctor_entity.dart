import 'package:json_annotation/json_annotation.dart';
import 'package:vaccination_helper/core/auth/vaccination/vaccination_entity.dart';
import 'package:vaccination_helper/core/patient/patient_entity.dart';
import 'package:vaccination_helper/core/role/entity/role_entity.dart';
import 'package:vaccination_helper/core/user/user_entity.dart';

part 'doctor_entity.g.dart';

@JsonSerializable()
class DoctorEntity extends UserEntity {
  String city;
  bool isHomeDoctor;
  bool isVaccinatorDoctor;
  List<DoctorPatientConnectionEntity> doctorPatientConnections;
  List<VaccinationEntity> coordinatedVaccinations;

  DoctorEntity();

  static DoctorEntity fromJson(Map<String, dynamic> json) {
    return _$DoctorEntityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DoctorEntityToJson(this);
}

@JsonSerializable()
class DoctorPatientConnectionEntity {
  String id;
  PatientEntity patient;
  DoctorEntity doctor;
  bool isAccepted;

  DoctorPatientConnectionEntity();

  static DoctorPatientConnectionEntity fromJson(Map<String, dynamic> json) {
    return _$DoctorPatientConnectionEntityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DoctorPatientConnectionEntityToJson(this);
}
