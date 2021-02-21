import 'package:flutter/foundation.dart';
import 'package:vaccination_helper/helpers/exceptions/unknown_exception.dart';
import 'package:vaccination_helper/helpers/rest/deserializer_function.dart';
import 'package:vaccination_helper/helpers/rest/raw_error.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  dynamic data;

  RawError error;

  ApiResponse();

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return _$ApiResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

  void throwIfHasError() {
    if (error == null) {
      return;
    }
    throw error.deserialize();
  }

  dynamic deserialize(DeserializerFunction deserializer) {
    if (deserializer == null) {
      return data;
    }
    try {
      if (data is List) {
        return (data as List).map((e) => deserializer(e));
      }
      return deserializer(data);
    } catch (e) {
      throw new UnknownException();
    }
  }
}
