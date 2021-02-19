import 'package:vaccination_helper/helpers/rest/serializable_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email_verification_dto.g.dart';

@JsonSerializable()
class EmailVerificationDto implements SerializableObject {
  String token;

  EmailVerificationDto();

  EmailVerificationDto.create(this.token);

  factory EmailVerificationDto.fromJson(Map<String, dynamic> json) {
    return _$EmailVerificationDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EmailVerificationDtoToJson(this);
}
