import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ValueNotifier<Locale?> appLocale =
ValueNotifier<Locale?>(null);

const String _localeKey = 'app_locale';

Future<void> loadSavedLocale() async {
  final prefs = await SharedPreferences.getInstance();

  final savedLanguageCode =
  prefs.getString(_localeKey);

  if (savedLanguageCode == null) {
    appLocale.value = null;
    return;
  }

  appLocale.value =
      Locale(savedLanguageCode);
}

Future<void> changeAppLocale(
    String languageCode,
    ) async {
  final prefs =
  await SharedPreferences.getInstance();

  await prefs.setString(
    _localeKey,
    languageCode,
  );

  appLocale.value =
      Locale(languageCode);
}