import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_already_exists.g.dart';

@JsonSerializable()
class UserAlreadyExists extends BaseException {
  UserAlreadyExists();

  static UserAlreadyExists fromJson(Map<String, dynamic> json) {
    return _$UserAlreadyExistsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserAlreadyExistsToJson(this);
}
