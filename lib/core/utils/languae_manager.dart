// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum LanguageType { ENGLISH, VIETNAMESE }

const String ENGLISH = "en";
const String VIETNAMESE = "vi";
const Locale VIETNAM_LOCAL = Locale("vi", "VI");
const Locale ENGLISH_LOCAL = Locale("en", "US");
const String ASSETS_PATH_LOCALISATIONS = "assets/translations";

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
