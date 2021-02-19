import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invalid_credentials.g.dart';

@JsonSerializable()
class InvalidCredentials extends BaseException {
  InvalidCredentials();

  static InvalidCredentials fromJson(Map<String, dynamic> json) {
    return _$InvalidCredentialsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InvalidCredentialsToJson(this);
}
