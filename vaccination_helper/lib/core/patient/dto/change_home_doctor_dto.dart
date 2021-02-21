import 'package:vaccination_helper/helpers/rest/serializable_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_home_doctor_dto.g.dart';

@JsonSerializable()
class ChangeHomeDoctorDto implements SerializableObject {
  String patientId;

  String doctorId;

  ChangeHomeDoctorDto();

  ChangeHomeDoctorDto.create();

  factory ChangeHomeDoctorDto.fromJson(Map<String, dynamic> json) {
    return _$ChangeHomeDoctorDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChangeHomeDoctorDtoToJson(this);
}
