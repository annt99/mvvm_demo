// ignore_for_file: constant_identifier_names

import 'dart:ui';

import 'package:mvvm_demo/core/utils/languae_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN = "PREFS_KEY_ONBOARDING_SCREEN";
const String PREFS_KEY_USER_LOGGED = "PREFS_KEY_USER_LOGGED";

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.get(PREFS_KEY_LANG) as String?;
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<Locale> getLocal() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.ENGLISH.getValue()) {
      // return arabic local
      return ENGLISH_LOCAL;
    } else {
      // return english local
      return VIETNAM_LOCAL;
    }
  }

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN, true);
  }

  Future<void> setIsLogged() async {
    _sharedPreferences.setBool(PREFS_KEY_USER_LOGGED, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN) ?? false;
  }

  Future<bool> isLogged() async {
    return _sharedPreferences.getBool(PREFS_KEY_USER_LOGGED) ?? false;
  }
}
