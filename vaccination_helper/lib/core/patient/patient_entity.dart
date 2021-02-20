import 'package:json_annotation/json_annotation.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:vaccination_helper/core/user/user_entity.dart';
import 'package:vaccination_helper/core/role/entity/role_entity.dart';

part 'patient_entity.g.dart';

@JsonSerializable()
class PatientEntity extends UserEntity {
  Address getaddress;
  DateTime dateOfBirth;
  String identityCardNumber;
  String ssn;

  PatientEntity();

  static PatientEntity fromJson(Map<String, dynamic> json) {
    return _$PatientEntityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PatientEntityToJson(this);
}

@JsonSerializable()
class Address {
  String zipCode;
  String city;
  String address;

  Address();

  factory Address.fromJson(Map<String, dynamic> json) {
    return _$AddressFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
