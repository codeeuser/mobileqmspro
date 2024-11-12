import 'package:catcher_2/catcher_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobileqmspro_flutter/app_log.dart';
import 'package:provider/provider.dart';

class Logger {
  static const bool b = false;
  static void log(String? tag, {required String? message}) {
    assert(tag != null);

    if (kReleaseMode == b) {
      final f = DateFormat('HH:mm:S');
      String s = f.format(DateTime.now());
      // ignore: avoid_print
      print("[$tag][$s] $message");
    }
  }

  static void debug(String? tag, {required String? message}) {
    assert(tag != null);
    final f = DateFormat('HH:mm:S');
    String s = f.format(DateTime.now());
    // ignore: avoid_print
    print("[$tag][$s] $message");
  }

  static void logDio(BuildContext context, String obj) {
    if (kReleaseMode == b) {
      final f = DateFormat('HH:mm:S');
      String s = f.format(DateTime.now());
      // ignore: avoid_print
      print("['DIOLOG'][$s] $obj");
    }
    obj = obj.replaceAll('=', '');
    obj = obj.replaceAll('onResponse', '');
    obj = obj.replaceAll('BEGIN', '');
    obj = obj.replaceAll('END', '');
    if (obj.isNotEmpty) {
      obj = obj.replaceAll('\n', '');
      obj += '\n';
    }
    AppLog appLog = context.read<AppLog>();
    appLog.logDioMessage = obj;
  }

  static reportCheckedError(e, s) {
    if (kReleaseMode == b) {
      // ignore: avoid_print
      print("$e $s");
    }
  }

  static sendCatcherError(tag, e, s) {
    final f = DateFormat('HH:mm:S');
    String time = f.format(DateTime.now());
    Catcher2.reportCheckedError('[$tag][$time] $e', s);
    if (kReleaseMode == b) {
      // ignore: avoid_print
      print("[$tag][$time] $e");
    }
  }

  static sendTestException() {
    if (kReleaseMode == true) {
      Catcher2.sendTestException();
    }
  }
}
