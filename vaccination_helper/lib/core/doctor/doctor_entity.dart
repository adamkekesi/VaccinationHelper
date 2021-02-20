import 'package:json_annotation/json_annotation.dart';
import 'package:vaccination_helper/core/role/entity/role_entity.dart';
import 'package:vaccination_helper/core/user/user_entity.dart';

part 'doctor_entity.g.dart';

@JsonSerializable()
class DoctorEntity extends UserEntity {
  String city;
  bool isHomeDoctor;
  bool isVaccinatorDoctor;

  DoctorEntity();

  factory DoctorEntity.fromJson(Map<String, dynamic> json) {
    return _$DoctorEntityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DoctorEntityToJson(this);
}
