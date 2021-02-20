import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:vaccination_helper/core/translation/translator.dart';
import 'package:vaccination_helper/pages/loading/loading.dart';
import 'package:vaccination_helper/pages/login_singup/login_singup.dart';
import 'package:vaccination_helper/pages/user_sing_up/user_sign_up_connector.dart';

part 'loading_page_connector.g.dart';

class LoadingPageConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoadingPageViewModel>(
        vm: () => new LoadingPageVmFactory(this),
        builder: (BuildContext context, LoadingPageViewModel vm) {
          if (vm.state.isAppLoaded) {
            Future.delayed(new Duration(seconds: 2), () {
              return Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserSignUpConnector()));
            });
          }
          return Loading();
        });
  }
}

class LoadingPageVmFactory extends VmFactory<AppState, LoadingPageConnector> {
  LoadingPageVmFactory(widget) : super(widget);

  @override
  LoadingPageViewModel fromStore() {
    return new LoadingPageViewModel(state.settingsState.language,
        new LoadingPageState.create(state.isAppLoaded));
  }
}

class LoadingPageViewModel extends Vm {
  final LoadingPageState state;

  final String language;

  final Translator translator;

  LoadingPageViewModel(this.language, this.state)
      : translator = new Translator(language, translationOverrides),
        super(equals: [state, language]);
}

abstract class LoadingPageState
    implements Built<LoadingPageState, LoadingPageStateBuilder> {
  bool get isAppLoaded;

  LoadingPageState._();

  factory LoadingPageState([void Function(LoadingPageStateBuilder) updates]) {
    return new _$LoadingPageState(updates);
  }

  factory LoadingPageState.create(bool isAppLoaded) {
    return new LoadingPageState((b) {
      b.isAppLoaded = isAppLoaded;
    });
  }
}

const Map<String, Map<String, String>> translationOverrides = {};
