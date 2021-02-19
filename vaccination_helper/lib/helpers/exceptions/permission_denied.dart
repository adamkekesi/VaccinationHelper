import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:json_annotation/json_annotation.dart';

part 'permission_denied.g.dart';

@JsonSerializable()
class PermissionDenied extends BaseException {
  PermissionDenied();

  static PermissionDenied fromJson(Map<String, dynamic> json) {
    return _$PermissionDeniedFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PermissionDeniedToJson(this);
}
