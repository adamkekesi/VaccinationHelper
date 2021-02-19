import 'package:shared_preferences/shared_preferences.dart';

class AuthPersist {
  static String get jwt {
    try {
      return _prefs.getString("jwt");
    } catch (e) {
      return "";
    }
  }

  static String get userId {
    try {
      return _prefs.getString("userId");
    } catch (e) {
      return "";
    }
  }

  static SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> persist(String jwt, String userId) async {
    if (jwt != AuthPersist.jwt) {
      await _prefs.setString("jwt", jwt);
    }
    if (userId != AuthPersist.userId) {
      await _prefs.setString("userId", userId);
    }
  }
}
