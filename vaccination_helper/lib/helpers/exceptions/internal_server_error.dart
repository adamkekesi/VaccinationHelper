import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:json_annotation/json_annotation.dart';

part 'internal_server_error.g.dart';

@JsonSerializable()
class InternalServerError extends BaseException {
  InternalServerError();

  static InternalServerError fromJson(Map<String, dynamic> json) {
    return _$InternalServerErrorFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InternalServerErrorToJson(this);
}
