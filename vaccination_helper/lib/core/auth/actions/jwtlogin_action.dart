import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:vaccination_helper/core/auth/auth_persist.dart';
import 'package:vaccination_helper/core/auth/auth_service.dart';
import 'package:vaccination_helper/core/auth/state/auth_state.dart';
import 'package:vaccination_helper/core/auth/dtos/login_dto.dart';
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:vaccination_helper/helpers/exceptions/invalid_auth_token.dart';
import 'package:vaccination_helper/helpers/exceptions/unknown_exception.dart';

class JwtloginAction extends ReduxAction<AppState> {
  @override
  void before() {
    dispatch(new StartJwtloginLoadingAction());
  }

  @override
  Future<AppState> reduce() async {
    if (state.authState.jwt == null || state.authState.jwt == "") {
      return null;
    }
    try {
      var result = await AuthService.jwtlogin();
      if (result?.user == null) {
        throw new UnknownException();
      }
      var jwt = result.jwt ?? AuthPersist.jwt;
      await AuthPersist.persist(jwt, result.user?.id);
      return state
          .changeAuthState(new AuthState.withUserData(result.user, jwt))
          .changeJwtloginState(state.jwtloginState.setResult(null));
    } catch (e) {
      BaseException error;
      if (e is BaseException) {
        error = e;
      } else {
        error = new UnknownException();
      }
      dispatchFuture(new JwtloginFailedAction(error));
      throw error;
    }
  }

  @override
  void after() {}
}

class JwtloginFailedAction extends ReduxAction<AppState> {
  BaseException exception;

  JwtloginFailedAction(this.exception);

  @override
  Future<AppState> reduce() async {
    var changedState = state;
    if (exception is InvalidAuthToken) {
      await AuthPersist.persist(null, null);
      changedState =
          changedState.changeAuthState(new AuthState.notLoggedInState());
    }
    return changedState
        .changeJwtloginState(state.jwtloginState.setResult(exception));
  }
}

class StartJwtloginLoadingAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.changeJwtloginState(state.jwtloginState.loading());
  }
}
