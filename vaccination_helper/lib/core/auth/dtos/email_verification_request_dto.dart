import 'package:vaccination_helper/helpers/rest/serializable_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email_verification_request_dto.g.dart';

@JsonSerializable()
class EmailVerificationRequestDto implements SerializableObject {
  String email;

  EmailVerificationRequestDto();

  EmailVerificationRequestDto.create(this.email);

  factory EmailVerificationRequestDto.fromJson(Map<String, dynamic> json) {
    return _$EmailVerificationRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EmailVerificationRequestDtoToJson(this);
}
