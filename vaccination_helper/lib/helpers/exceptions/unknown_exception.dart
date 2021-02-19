import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:json_annotation/json_annotation.dart';

class UnknownException extends BaseException {
  UnknownException() {
    type = "UnknownException";
  }
}
