import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:vaccination_helper/core/settings/settings_persist.dart';

part 'settings_state.g.dart';

abstract class SettingsState
    implements Built<SettingsState, SettingsStateBuilder> {
  String get language;

  SettingsState._();

  factory SettingsState([void Function(SettingsStateBuilder) updates]) {
    return new _$SettingsState(updates);
  }

  factory SettingsState.initial() {
    return new SettingsState((b) {
      b.language = SettingsPersist.language;
    });
  }

  SettingsState changeLanguage(String language) {
    return this.rebuild((b) {
      b.language = language;
    });
  }
}
