import 'package:json_annotation/json_annotation.dart';
import 'package:vaccination_helper/helpers/rest/serializable_object.dart';

part 'answer_dto.g.dart';

@JsonSerializable()
class AnswerDto implements SerializableObject {
  String questionId;
  String answer;

  AnswerDto();

  AnswerDto.create();

  factory AnswerDto.fromJson(Map<String, dynamic> json) {
    return _$AnswerDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AnswerDtoToJson(this);
}
