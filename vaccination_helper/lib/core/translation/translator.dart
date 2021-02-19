import 'package:vaccination_helper/core/translation/global_translations.dart';
import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';

class Translator {
  final String language;

  final Map<String, Map<String, String>> translations;

  Translator(this.language, [Map<String, Map<String, String>> overrides])
      : translations = {...globalTranslations, ...overrides ?? {}};

  String translateException(BaseException exception) {
    return exception.errorMessage[language];
  }

  String translateKey(String translationKey) {
    if (!translations.containsKey(translationKey)) {
      return translationKey;
    }
    return translations[translationKey][language];
  }
}
