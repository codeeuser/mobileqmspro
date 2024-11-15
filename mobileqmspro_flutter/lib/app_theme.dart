import 'package:flutter/material.dart';
import 'package:mobileqmspro/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme extends ChangeNotifier {
  final SharedPreferences prefs;

  AppTheme({required this.prefs}) {
    _readPersistTheme();
  }

  bool _appearanceDark = true;
  set appearanceDark(bool appearanceDark) {
    _appearanceDark = appearanceDark;
    _persistTheme(appearanceDark);
    notifyListeners();
  }

  bool get appearanceDark => _appearanceDark;

  void _persistTheme(bool? show) async {
    if (show != null) {
      await prefs.setBool(Prefs.appearanceDark, show);
    } else {
      await prefs.remove(Prefs.appearanceDark);
    }
  }

  void _readPersistTheme() {
    _appearanceDark = prefs.getBool(Prefs.appearanceDark) ?? true;
  }
}
