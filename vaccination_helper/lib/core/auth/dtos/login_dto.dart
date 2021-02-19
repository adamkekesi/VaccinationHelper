import 'package:vaccination_helper/helpers/dtos/captcha_dto.dart';
import 'package:vaccination_helper/helpers/rest/serializable_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_dto.g.dart';

@JsonSerializable()
class LoginDto extends CaptchaDto implements SerializableObject {
  String username;

  String password;

  LoginDto();

  LoginDto.create(this.username, this.password);

  factory LoginDto.fromJson(Map<String, dynamic> json) =>
      _$LoginDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);
}
