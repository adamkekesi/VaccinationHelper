import 'package:vaccination_helper/helpers/rest/serializable_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'password_reset_dto.g.dart';

@JsonSerializable()
class PasswordResetDto implements SerializableObject {
  String token;

  String password;

  PasswordResetDto();

  PasswordResetDto.create(this.token, this.password);

  factory PasswordResetDto.fromJson(Map<String, dynamic> json) {
    return _$PasswordResetDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PasswordResetDtoToJson(this);
}
