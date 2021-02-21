import 'package:vaccination_helper/helpers/rest/serializable_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'choose_vaccinator_dto.g.dart';

@JsonSerializable()
class ChooseVaccinatorDto implements SerializableObject {
  String vaccinationId;
  String vaccinatorId;

  ChooseVaccinatorDto();

  ChooseVaccinatorDto.create();

  factory ChooseVaccinatorDto.fromJson(Map<String, dynamic> json) {
    return _$ChooseVaccinatorDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChooseVaccinatorDtoToJson(this);
}
