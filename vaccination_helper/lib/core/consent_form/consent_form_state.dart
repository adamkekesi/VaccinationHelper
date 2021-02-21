import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'consent_form_state.g.dart';

abstract class ConsentFormState implements Built<ConsentFormState, ConsentFormStateBuilder> {
  

  ConsentFormState._();

  factory ConsentFormState([void Function(ConsentFormStateBuilder) updates]) {
    return new _$ConsentFormState(updates);
  }
}