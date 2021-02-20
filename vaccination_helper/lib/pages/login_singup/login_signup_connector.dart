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

const Map<String, Map<String, String>> translationOverrides = {
  "name-hint-text":{"en":"Name", "hu":"Név"},

  "email-hint-text":{
  "en":"Email address",
  "hu":"Email cím"},

  "city-hint-text":{
    "en":"City",
    "hu":"Város"},

  "zip-hint-text":{
    "en":"ZIP code",
    "hu":"Irányító szám"},

  "identity-hint-text":{
    "en":"Identity Card number",
    "hu":"Személyi igazlvány szám"},

  "taj-hint-text":{
    "en":"SSN number",
    "hu":"TAJ szám"},

  "phone-hint-text":{
    "en":"Phone number",
    "hu":"Telefonszám"},

  "password-hint-text":{
    "en":"Password",
    "hu":"Jelszó"},

  "birth-date-hint-text":{
    "en":"Birth Date",
    "hu":"Születési hely"},

  "address-hint-text":{
    "en":"Address",
    "hu":"Lakcím"},


  //-----------------------------------------------------------------------------------

  "name-required-text":{
    "en":"Name is required",
    "hu":"Név mező nem lehet üres"},

  "email-required-text":{
    "en":"Email address is required",
    "hu":"Email cím mező nem lehet üres"},

  "city-required-text":{
    "en":"City is required",
    "hu":"Város mező nem lehet üres"},

  "zip-required-text":{
    "en":"ZIP code is required",
    "hu":"Irányító szám mező nem lehet üres"},

  "identity-required-text":{
    "en":"Identity Card number is required",
    "hu":"Személyi igazlvány szám mező nem lehet üres"},

  "taj-required-text":{
    "en":"SSN number is required",
    "hu":"TAJ szám mező nem lehet üres"},

  "phone-required-text":{
    "en":"Phone number is required",
    "hu":"Telefonszám mező nem lehet üres"},

  "password-required-text":{
    "en":"Password is required",
    "hu":"Jelszó mező nem lehet üres"},

  "birth-date-required-text":{
    "en":"Birth Date is required",
    "hu":"Születési hely mező nem lehet üres"},

  "address-required-text":{
    "en":"Address is required",
    "hu":"Lakcím mező nem lehet üres"},


  "key19":{
    "en":"English version",
    "hu":"magyar változat"},
  /*"key19":{
    "en":"English version",
    "hu":"magyar változat"},
  "key19":{
    "en":"English version",
    "hu":"magyar változat"},
  "key19":{
    "en":"English version",
    "hu":"magyar változat"},
  "key19":{
    "en":"English version",
    "hu":"magyar változat"},
  "key19":{
    "en":"English version",
    "hu":"magyar változat"},
  "key19":{
    "en":"English version",
    "hu":"magyar változat"},
  "key19":{
    "en":"English version",
    "hu":"magyar változat"},*/



};
