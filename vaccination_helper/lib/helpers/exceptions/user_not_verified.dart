import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_not_verified.g.dart';

@JsonSerializable()
class UserNotVerified extends BaseException {
  UserNotVerified();

  static UserNotVerified fromJson(Map<String, dynamic> json) {
    return _$UserNotVerifiedFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserNotVerifiedToJson(this);
}
