import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:vaccination_helper/core/auth/actions/register_patient_action.dart';
import 'package:vaccination_helper/core/auth/state/patient_register_state.dart';
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:vaccination_helper/core/translation/translator.dart';
import 'package:vaccination_helper/pages/user_sing_up/user_sing_up.dart';

part 'user_sign_up_connector.g.dart';

class UserSignUpConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserSignUpViewModel>(
        vm: () => new UserSignUpVmFactory(this),
        builder: (BuildContext context, UserSignUpViewModel vm) {
          return UserSignUp();
        });
  }
}

class UserSignUpVmFactory extends VmFactory<AppState, UserSignUpConnector> {
  UserSignUpVmFactory(widget) : super(widget);

  @override
  UserSignUpViewModel fromStore() {
    return new UserSignUpViewModel(state.settingsState.language,
        new UserSignUpState.create(state.patientRegisterState), _start, _stop);
  }

  void _start() {
    dispatch(new StartPatientRegisterLoadingAction());
  }

  void _stop() {
    dispatch(new StopAction());
  }
}

class UserSignUpViewModel extends Vm {
  final UserSignUpState state;

  final String language;

  final Translator translator;

  final Function start;

  final Function stop;

  UserSignUpViewModel(this.language, this.state, this.start, this.stop)
      : translator = new Translator(language, translationOverrides),
        super(equals: [state, language]);

  void test() {
    if (state.patientState.isLoading) {
      stop();
    } else {
      start();
    }
  }
}

abstract class UserSignUpState
    implements Built<UserSignUpState, UserSignUpStateBuilder> {
  UserSignUpState._();
  PatientRegisterState get patientState;

  factory UserSignUpState([void Function(UserSignUpStateBuilder) updates]) {
    return new _$UserSignUpState(updates);
  }

  factory UserSignUpState.create(PatientRegisterState state) {
    return new UserSignUpState((b) {
      b.patientState.replace(state);
    });
  }
}

const Map<String, Map<String, String>> translationOverrides = {};
