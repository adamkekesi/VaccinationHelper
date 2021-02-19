import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:vaccination_helper/core/auth/auth_persist.dart';
import 'package:vaccination_helper/core/auth/responses/login_response.dart';
import 'package:vaccination_helper/core/user/user_entity.dart';

part 'auth_state.g.dart';

abstract class AuthState implements Built<AuthState, AuthStateBuilder> {
  @nullable
  UserState get user;

  @nullable
  String get jwt;

  AuthState._();

  factory AuthState([void Function(AuthStateBuilder) updates]) {
    return new _$AuthState(updates);
  }

  factory AuthState.initial() {
    return new AuthState((b) {
      b.jwt = AuthPersist.jwt;
    });
  }

  factory AuthState.withUserData(UserEntity user, String jwt) {
    return new AuthState((b) {
      b.user.replace(UserState.fromUserEntity(user));
      b.jwt = jwt;
    });
  }

  factory AuthState.notLoggedInState() {
    return new AuthState((b) {});
  }
}
