import 'package:vaccination_helper/core/role/entity/operation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'resource.g.dart';

@JsonSerializable()
class Resource {
  String name;

  List<Operation> operations;

  Resource();

  static Resource fromJson(Map<String, dynamic> json) {
    return _$ResourceFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResourceToJson(this);

  ResourceState toImmutableState() {
    return new ResourceState.fromResource(this);
  }
}

abstract class ResourceState
    implements Built<ResourceState, ResourceStateBuilder> {
  String get name;

  BuiltList<OperationState> get operations;

  ResourceState._();

  factory ResourceState([void Function(ResourceStateBuilder) updates]) {
    return new _$ResourceState(updates);
  }

  factory ResourceState.fromResource(Resource resource) {
    return new ResourceState((b) {
      b.name = resource.name;
      b.operations.addAll(resource.operations
          .map((operation) => OperationState.fromOperation(operation)));
    });
  }
}
