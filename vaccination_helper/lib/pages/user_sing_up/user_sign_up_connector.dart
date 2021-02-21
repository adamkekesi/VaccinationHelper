import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:vaccination_helper/core/auth/actions/register_patient_action.dart';
import 'package:vaccination_helper/core/auth/dtos/patient_register_dto.dart';
import 'package:vaccination_helper/core/auth/state/patient_register_state.dart';
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:vaccination_helper/core/translation/translator.dart';
import 'package:vaccination_helper/helpers/widgets/error_feedback.dart';
import 'package:vaccination_helper/pages/user_home/user_home.dart';
import 'package:vaccination_helper/pages/user_home/user_home_connector.dart';
import 'package:vaccination_helper/pages/user_sing_up/user_sign_up.dart';

part 'user_sign_up_connector.g.dart';

class UserSignUpConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserSignUpViewModel>(
        vm: () => new UserSignUpVmFactory(this),
        builder: (BuildContext context, UserSignUpViewModel vm) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                'Register patient',
                style: TextStyle(fontFamily: 'Comfortaa'),
              ),
              centerTitle: true,
              elevation: 10,
              backgroundColor: Colors.cyan,
            ),
            body: SingleChildScrollView(
              //mainAxisAlignment: MainAxisAlignment.center,
              child: Column(
                children: <Widget>[
                  if (vm.state.patientState.exception != null)
                    ErrorFeedback(
                      msg: vm.state.patientState.exception.type,
                    ),
                  UserSignUp(
                    onSent: (context) =>
                        vm.sendRequest(vm.state.patientState.payload, context),
                    payload: vm.state.patientState.payload,
                  )
                ],
              ),
            ),
          );
        });
  }
}

class UserSignUpVmFactory extends VmFactory<AppState, UserSignUpConnector> {
  UserSignUpVmFactory(widget) : super(widget);

  @override
  UserSignUpViewModel fromStore() {
    return new UserSignUpViewModel(state.settingsState.language,
        new UserSignUpState.create(state.patientRegisterState), sendRequest);
  }

  void sendRequest(PatientRegisterDto payload, BuildContext context) async {
    try {
      await dispatchFuture(new RegisterPatientAction(payload));
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (c) => UserHomeConnector()));
    } catch (e) {}
  }
}

class UserSignUpViewModel extends Vm {
  final UserSignUpState state;

  final String language;

  final Translator translator;

  final PayloadSendFunction sendRequest;

  UserSignUpViewModel(this.language, this.state, this.sendRequest)
      : translator = new Translator(language, translationOverrides),
        super(equals: [state, language]);
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

const Map<String, Map<String, String>> translationOverrides = {
  "key": {"en": "English version", "hu": "magyar változat"}
};

typedef void PayloadSendFunction(
    PatientRegisterDto payload, BuildContext context);
