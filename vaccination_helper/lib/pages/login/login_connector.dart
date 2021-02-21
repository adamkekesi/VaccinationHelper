import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:vaccination_helper/core/auth/actions/login_action.dart';
import 'package:vaccination_helper/core/auth/state/login_state.dart'
    as storeState;
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:vaccination_helper/core/translation/translator.dart';
import 'package:vaccination_helper/helpers/types.dart';
import 'package:vaccination_helper/helpers/widgets/error_feedback.dart';
import 'package:vaccination_helper/pages/login/login.dart';
import 'package:vaccination_helper/pages/user_home/user_home.dart';
import 'package:vaccination_helper/pages/user_home/user_home_connector.dart';

part 'login_connector.g.dart';

class LoginConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginViewModel>(
        vm: () => new LoginVmFactory(this),
        builder: (BuildContext context, LoginViewModel vm) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                'Log In',
                style: TextStyle(fontFamily: 'Comfortaa'),
              ),
              centerTitle: true,
              elevation: 10,
              backgroundColor: Colors.cyan,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (vm.state.loginState.exception != null)
                      ErrorFeedback(
                        msg: vm.state.loginState.exception.type,
                      ),
                    Login(
                        payload: vm.state.loginState.payload,
                        onSent: vm.sendLogin),
                  ],
                ),
              ),
            ),
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

  void sendLogin(BuildContext context) async {
    try {
      await dispatchFuture(LoginAction(state.loginState.payload));
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (c) {
        return UserHomeConnector();
      }));
    } catch (e) {}
  }
}

class LoginViewModel extends Vm {
  final LoginState state;

  final String language;

  final Translator translator;

  final BuildContextFunction sendLogin;

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
