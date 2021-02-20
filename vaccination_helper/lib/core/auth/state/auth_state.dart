import 'package:built_value/built_value.dart';
import 'package:vaccination_helper/core/user/user_entity.dart';

part 'auth_state.g.dart';

abstract class AuthState implements Built<AuthState, AuthStateBuilder> {
  @nullable
  UserEntity get user;

  @nullable
  String get jwt;

  AuthState._();

  factory AuthState([void Function(AuthStateBuilder) updates]) {
    return new _$AuthState(updates);
  }

  factory AuthState.initial() {
    return new AuthState((b) {});
  }

  factory AuthState.withJwt(String jwt) {
    return new AuthState((b) {
      b.jwt = jwt;
    });
  }

  factory AuthState.withUserData(UserEntity user, String jwt) {
    return new AuthState((b) {
      b.user = user;
      b.jwt = jwt;
    });
  }

  factory AuthState.notLoggedInState() {
    return new AuthState((b) {});
  }
}
