import 'dart:convert';
import 'package:vaccination_helper/config/api_config.dart';
import 'package:vaccination_helper/core/auth/auth_persist.dart';
import 'package:vaccination_helper/helpers/exceptions/request_failed.dart';
import 'package:vaccination_helper/helpers/exceptions/unknown_exception.dart';
import 'package:vaccination_helper/helpers/rest/deserializer_function.dart';
import 'package:vaccination_helper/helpers/rest/serializable_object.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:vaccination_helper/helpers/rest/api_response.dart';

class RestClient {
  static Future<dynamic> httpGet(String path,
      {SerializableObject query,
      DeserializerFunction responseDeserializer}) async {
    var headers = {"Authorization": "Bearer " + AuthPersist.jwt};

    var serializedQuery = _serializeQuery(query);

    var uri = Uri.https(apiUrl, "api/" + path, serializedQuery);

    Response httpResponse;

    try {
      httpResponse = await http.get(uri, headers: headers);
    } catch (e) {
      throw new RequestFailed();
    }

    return _processResponse(httpResponse, responseDeserializer);
  }

  static Future<dynamic> httpPost(String path,
      {SerializableObject query,
      SerializableObject body,
      DeserializerFunction responseDeserializer}) async {
    var headers = {"Authorization": "Bearer " + AuthPersist.jwt};

    var serializedQuery = _serializeQuery(query);

    var uri = Uri.https(apiUrl, "api/" + path, serializedQuery);

    Response httpResponse;

    try {
      var serializedBody = body == null ? null : jsonEncode(body);
      httpResponse = await http.post(uri,
          headers: headers,
          encoding: Encoding.getByName("utf-8"),
          body: serializedBody);
    } catch (e) {
      throw new RequestFailed();
    }

    return _processResponse(httpResponse, responseDeserializer);
  }

  static Future<dynamic> httpPut(String path,
      {SerializableObject query,
      SerializableObject body,
      DeserializerFunction responseDeserializer}) async {
    var headers = {"Authorization": "Bearer " + AuthPersist.jwt};

    var serializedQuery = _serializeQuery(query);

    var uri = Uri.https(apiUrl, "api/" + path, serializedQuery);

    Response httpResponse;

    try {
      var serializedBody = body == null ? null : jsonEncode(body);

      httpResponse = await http.put(uri,
          headers: headers,
          encoding: Encoding.getByName("utf-8"),
          body: serializedBody);
    } catch (e) {
      throw new RequestFailed();
    }

    return _processResponse(httpResponse, responseDeserializer);
  }

  static Future<dynamic> httpDelete(String path,
      {SerializableObject query,
      DeserializerFunction responseDeserializer}) async {
    var headers = {"Authorization": "Bearer " + AuthPersist.jwt};

    var serializedQuery = _serializeQuery(query);

    var uri = Uri.https(apiUrl, "api/" + path, serializedQuery);

    Response httpResponse;

    try {
      httpResponse = await http.delete(uri, headers: headers);
    } catch (e) {
      throw new RequestFailed();
    }

    return _processResponse(httpResponse, responseDeserializer);
  }

  static Map<String, String> _serializeQuery(SerializableObject query) {
    var map = new Map<String, String>();

    if (query != null) {
      try {
        var nestedMap = query.toJson();
        map = Map.fromEntries(nestedMap.entries.map((e) {
          return new MapEntry(e.key, jsonEncode(e.value));
        }));
      } catch (e) {}
    }

    return map;
  }

  static dynamic _processResponse(
      Response httpResponse, DeserializerFunction responseDeserializer) {
    ApiResponse apiResponse;
    try {
      var stringBody = httpResponse.body;
      apiResponse = new ApiResponse.fromJson(jsonDecode(stringBody));
    } catch (e) {
      throw new UnknownException();
    }

    apiResponse.throwIfHasError();

    return apiResponse.deserialize(responseDeserializer);
  }
}
