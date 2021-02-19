import 'package:vaccination_helper/helpers/rest/serializable_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor_register_dto.g.dart';

@JsonSerializable()
class DoctorRegisterDto implements SerializableObject {
  String fullName;

  String email;

  String phoneNumber;

  String city;

  String password;

  bool isHomeDoctor;

  bool isVaccinatorDoctor;

  DoctorRegisterDto();

  DoctorRegisterDto.create();

  factory DoctorRegisterDto.fromJson(Map<String, dynamic> json) {
    return _$DoctorRegisterDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DoctorRegisterDtoToJson(this);
}
