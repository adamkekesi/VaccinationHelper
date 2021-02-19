import 'package:async_redux/async_redux.dart';
import 'package:vaccination_helper/core/auth/auth_persist.dart';
import 'package:vaccination_helper/core/auth/state/auth_state.dart';
import 'package:vaccination_helper/core/redux/app_state.dart';

class LoadJwtAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.changeAuthState(new AuthState.withJwt(AuthPersist.jwt));
  }
}
