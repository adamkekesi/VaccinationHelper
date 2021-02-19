import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:vaccination_helper/core/auth/dtos/doctor_register_dto.dart';
import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';

part 'doctor_register_state.g.dart';

abstract class DoctorRegisterState
    implements Built<DoctorRegisterState, DoctorRegisterStateBuilder> {
  bool get isLoading;

  bool get isSuccessful;

  @nullable
  BaseException get exception;

  DoctorRegisterDto get payload;

  DoctorRegisterState._();

  factory DoctorRegisterState(
      [void Function(DoctorRegisterStateBuilder) updates]) {
    return new _$DoctorRegisterState(updates);
  }

  factory DoctorRegisterState.create() {
    return new DoctorRegisterState((b) {
      b.isLoading = false;
      b.isSuccessful = false;
      b.payload = new DoctorRegisterDto.create();
    });
  }

  DoctorRegisterState setResult(BaseException exception) {
    return this.rebuild((b) {
      b.isLoading = false;
      b.exception = exception;
      b.isSuccessful = exception == null;
    });
  }
}
