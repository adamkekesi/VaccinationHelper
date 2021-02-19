import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'invalid_fields.g.dart';

@JsonSerializable()
class InvalidFields extends BaseException {
  Map<String, InvalidField> fields;

  InvalidFields();

  static InvalidFields fromJson(Map<String, dynamic> json) {
    return _$InvalidFieldsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InvalidFieldsToJson(this);
}

@JsonSerializable()
class InvalidField {
  List<String> errorCodes;

  Map<String, InvalidField> children;

  InvalidField();

  static InvalidField fromJson(Map<String, dynamic> json) {
    return _$InvalidFieldFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InvalidFieldToJson(this);

  InvalidFieldState toImmutableState() {
    return new InvalidFieldState.fromInvalidField(this);
  }
}

abstract class InvalidFieldState
    implements Built<InvalidFieldState, InvalidFieldStateBuilder> {
  BuiltList<String> get errorCodes;

  @nullable
  BuiltMap<String, InvalidField> get children;

  InvalidFieldState._();

  factory InvalidFieldState([void Function(InvalidFieldStateBuilder) updates]) {
    return new _$InvalidFieldState(updates);
  }

  factory InvalidFieldState.fromInvalidField(InvalidField invalidField) {
    return new InvalidFieldState((b) {
      b.errorCodes.addAll(invalidField.errorCodes);
      b.children.replace(invalidField.children);
    });
  }
}
