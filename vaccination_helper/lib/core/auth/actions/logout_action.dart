import 'package:async_redux/async_redux.dart';
import 'package:vaccination_helper/core/auth/auth_persist.dart';
import 'package:vaccination_helper/core/auth/auth_service.dart';
import 'package:vaccination_helper/core/auth/state/auth_state.dart';
import 'package:vaccination_helper/core/redux/app_state.dart';

class LogoutAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    try {
      await AuthService.logout();
    } catch (e) {}
    await AuthPersist.clear();
    return state.changeAuthState(new AuthState.notLoggedInState());
  }
}
