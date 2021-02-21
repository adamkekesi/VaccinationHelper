import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:vaccination_helper/pages/user_home/user_home.dart';

part 'user_home_connector.g.dart';

class UserHomeConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserHomeViewModel>(
        vm: () => new UserHomeVmFactory(this),
        builder: (BuildContext context, UserHomeViewModel vm) {
          return UserHome();
        });
  }
}

class UserHomeVmFactory extends VmFactory<AppState, UserHomeConnector> {
  UserHomeVmFactory(widget) : super(widget);

  @override
  UserHomeViewModel fromStore() {
    return new UserHomeViewModel(new UserHomeState.create());
  }
}

class UserHomeViewModel extends Vm {
  final UserHomeState state;

  UserHomeViewModel(this.state) : super(equals: [state]);
}

abstract class UserHomeState
    implements Built<UserHomeState, UserHomeStateBuilder> {
  UserHomeState._();

  factory UserHomeState([void Function(UserHomeStateBuilder) updates]) {
    return new _$UserHomeState(updates);
  }

  factory UserHomeState.create() {
    return new UserHomeState((b) {});
  }
}
