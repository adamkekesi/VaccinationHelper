import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vaccination_helper/core/patient/dto/answer_dto.dart';
import 'package:vaccination_helper/helpers/rest/serializable_object.dart';

part 'set_consent_form_dto.g.dart';

@JsonSerializable()
class SetConsentFormDtoDto implements SerializableObject {
  List<AnswerDto> answers;

  SetConsentFormDtoDto();

  SetConsentFormDtoDto.create();

  factory SetConsentFormDtoDto.fromJson(Map<String, dynamic> json) {
    return _$SetConsentFormDtoDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SetConsentFormDtoDtoToJson(this);
}
