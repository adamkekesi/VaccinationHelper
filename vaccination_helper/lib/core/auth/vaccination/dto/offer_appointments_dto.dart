import 'package:vaccination_helper/helpers/rest/serializable_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'offer_appointments_dto.g.dart';

@JsonSerializable()
class OfferAppointmentsDto implements SerializableObject {
  String vaccinationId;
  String offeredAppointments;

  OfferAppointmentsDto();

  OfferAppointmentsDto.create();

  factory OfferAppointmentsDto.fromJson(Map<String, dynamic> json) {
    return _$OfferAppointmentsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OfferAppointmentsDtoToJson(this);
}
