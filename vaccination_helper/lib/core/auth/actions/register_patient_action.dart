import 'package:async_redux/async_redux.dart';
import 'package:vaccination_helper/core/auth/auth_persist.dart';
import 'package:vaccination_helper/core/auth/auth_service.dart';
import 'package:vaccination_helper/core/auth/dtos/patient_register_dto.dart';
import 'package:vaccination_helper/core/auth/state/auth_state.dart';
import 'package:vaccination_helper/core/auth/state/patient_register_state.dart';
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:vaccination_helper/helpers/exceptions/unknown_exception.dart';

class RegisterPatientAction extends ReduxAction<AppState> {
  PatientRegisterDto payload;

  RegisterPatientAction(this.payload);

  @override
  void before() {
    dispatch(new StartPatientRegisterLoadingAction());
  }

  @override
  Future<AppState> reduce() async {
    try {
      var result = await AuthService.registerPatient(payload);
      if (result?.user == null) {
        throw new UnknownException();
      }
      var jwt = result.jwt ?? AuthPersist.jwt;
      await AuthPersist.persist(jwt, result.user?.id);
      return state
          .changeAuthState(new AuthState.withUserData(result.user, jwt))
          .changePatientRegisterState(
              state.patientRegisterState.setResult(null));
    } catch (e) {
      BaseException error;
      if (e is BaseException) {
        error = e;
      } else {
        error = new UnknownException();
      }
      dispatch(new PatientRegistrationFailedAction(error));
      throw error;
    }
  }
}

class PatientRegistrationFailedAction extends ReduxAction<AppState> {
  BaseException exception;

  PatientRegistrationFailedAction(this.exception);

  @override
  AppState reduce() {
    return state.changePatientRegisterState(
        state.patientRegisterState.setResult(exception));
  }
}

class StartPatientRegisterLoadingAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state
        .changePatientRegisterState(state.patientRegisterState.loading());
  }
}

class HideLoginFeedbackAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    return state
        .changePatientRegisterState(state.patientRegisterState.clearFeedback());
  }
}

class OverridePatientStateAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.changePatientRegisterState(new PatientRegisterState.create());
  }
}

class StopAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state
        .changePatientRegisterState(state.patientRegisterState.setResult(null));
  }
}
