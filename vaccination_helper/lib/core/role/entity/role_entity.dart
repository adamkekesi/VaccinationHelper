import 'package:vaccination_helper/core/role/entity/resource.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'role_entity.g.dart';

@JsonSerializable()
class RoleEntity {
  String id;

  String name;

  List<Resource> grants;

  RoleEntity();

  static RoleEntity fromJson(Map<String, dynamic> json) {
    return _$RoleEntityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RoleEntityToJson(this);

  RoleState toImmutableState() {
    return new RoleState.fromRoleEntity(this);
  }
}

abstract class RoleState implements Built<RoleState, RoleStateBuilder> {
  String get id;

  String get name;

  BuiltList<ResourceState> get grants;

  RoleState._();

  factory RoleState([void Function(RoleStateBuilder) updates]) {
    return new _$RoleState(updates);
  }

  factory RoleState.fromRoleEntity(RoleEntity entity) {
    return new RoleState((b) {
      b.id = entity.id;
      b.name = entity.name;
      b.grants.addAll(entity.grants
          .map((resource) => ResourceState.fromResource(resource)));
    });
  }
}
