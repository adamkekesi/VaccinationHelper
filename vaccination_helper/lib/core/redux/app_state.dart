import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:vaccination_helper/core/auth/dtos/patient_register_dto.dart';
import 'package:vaccination_helper/core/auth/state/auth_state.dart';
import 'package:vaccination_helper/core/auth/responses/login_response.dart';
import 'package:vaccination_helper/core/auth/state/doctor_register_state.dart';
import 'package:vaccination_helper/core/auth/state/login_state.dart';
import 'package:vaccination_helper/core/auth/state/patient_register_state.dart';
import 'package:vaccination_helper/core/settings/state/settings_state.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  AuthState get authState;

  LoginState get loginState;

  LoginState get jwtloginState;

  SettingsState get settingsState;

  @nullable
  DoctorRegisterState get doctorRegisterState;

  @nullable
  PatientRegisterState get patientRegisterState;

  bool get isAppLoaded;

  AppState._();

  factory AppState([void Function(AppStateBuilder) updates]) {
    return new _$AppState(updates);
  }

  factory AppState.initial() {
    return new AppState((b) {
      b.loginState.replace(new LoginState.initial());
      b.jwtloginState.replace(new LoginState.initial());
      b.authState.replace(new AuthState.initial());
      b.settingsState.replace(new SettingsState.initial());
      b.patientRegisterState.replace(new PatientRegisterState.create());
      b.isAppLoaded = false;
    });
  }

  AppState changeAuthState(AuthState state) {
    return this.rebuild((b) => b.authState.replace(state));
  }

  AppState changeLoginState(LoginState state) {
    return this.rebuild((b) => b.loginState.replace(state));
  }

  AppState changeJwtloginState(LoginState state) {
    return this.rebuild((b) => b.jwtloginState.replace(state));
  }

  AppState changeSettingsState(SettingsState state) {
    return this.rebuild((b) {
      b.settingsState.replace(state);
    });
  }

  AppState changeDoctorRegisterState(DoctorRegisterState state) {
    return this.rebuild((b) {
      b.doctorRegisterState.replace(state);
    });
  }

  AppState changePatientRegisterState(PatientRegisterState state) {
    return this.rebuild((b) {
      b.patientRegisterState.replace(state);
    });
  }

  AppState loaded() {
    return this.rebuild((b) {
      b.isAppLoaded = true;
    });
  }
}
