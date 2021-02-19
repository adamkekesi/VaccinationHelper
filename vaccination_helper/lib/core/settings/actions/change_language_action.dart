import 'package:async_redux/async_redux.dart';
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:vaccination_helper/core/settings/settings_persist.dart';
import 'package:vaccination_helper/core/settings/state/settings_state.dart';

class ChangeLanguageAction extends ReduxAction<AppState> {
  String language;

  ChangeLanguageAction(this.language);

  @override
  Future<AppState> reduce() async {
    await SettingsPersist.setLanguage(language);

    return state
        .changeSettingsState(state.settingsState.changeLanguage(language));
  }
}
