import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:vaccination_helper/core/auth/auth_persist.dart';
import 'package:vaccination_helper/core/auth/auth_service.dart';
import 'package:vaccination_helper/core/auth/state/auth_state.dart';
import 'package:vaccination_helper/core/auth/dtos/login_dto.dart';
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:vaccination_helper/helpers/exceptions/unknown_exception.dart';

class LoginAction extends ReduxAction<AppState> {
  LoginDto payload;

  LoginAction(this.payload);

  @override
  void before() {
    dispatch(new StartLoginLoadingAction());
  }

  @override
  Future<AppState> reduce() async {
    try {
      var result = await AuthService.login(payload);
      if (result?.user == null) {
        throw new UnknownException();
      }
      var jwt = result.jwt ?? AuthPersist.jwt;
      await AuthPersist.persist(jwt, result.user?.id);
      return state
          .changeAuthState(new AuthState.withUserData(result.user, jwt))
          .changeLoginState(state.loginState.setResult(null));
    } catch (e) {
      BaseException error;
      if (e is BaseException) {
        error = e;
      } else {
        error = new UnknownException();
      }
      dispatch(new LoginFailedAction(error));
      throw error;
    }
  }

  @override
  void after() {}
}

class LoginFailedAction extends ReduxAction<AppState> {
  BaseException exception;

  LoginFailedAction(this.exception);

  @override
  AppState reduce() {
    return state.changeLoginState(state.loginState.setResult(exception));
  }
}

class StartLoginLoadingAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.changeLoginState(state.loginState.loading());
  }
}

class HideLoginFeedbackAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    return state.changeLoginState(state.loginState.clearFeedback());
  }
}
