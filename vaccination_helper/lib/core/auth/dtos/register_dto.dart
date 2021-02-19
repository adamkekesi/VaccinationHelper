import 'package:vaccination_helper/helpers/dtos/captcha_dto.dart';
import 'package:vaccination_helper/helpers/rest/serializable_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_dto.g.dart';

@JsonSerializable()
class RegisterDto extends CaptchaDto implements SerializableObject {
  String email;

  String username;

  String password;

  RegisterDto();

  RegisterDto.create(this.email, this.username, this.password);

  factory RegisterDto.fromJson(Map<String, dynamic> json) {
    return _$RegisterDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RegisterDtoToJson(this);
}
