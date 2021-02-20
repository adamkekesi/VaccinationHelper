import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:vaccination_helper/core/auth/actions/login_action.dart';
import 'package:vaccination_helper/core/auth/state/login_state.dart'
    as storeState;
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:vaccination_helper/core/translation/translator.dart';
import 'package:vaccination_helper/pages/login/login.dart';

part 'login_connector.g.dart';

class LoginConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginViewModel>(
        vm: () => new LoginVmFactory(this),
        builder: (BuildContext context, LoginViewModel vm) {
          return Login(
              /* isLoading: vm.state.loginState.isLoading,
isSuccessful: vm.state.loginState.isSuccessful,
exception: vm.state.loginState.exception,
payload: vm.state.loginState.payload,
translator: vm.translator,
onSent:vm.sendLogin, payload:vm.state.loginState.payload */
              );
        });
  }
}

class LoginVmFactory extends VmFactory<AppState, LoginConnector> {
  LoginVmFactory(widget) : super(widget);

  @override
  LoginViewModel fromStore() {
    return new LoginViewModel(state.settingsState.language,
        new LoginState.create(state.loginState), sendLogin);
  }

  void sendLogin() async {
    await dispatchFuture(LoginAction(state.loginState.payload));
  }
}

class LoginViewModel extends Vm {
  final LoginState state;

  final String language;

  final Translator translator;

  final Function sendLogin;

  LoginViewModel(this.language, this.state, this.sendLogin)
      : translator = new Translator(language, translationOverrides),
        super(equals: [state, language]);
}

abstract class LoginState implements Built<LoginState, LoginStateBuilder> {
  storeState.LoginState get loginState;

  LoginState._();

  factory LoginState([void Function(LoginStateBuilder) updates]) {
    return new _$LoginState(updates);
  }

  factory LoginState.create(storeState.LoginState state) {
    return new LoginState((b) {
      b.loginState.replace(state);
    });
  }
}

const Map<String, Map<String, String>> translationOverrides = {};
