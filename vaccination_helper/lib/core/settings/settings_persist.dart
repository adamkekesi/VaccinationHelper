import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccination_helper/core/redux/store.dart';
import 'package:vaccination_helper/core/settings/actions/load_settings_action.dart';

class SettingsPersist {
  static String get language {
    try {
      var language = _prefs.getString("language");
      if (language != "en" || language != "hu") {
        return "en";
      }
      return language;
    } catch (e) {
      return "en";
    }
  }

  static SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    store.dispatch(new LoadSettingsAction());
  }

  static Future<void> setLanguage(String language) async {
    await _prefs.setString("language", language);
  }
}
