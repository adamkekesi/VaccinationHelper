import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:vaccination_helper/helpers/exceptions/invalid_auth_token.dart';
import 'package:vaccination_helper/helpers/exceptions/invalid_captcha.dart';
import 'package:vaccination_helper/helpers/exceptions/invalid_credentials.dart';
import 'package:vaccination_helper/helpers/exceptions/invalid_fields.dart';
import 'package:vaccination_helper/helpers/exceptions/invalid_token.dart';
import 'package:vaccination_helper/helpers/exceptions/permission_denied.dart';
import 'package:vaccination_helper/helpers/exceptions/service_unavailable.dart';
import 'package:vaccination_helper/helpers/exceptions/unauthorized.dart';
import 'package:vaccination_helper/helpers/exceptions/unknown_exception.dart';
import 'package:vaccination_helper/helpers/exceptions/user_already_exists.dart';
import 'package:vaccination_helper/helpers/exceptions/user_not_exists.dart';
import 'package:vaccination_helper/helpers/exceptions/user_not_verified.dart';
import 'package:vaccination_helper/helpers/rest/deserializer_function.dart';
import 'package:json_annotation/json_annotation.dart';

part 'raw_error.g.dart';

Map<String, DeserializerFunction> _errorTypes = {
  "InvalidAuthToken": InvalidAuthToken.fromJson,
  "InvalidCaptcha": InvalidCaptcha.fromJson,
  "InvalidCredentials": InvalidCredentials.fromJson,
  "InvalidFields": InvalidFields.fromJson,
  "InvalidToken": InvalidToken.fromJson,
  "PermissionDenied": PermissionDenied.fromJson,
  "ServiceUnavailable": ServiceUnavailable.fromJson,
  "Unauthorized": Unauthorized.fromJson,
  "UserAlreadyExists": UserAlreadyExists.fromJson,
  "UserNotExists": UserNotExists.fromJson,
  "UserNotVerified": UserNotVerified.fromJson
};

@JsonSerializable()
class RawError {
  String type;

  @JsonKey(ignore: true)
  Map<String, dynamic> rawJson;

  static RawError fromJson(Map<String, dynamic> json) {
    return _$RawErrorFromJson(json)..rawJson = json;
  }

  Map<String, dynamic> toJson() => _$RawErrorToJson(this);

  BaseException deserialize() {
    if (type == null || !_errorTypes.containsKey(type)) {
      return new UnknownException();
    }
    var deserializer = _errorTypes[type];
    try {
      return deserializer(rawJson) as BaseException;
    } catch (e) {
      return new UnknownException();
    }
  }
}
