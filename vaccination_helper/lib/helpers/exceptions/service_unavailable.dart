import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_unavailable.g.dart';

@JsonSerializable()
class ServiceUnavailable extends BaseException {
  ServiceUnavailable();

  static ServiceUnavailable fromJson(Map<String, dynamic> json) {
    return _$ServiceUnavailableFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ServiceUnavailableToJson(this);
}
