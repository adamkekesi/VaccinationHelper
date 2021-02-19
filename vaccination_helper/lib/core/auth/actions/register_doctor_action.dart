import 'package:async_redux/async_redux.dart';
import 'package:vaccination_helper/core/auth/auth_persist.dart';
import 'package:vaccination_helper/core/auth/auth_service.dart';
import 'package:vaccination_helper/core/auth/dtos/doctor_register_dto.dart';
import 'package:vaccination_helper/core/auth/state/auth_state.dart';
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:vaccination_helper/helpers/exceptions/unknown_exception.dart';

class RegisterDoctorAction extends ReduxAction<AppState> {
  DoctorRegisterDto payload;

  RegisterDoctorAction(this.payload);

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
    } catch (e) {}
  }
}
