import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:vaccination_helper/core/auth/dtos/doctor_register_dto.dart';
import 'package:vaccination_helper/core/auth/dtos/patient_register_dto.dart';
import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';

part 'patient_register_state.g.dart';

abstract class PatientRegisterState
    implements Built<PatientRegisterState, PatientRegisterStateBuilder> {
  bool get isLoading;

  bool get isSuccessful;

  @nullable
  BaseException get exception;

  PatientRegisterDto get payload;

  PatientRegisterState._();

  factory PatientRegisterState(
      [void Function(PatientRegisterStateBuilder) updates]) {
    return new _$PatientRegisterState(updates);
  }

  factory PatientRegisterState.create() {
    return new PatientRegisterState((b) {
      b.isLoading = false;
      b.isSuccessful = false;
      b.payload = new PatientRegisterDto.create();
    });
  }

  PatientRegisterState setResult(BaseException exception) {
    return this.rebuild((b) {
      b.isLoading = false;
      b.exception = exception;
      b.isSuccessful = exception == null;
    });
  }

  PatientRegisterState loading() {
    return this.rebuild((b) => b
      ..isLoading = true
      ..isSuccessful = false
      ..exception = null);
  }

  PatientRegisterState clearFeedback() {
    return this.rebuild((b) {
      b.isSuccessful = false;
      b.exception = null;
    });
  }
}
