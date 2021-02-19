import 'package:vaccination_helper/helpers/rest/serializable_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'captcha_dto.g.dart';

@JsonSerializable()
class CaptchaDto implements SerializableObject {
  String captcha;

  int asd;

  CaptchaDto();

  factory CaptchaDto.fromJson(Map<String, dynamic> json) =>
      _$CaptchaDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CaptchaDtoToJson(this);
}
