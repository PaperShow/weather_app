import 'package:flutter/material.dart';
import 'package:weather_app/app/theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  ThemeData _themeData = lightTheme;
  ThemeData get themeData => _themeData;

  set themeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightTheme) {
      _isDark = true;
      _themeData = darkTheme;
    } else {
      _isDark = false;
      _themeData = lightTheme;
    }
    notifyListeners();
  }
}
