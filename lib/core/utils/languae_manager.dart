// ignore_for_file: constant_identifier_names

enum LanguageType { ENGLISH, VIETNAMESE }

const String ENGLISH = "en";
const String VIETNAMESE = "vi";

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.VIETNAMESE:
        return VIETNAMESE;
    }
  }
}
