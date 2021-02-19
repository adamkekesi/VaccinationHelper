import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invalid_captcha.g.dart';

@JsonSerializable()
class InvalidCaptcha extends BaseException {
  InvalidCaptcha();

  static InvalidCaptcha fromJson(Map<String, dynamic> json) {
    return _$InvalidCaptchaFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InvalidCaptchaToJson(this);
}
