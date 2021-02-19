import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';

class RequestFailed extends BaseException {
  RequestFailed() {
    type = "RequestFailed";
  }
}
