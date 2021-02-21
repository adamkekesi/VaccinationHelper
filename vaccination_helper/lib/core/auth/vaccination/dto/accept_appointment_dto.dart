import 'package:vaccination_helper/helpers/rest/serializable_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'accept_appointment_dto.g.dart';

@JsonSerializable()
class AcceptAppointmentDto implements SerializableObject {
  String chosen;
  String vaccinationId;

  AcceptAppointmentDto();

  AcceptAppointmentDto.create();

  factory AcceptAppointmentDto.fromJson(Map<String, dynamic> json) {
    return _$AcceptAppointmentDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AcceptAppointmentDtoToJson(this);
}
