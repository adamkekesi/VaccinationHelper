import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:vaccination_helper/core/auth/actions/register_doctor_action.dart';
import 'package:vaccination_helper/core/auth/actions/register_patient_action.dart';
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:vaccination_helper/core/translation/translator.dart';
import 'package:vaccination_helper/helpers/types.dart';
import 'package:vaccination_helper/pages/account_type/account_type.dart';
import 'package:vaccination_helper/pages/user_sing_up/user_sign_up_connector.dart';

part 'account_type_connector.g.dart';

class AccountTypeConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AccountTypeViewModel>(
        vm: () => new AccountTypeVmFactory(this),
        builder: (BuildContext context, AccountTypeViewModel vm) {
          return AccountType(
            translator: vm.translator,
            jumpToDoctor: vm.jumpToDoctor,
            jumpToPatient: vm.jumpToPatient,
          );
        });
  }
}

class AccountTypeVmFactory extends VmFactory<AppState, AccountTypeConnector> {
  AccountTypeVmFactory(widget) : super(widget);

  @override
  AccountTypeViewModel fromStore() {
    return new AccountTypeViewModel(state.settingsState.language,
        new AccountTypeState.create(), jumpToDoctor, jumpToPatient);
  }

  void jumpToPatient(BuildContext context) {
    dispatch(new OverridePatientStateAction());
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => UserSignUpConnector()));
  }

  void jumpToDoctor(BuildContext context) {
    dispatch(new OverrideDoctorStateAction());

    /* Navigator.push(context,
        new MaterialPageRoute(builder: (context) => DoctorSignUpConnector())); */
  }
}

class AccountTypeViewModel extends Vm {
  final AccountTypeState state;

  final String language;

  final Translator translator;

  final BuildContextFunction jumpToPatient;

  final BuildContextFunction jumpToDoctor;

  AccountTypeViewModel(
      this.language, this.state, this.jumpToDoctor, this.jumpToPatient)
      : translator = new Translator(language, translationOverrides),
        super(equals: [state, language]);
}

abstract class AccountTypeState
    implements Built<AccountTypeState, AccountTypeStateBuilder> {
  AccountTypeState._();

  factory AccountTypeState([void Function(AccountTypeStateBuilder) updates]) {
    return new _$AccountTypeState(updates);
  }

  factory AccountTypeState.create() {
    return new AccountTypeState((b) {});
  }
}

const Map<String, Map<String, String>> translationOverrides = {};
