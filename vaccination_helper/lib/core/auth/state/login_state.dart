import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:vaccination_helper/core/auth/dtos/login_dto.dart';
import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:vaccination_helper/helpers/exceptions/invalid_fields.dart';

part 'login_state.g.dart';

abstract class LoginState implements Built<LoginState, LoginStateBuilder> {
  bool get isLoading;

  bool get isSuccessful;

  @nullable
  BaseException get exception;

  LoginDto get payload;

  LoginState._();

  factory LoginState([void Function(LoginStateBuilder) updates]) {
    return new _$LoginState(updates);
  }

  factory LoginState.initial() {
    return new LoginState((b) {
      b.isLoading = false;
      b.isSuccessful = false;
      b.exception = null;
      b.payload = new LoginDto();
    });
  }

  LoginState loading() {
    return this.rebuild((b) => b
      ..isLoading = true
      ..isSuccessful = false
      ..exception = null);
  }

  LoginState setResult(BaseException exception) {
    return this.rebuild((b) {
      b.isLoading = false;
      b.exception = exception;
      b.isSuccessful = exception == null;
    });
  }

  LoginState clearFeedback() {
    return this.rebuild((b) {
      b.isSuccessful = false;
      b.exception = null;
    });
  }
}
