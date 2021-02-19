import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:json_annotation/json_annotation.dart';

part "invalid_auth_token.g.dart";

@JsonSerializable()
class InvalidAuthToken extends BaseException {
  InvalidAuthToken();

  static InvalidAuthToken fromJson(Map<String, dynamic> json) {
    return _$InvalidAuthTokenFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InvalidAuthTokenToJson(this);
}
