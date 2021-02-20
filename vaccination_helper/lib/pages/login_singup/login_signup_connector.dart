import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:vaccination_helper/core/auth/actions/login_action.dart';
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:vaccination_helper/core/translation/translator.dart';
import 'package:vaccination_helper/helpers/types.dart';
import 'package:vaccination_helper/pages/login/login_connector.dart';
import 'package:vaccination_helper/pages/login_singup/login_singup.dart';

part 'login_signup_connector.g.dart';

class LoginSignupConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginSignupViewModel>(
        vm: () => new LoginSignupVmFactory(this),
        builder: (BuildContext context, LoginSignupViewModel vm) {
          return LandingPage(
            translator: vm.translator,
            jumpToLoginPage: vm.jumpToLoginPage,
          );
        });
  }
}

class LoginSignupVmFactory extends VmFactory<AppState, LoginSignupConnector> {
  LoginSignupVmFactory(widget) : super(widget);

  @override
  LoginSignupViewModel fromStore() {
    return new LoginSignupViewModel(state.settingsState.language,
        new LoginSignupState.create(), jumpToLoginPage);
  }

  void jumpToLoginPage(BuildContext context) {
    dispatch(OverrideLoginStateAction());
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginConnector()));
  }
}

class LoginSignupViewModel extends Vm {
  final LoginSignupState state;

  final String language;

  final Translator translator;

  final BuildContextFunction jumpToLoginPage;

  LoginSignupViewModel(this.language, this.state, this.jumpToLoginPage)
      : translator = new Translator(language, translationOverrides),
        super(equals: [state, language]);
}

abstract class LoginSignupState
    implements Built<LoginSignupState, LoginSignupStateBuilder> {
  LoginSignupState._();

  factory LoginSignupState([void Function(LoginSignupStateBuilder) updates]) {
    return new _$LoginSignupState(updates);
  }

  factory LoginSignupState.create() {
    return new LoginSignupState((b) {});
  }
}

const Map<String, Map<String, String>> translationOverrides = {};
