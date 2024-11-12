import 'package:flutter/material.dart';

class AppLog extends ChangeNotifier {
  String? _logDioMessage;
  set logDioMessage(String? logDioMessage) {
    _logDioMessage = logDioMessage;
    notifyListeners();
  }

  String? get logDioMessage {
    return _logDioMessage;
  }

  void cleanLogDioMessage() {
    _logDioMessage = null;
  }
}
