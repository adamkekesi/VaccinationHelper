import 'package:vaccination_helper/core/role/entity/role_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  String id;

  String email;

  String username;

  bool verified;

  List<RoleEntity> roles;

  UserEntity();

  static UserEntity fromJson(Map<String, dynamic> json) {
    return _$UserEntityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  UserState toImmutableState() {
    return new UserState.fromUserEntity(this);
  }
}

abstract class UserState implements Built<UserState, UserStateBuilder> {
  String get id;

  String get email;

  String get username;

  bool get verified;

  BuiltList<RoleState> get roles;

  UserState._();

  factory UserState([void Function(UserStateBuilder) updates]) {
    return new _$UserState(updates);
  }

  factory UserState.fromUserEntity(UserEntity entity) {
    return new _$UserState((b) {
      b.id = entity.id;
      b.email = entity.email;
      b.username = entity.username;
      b.verified = entity.verified;
      b.roles.addAll(entity.roles.map((r) => new RoleState.fromRoleEntity(r)));
    });
  }
}
