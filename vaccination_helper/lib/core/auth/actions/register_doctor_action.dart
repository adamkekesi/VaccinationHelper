import 'package:async_redux/async_redux.dart';
import 'package:vaccination_helper/core/auth/auth_persist.dart';
import 'package:vaccination_helper/core/auth/auth_service.dart';
import 'package:vaccination_helper/core/auth/dtos/doctor_register_dto.dart';
import 'package:vaccination_helper/core/auth/state/auth_state.dart';
import 'package:vaccination_helper/core/auth/state/doctor_register_state.dart';
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:vaccination_helper/helpers/exceptions/unknown_exception.dart';

class RegisterDoctorAction extends ReduxAction<AppState> {
  DoctorRegisterDto payload;

  RegisterDoctorAction(this.payload);

  @override
  void before() {
    dispatch(new StartDoctorRegisterLoadingAction());
  }

  @override
  Future<AppState> reduce() async {
    try {
      var result = await AuthService.registerDoctor(payload);
      if (result?.user == null) {
        throw new UnknownException();
      }
      var jwt = result.jwt ?? AuthPersist.jwt;
      await AuthPersist.persist(jwt, result.user?.id);
      return state
          .changeAuthState(new AuthState.withUserData(result.user, jwt))
          .changeDoctorRegisterState(state.doctorRegisterState.setResult(null));
    } catch (e) {
      BaseException error;
      if (e is BaseException) {
        error = e;
      } else {
        error = new UnknownException();
      }
      dispatch(new DoctorRegistrationFailedAction(error));
      throw error;
    }
  }
}

class DoctorRegistrationFailedAction extends ReduxAction<AppState> {
  BaseException exception;

  DoctorRegistrationFailedAction(this.exception);

  @override
  AppState reduce() {
    return state.changeDoctorRegisterState(
        state.doctorRegisterState.setResult(exception));
  }
}

class StartDoctorRegisterLoadingAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.changeDoctorRegisterState(state.doctorRegisterState.loading());
  }
}

class HideLoginFeedbackAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    return state
        .changeDoctorRegisterState(state.doctorRegisterState.clearFeedback());
  }
}

class OverrideDoctorStateAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.changeDoctorRegisterState(new DoctorRegisterState.create());
  }
}
