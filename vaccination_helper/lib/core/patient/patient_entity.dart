/* import 'package:json_annotation/json_annotation.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:vaccination_helper/core/user/user_entity.dart';

part '.g.dart';

@JsonSerializable()
class PatientEntity {
  PatientEntity();

  static PatientEntity fromJson(Map<String, dynamic> json) {
    return _$PatientEntityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PatientEntityToJson(this);

  PatientState toImmutableState() {
    return new PatientState.fromPatientEntity(this);
  }
}

abstract class PatientState extends UserState
    implements Built<PatientState, PatientStateBuilder> {
  PatientState._();

  factory PatientState([void Function(PatientStateBuilder) updates]) {
    return new _$PatientState(updates);
  }

  factory PatientState.fromPatientEntity(PatientEntity) {
    return new PatientState((b) {});
  }
} */
