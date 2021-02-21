import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:vaccination_helper/core/auth/actions/logout_action.dart';
import 'package:vaccination_helper/core/auth/state/auth_state.dart';
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:vaccination_helper/helpers/types.dart';
import 'package:vaccination_helper/pages/login_singup/login_signup_connector.dart';
import 'package:vaccination_helper/pages/user_home/main.drawer.dart';

part 'main_drawer_connector.g.dart';

class MainDrawerConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MainDrawerViewModel>(
        vm: () => new MainDrawerVmFactory(this),
        builder: (BuildContext context, MainDrawerViewModel vm) {
          return MainDrawer(user: vm.state.authState.user, logout: vm.logout);
        });
  }
}

class MainDrawerVmFactory extends VmFactory<AppState, MainDrawerConnector> {
  MainDrawerVmFactory(widget) : super(widget);

  @override
  MainDrawerViewModel fromStore() {
    return new MainDrawerViewModel(
        new MainDrawerState.create(state.authState), logout);
  }

  void logout(BuildContext context) async {
    try {
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (c) => LoginSignupConnector()));
      await dispatchFuture(new LogoutAction());
    } catch (e) {}
  }
}

class MainDrawerViewModel extends Vm {
  final MainDrawerState state;

  final BuildContextFunction logout;

  MainDrawerViewModel(this.state, this.logout) : super(equals: [state]);
}

abstract class MainDrawerState
    implements Built<MainDrawerState, MainDrawerStateBuilder> {
  AuthState get authState;

  MainDrawerState._();

  factory MainDrawerState([void Function(MainDrawerStateBuilder) updates]) {
    return new _$MainDrawerState(updates);
  }

  factory MainDrawerState.create(AuthState authState) {
    return new MainDrawerState((b) {
      b.authState.replace(authState);
    });
  }
}
