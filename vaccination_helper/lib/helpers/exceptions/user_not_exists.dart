import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_not_exists.g.dart';

@JsonSerializable()
class UserNotExists extends BaseException {
  UserNotExists();

  static UserNotExists fromJson(Map<String, dynamic> json) {
    return _$UserNotExistsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserNotExistsToJson(this);
}
