abstract class BaseException {
  String type;

  Map<String, String> get errorMessage {
    return {"en": type, "hu": type};
  }
}
