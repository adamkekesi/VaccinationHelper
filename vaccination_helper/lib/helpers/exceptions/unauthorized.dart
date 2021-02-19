import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unauthorized.g.dart';

@JsonSerializable()
class Unauthorized extends BaseException {
  Unauthorized();

  static Unauthorized fromJson(Map<String, dynamic> json) {
    return _$UnauthorizedFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UnauthorizedToJson(this);
}
