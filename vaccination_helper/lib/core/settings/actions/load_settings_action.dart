import 'package:async_redux/async_redux.dart';
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:vaccination_helper/core/settings/settings_persist.dart';

class LoadSettingsAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.changeSettingsState(
        state.settingsState.changeLanguage(SettingsPersist.language));
  }
}
