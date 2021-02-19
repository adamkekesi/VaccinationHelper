import 'package:vaccination_helper/helpers/rest/serializable_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'password_reset_request_dto.g.dart';

@JsonSerializable()
class PasswordResetRequestDto implements SerializableObject {
  String email;

  PasswordResetRequestDto();

  PasswordResetRequestDto.create(this.email);

  factory PasswordResetRequestDto.fromJson(Map<String, dynamic> json) {
    return _$PasswordResetRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PasswordResetRequestDtoToJson(this);
}
