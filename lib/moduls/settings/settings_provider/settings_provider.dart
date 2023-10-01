import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String currentLanguage = "ar";

  selectArabicLanguage() {
    currentLanguage = "ar";
    notifyListeners();
  }

  selectEnglishLanguage() {
    currentLanguage = "en";
    notifyListeners();
  }

  enableDarkTheme() {
    themeMode = ThemeMode.dark;
    notifyListeners();
  }

  enableLightTheme() {
    themeMode = ThemeMode.light;
    notifyListeners();
  }

  bool isDark() {
    return themeMode == ThemeMode.dark;
  }



  }

