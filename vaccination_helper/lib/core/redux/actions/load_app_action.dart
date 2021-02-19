import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:vaccination_helper/core/auth/actions/jwtlogin_action.dart';
import 'package:vaccination_helper/core/auth/auth_persist.dart';
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:vaccination_helper/core/settings/settings_persist.dart';

class LoadAppAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    try {
      await AuthPersist.init();
      await SettingsPersist.init();
      await store.dispatchFuture(new JwtloginAction());
    } catch (e) {}

    return state.loaded();
  }
}
