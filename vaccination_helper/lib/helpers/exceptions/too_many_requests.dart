import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:json_annotation/json_annotation.dart';

part 'too_many_requests.g.dart';

@JsonSerializable()
class TooManyRequests extends BaseException {
  int retryAfter;

  TooManyRequests();

  static TooManyRequests fromJson(Map<String, dynamic> json) {
    return _$TooManyRequestsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TooManyRequestsToJson(this);
}
