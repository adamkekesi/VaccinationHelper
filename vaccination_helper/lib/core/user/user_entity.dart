import 'package:vaccination_helper/core/doctor/doctor_entity.dart';
import 'package:vaccination_helper/core/patient/patient_entity.dart';
import 'package:vaccination_helper/core/role/entity/role_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  String id;

  String email;

  String username;

  String fullName;

  String phoneNumber;

  List<RoleEntity> roles;

  String type;

  UserEntity();

  static UserEntity fromJson(Map<String, dynamic> json) {
    var user = _$UserEntityFromJson(json);

    if (user.type == "PatientEntity") {
      return PatientEntity.fromJson(json);
    }

    if (user.type == "DoctorEntity") {
      return DoctorEntity.fromJson(json);
    }

    return user;
  }

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
