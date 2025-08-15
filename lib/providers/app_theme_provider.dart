import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static const String saveAppTheme = 'save_app_theme';
}

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.system;

  AppThemeProvider() {
    _loadThemeFromPrefs();
  }

  void changeTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) return;
    appTheme = newTheme;
    notifyListeners();
    await _saveThemeToPrefs(newTheme);
  }

  bool isDarkMode() => appTheme == ThemeMode.dark;

  Future<void> _saveThemeToPrefs(ThemeMode themeMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPreference.saveAppTheme, themeMode.name);
  }

  Future<void> _loadThemeFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final themeStr = prefs.getString(SharedPreference.saveAppTheme);

    switch (themeStr) {
      case 'light':
        appTheme = ThemeMode.light;
        break;
      case 'dark':
        appTheme = ThemeMode.dark;
        break;
      case 'system':
      default:
        appTheme = ThemeMode.system;
    }

    notifyListeners();
  }
}
