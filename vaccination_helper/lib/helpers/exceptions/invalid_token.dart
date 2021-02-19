import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invalid_token.g.dart';

@JsonSerializable()
class InvalidToken extends BaseException {
  InvalidToken();

  static InvalidToken fromJson(Map<String, dynamic> json) {
    return _$InvalidTokenFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InvalidTokenToJson(this);
}
