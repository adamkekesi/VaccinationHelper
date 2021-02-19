import 'package:json_annotation/json_annotation.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'operation.g.dart';

@JsonSerializable()
class Operation {
  String name;

  bool every;

  Operation();

  static Operation fromJson(Map<String, dynamic> json) {
    return _$OperationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OperationToJson(this);

  OperationState toImmutableState() {
    return new OperationState.fromOperation(this);
  }
}

abstract class OperationState
    implements Built<OperationState, OperationStateBuilder> {
  String get name;

  bool get every;

  OperationState._();

  factory OperationState([void Function(OperationStateBuilder) updates]) {
    return new _$OperationState(updates);
  }

  factory OperationState.fromOperation(Operation operation) {
    return new OperationState((b) {
      b.name = operation.name;
      b.every = operation.every;
    });
  }
}
