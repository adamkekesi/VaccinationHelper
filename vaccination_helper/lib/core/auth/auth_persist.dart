import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccination_helper/core/auth/actions/load_jwt_action.dart';
import 'package:vaccination_helper/core/redux/store.dart';
import 'package:vaccination_helper/core/settings/actions/load_settings_action.dart';

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
    store.dispatch(new LoadJwtAction());
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
