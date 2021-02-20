import 'package:vaccination_helper/helpers/rest/serializable_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient_register_dto.g.dart';

@JsonSerializable()
class PatientRegisterDto implements SerializableObject {
  String fullName;

  AddressDto address;

  DateTime dateOfBirth;

  String email;

  String identityCardNumber;

  String ssn;

  String phoneNumber;

  String password;

  PatientRegisterDto();

  PatientRegisterDto.create() {
    address = new AddressDto.create();
  }

  factory PatientRegisterDto.fromJson(Map<String, dynamic> json) {
    return _$PatientRegisterDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PatientRegisterDtoToJson(this);
}

@JsonSerializable()
class AddressDto implements SerializableObject {
  String zipCode;
  String city;
  String address;

  AddressDto();

  AddressDto.create();

  factory AddressDto.fromJson(Map<String, dynamic> json) {
    return _$AddressDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);
}
