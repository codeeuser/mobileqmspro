import 'dart:io';
import 'dart:math';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:intl/intl.dart';
import 'package:mobileqmspro/generated/l10n.dart';
import 'package:mobileqmspro/logger.dart';
import 'package:mobileqmspro/utils/constants.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher_string.dart';

class Utils {
  static const String tag = 'Utils';
  static const String titleApp = 'MobileQMS Pro';

  static Future<void> exitApp(BuildContext context) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title: S.of(context).exitApplication.toUpperCase(),
      message: '${S.of(context).doYouAccept}?',
      onPopInvokedWithResult: (didPop, result) {
        Logger.log(tag, message: 'didPop: $didPop, result: $result');
      },
    );
    Logger.log(tag, message: 'resulttt: $result');
    if (result == OkCancelResult.ok) {
      if (defaultTargetPlatform == TargetPlatform.android) {
        SystemNavigator.pop();
      } else if (defaultTargetPlatform == TargetPlatform.iOS || isDesktop) {
        exit(0);
      }
    }
  }

  static String getPlatformName() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'Android';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 'iOS';
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      return 'Windows';
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      return 'macOS';
    } else if (defaultTargetPlatform == TargetPlatform.linux) {
      return 'Linux';
    } else if (kIsWeb) {
      return 'Web';
    } else {
      return 'Unknown';
    }
  }

  static Future<void> assignLanguage(SharedPreferences prefs) async {
    String? lang = prefs.getString(Prefs.language);
    lang = (lang == null) ? 'en' : lang;
    Logger.log(tag, message: 'lang: $lang');
    await prefs.setString(Prefs.language, lang);
    await S.load(Locale(lang, ''));
  }

  static bool get isDesktop {
    if (kIsWeb) return false;
    return [
      TargetPlatform.windows,
      TargetPlatform.linux,
      TargetPlatform.macOS,
    ].contains(defaultTargetPlatform);
  }

  static bool get isLinux {
    if (kIsWeb) return false;
    return [
      TargetPlatform.linux,
    ].contains(defaultTargetPlatform);
  }

  static bool get isWindows {
    if (kIsWeb) return false;
    return [
      TargetPlatform.windows,
    ].contains(defaultTargetPlatform);
  }

  static bool get isMacos {
    if (kIsWeb) return false;
    return [
      TargetPlatform.macOS,
    ].contains(defaultTargetPlatform);
  }

  static bool get isWebMobile {
    return kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);
  }

  static bool get isMobile {
    return (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android);
  }

  static bool get isIos {
    return (defaultTargetPlatform == TargetPlatform.iOS);
  }

  static bool get isAndroid {
    return (defaultTargetPlatform == TargetPlatform.android);
  }

  static bool get isTouchDevice {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.fuchsia;
  }

  static bool isPhoneSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width < ScreenProp.widthPhoneScreenLimit ? true : false;
  }

  static Widget goBackButton(goBackAction) {
    return IconButton(
      icon: const Icon(CupertinoIcons.chevron_left, semanticLabel: 'Next'),
      onPressed: goBackAction,
    );
  }

  static Widget getAppBarTitle(String title, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: Text(
        title,
        overflow: TextOverflow.fade,
        softWrap: true,
        maxLines: 2,
        style: const TextStyle(
            fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  static String printAgo(int? milliseconds, String locale) {
    if (milliseconds == null) return '';
    DateTime now = DateTime.now();
    final duration = now.millisecondsSinceEpoch - milliseconds;
    DateTime ago = now.subtract(Duration(milliseconds: duration));
    return timeago.format(ago, locale: locale);
  }

  static void pushPage(BuildContext context, Widget page, String name) {
    Logger.log(tag, message: 'pushPage: $page');
    Navigator.of(context).push(_createRouteScaleAnimation(page, name));
  }

  static void pushAndRemoveUntilPage(
      BuildContext context, Widget page, String name) {
    Logger.log(tag, message: 'pushAndRemoveUntilPage: $page');
    Navigator.of(context).pushAndRemoveUntil(
        _createRouteScaleAnimation(page, name), (Route<dynamic> route) => true);
  }

  static Route _createRouteScaleAnimation(Widget page, String name) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      settings: RouteSettings(name: name),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(begin: 0.95, end: 1.0);
        final scaleAnimation = animation.drive(tween);
        return Transform.scale(
          scale: scaleAnimation.value,
          child: child,
        );
      },
    );
  }

  static void pushNamedAndRemoveUntilPage(BuildContext context, String name) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(name, (Route<dynamic> route) => false);
  }

  static Color getStatusColor(String statusName) {
    if (statusName == Status.onwait) {
      return StatusColor.onwait;
    } else if (statusName == Status.onqueue) {
      return StatusColor.onqueue;
    } else if (statusName == Status.completed) {
      return StatusColor.completed;
    } else if (statusName == Status.recall) {
      return StatusColor.recall;
    } else if (statusName == Status.timeout) {
      return StatusColor.timeout;
    }
    return Colors.black;
  }

  static int nextNumber(int min, int max) => min + Random().nextInt(max - min);

  static String randomDigit(int numberOfDigit) {
    Random random = Random();
    String number = '';
    for (int i = 0; i < numberOfDigit; i++) {
      number = number + random.nextInt(9).toString();
    }
    return number;
  }

  static Future<void> launchURLString(String url) async {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }

  static String? printTokenInfo(
      String? windowName, String? serviceName, String? letter, int? num) {
    if (windowName == null ||
        serviceName == null ||
        letter == null ||
        num == null) return null;
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    String formatted = formatter.format(now);
    var text =
        '[MOBILEQMSPRO]\n$windowName\nSERVICE: $serviceName\nTOKEN: $letter-$num\n\n$formatted';
    return text;
  }

  static Future<String?> sendMessage(
      String message, List<String> recipents) async {
    bool canSend = await canSendSMS();
    if (canSend) {
      try {
        String result = await sendSMS(message: message, recipients: recipents);
        return result;
      } catch (error) {
        Logger.log(tag, message: '$error');
      }
    }
    return null;
  }

  static Widget loadingScreen() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  static void overlayInfoMessage(
      {String? key = 'default-key', required String msg}) {
    Icon icon = const Icon(
      CupertinoIcons.info,
      color: Colors.white,
      size: 24,
    );
    Color color = Colors.green;
    showSimpleNotification(Center(child: Text(msg)),
        leading: icon,
        background: color,
        position: NotificationPosition.bottom);
  }

  static void overlayWarnMessage(
      {String? key = 'default-key', required String msg}) {
    Icon icon = const Icon(
      CupertinoIcons.exclamationmark_circle,
      color: Colors.white,
      size: 24,
    );
    Color color = Colors.yellow;
    showSimpleNotification(Center(child: Text(msg)),
        leading: icon,
        background: color,
        position: NotificationPosition.bottom);
  }

  static void overlayAlertMessage(
      {String? key = 'default-key', required String msg}) {
    Icon icon = const Icon(
      CupertinoIcons.smiley,
      color: Colors.white,
      size: 24,
    );
    Color color = Colors.red;
    showSimpleNotification(Center(child: Text(msg)),
        leading: icon,
        background: color,
        position: NotificationPosition.bottom);
  }

  static Widget buildDesc(double size) {
    double fontSize = size / 2;
    TextStyle textStyle = TextStyle(color: Colors.blueGrey, fontSize: fontSize);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2),
                child: ClipOval(
                  child: Container(
                    color: Utils.getStatusColor(Status.onwait),
                    width: size,
                    height: size,
                    child: Center(
                        child: Text(StatusAcronym.onwait,
                            style: TextStyle(
                                fontSize: fontSize, color: Colors.white))),
                  ),
                ),
              ),
              Text(Status.onwait.toUpperCase(), style: textStyle)
            ],
          ),
          const SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2),
                child: ClipOval(
                  child: Container(
                    color: Utils.getStatusColor(Status.onqueue),
                    width: size,
                    height: size,
                    child: Center(
                        child: Text(StatusAcronym.onqueue,
                            style: TextStyle(
                                fontSize: fontSize, color: Colors.white))),
                  ),
                ),
              ),
              Text(Status.onqueue.toUpperCase(), style: textStyle)
            ],
          ),
          const SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2),
                child: ClipOval(
                  child: Container(
                    color: Utils.getStatusColor(Status.completed),
                    width: size,
                    height: size,
                    child: Center(
                        child: Text(StatusAcronym.completed,
                            style: TextStyle(
                                fontSize: fontSize, color: Colors.white))),
                  ),
                ),
              ),
              Text(Status.completed.toUpperCase(), style: textStyle)
            ],
          ),
          const SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2),
                child: ClipOval(
                  child: Container(
                    color: Utils.getStatusColor(Status.recall),
                    width: size,
                    height: size,
                    child: Center(
                        child: Text(StatusAcronym.recall,
                            style: TextStyle(
                                fontSize: fontSize, color: Colors.white))),
                  ),
                ),
              ),
              Text(Status.recall.toUpperCase(), style: textStyle)
            ],
          ),
          const SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2),
                child: ClipOval(
                  child: Container(
                    color: Utils.getStatusColor(Status.timeout),
                    width: size,
                    height: size,
                    child: Center(
                        child: Text(StatusAcronym.timeout,
                            style: TextStyle(
                                fontSize: fontSize, color: Colors.white))),
                  ),
                ),
              ),
              Text(Status.timeout.toUpperCase(), style: textStyle)
            ],
          ),
        ],
      ),
    );
  }
}

extension FileFormatter on num {
  String readableFileSize({bool base1024 = true}) {
    final base = base1024 ? 1024 : 1000;
    if (this <= 0) return "0";
    final units = ["B", "kB", "MB", "GB", "TB"];
    int digitGroups = (log(this) / log(base)).round();
    return "${NumberFormat("#,##0.#").format(this / pow(base, digitGroups))} ${units[digitGroups]}";
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
