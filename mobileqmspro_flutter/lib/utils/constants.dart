import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobileqmspro/utils/functions.dart';

class Constant {
  static bool sendTestException = false;
}

const String myBaseUrl = (kReleaseMode == true)
    ? 'https://mobileqms.com/'
    : 'http://localhost:1234/';
const String privacyUrl = 'https://mobileqms.com/privacy.html';
const String termUrl = 'https://mobileqms.com/terms.html';
const String baseMobileQMSProWeb = '${myBaseUrl}pro/';
const String configFile =
    (kReleaseMode == true) ? 'production.yaml' : 'development.yaml';

class Texts {
  static const String appName = "MobileQMSPro";
}

class WidgetProp {
  static const double width = 500;
}

class Prefs {
  static const String language = "lang";
  static const String userProfileKey = "userProfileKey";
  static const String windowName = "windowName";
  static const String windowEmail = "windowEmail";
  static const String windowPhone = "windowPhone";
  static const String ttsLang = "ttsLang";
  static const String ttsVolume = "ttsVolume";
  static const String ttsPitch = "ttsPitch";
  static const String ttsRate = "ttsRate";
  static const String boardBgColor = "boardBgColor";
  static const String boardTextColor = "boardTextColor";
  static const String boardNumBox = "boardNumBox";
  static const String printFontScale = "printFontScale";
  static const String printPageSize = "printPageSize";
  static const String proceedText = "proceedText";
  static const String appearanceDark = "appearanceDark";
  static const String domainName = "domainName";
  static const String ipAddress = "ipAddress";
  static const String numTokenDaily = "numTokenDaily";
  static const String autoStartServer = "autoStartServer";
  static const String mobileQmsAppReview = "mobileQmsAppReview";
  static const String volume = "volume";
  static const String pitch = "pitch";
  static const String rate = "rate";
}

class StatusAcronym {
  static const String onwait = "W";
  static const String onqueue = "Q";
  static const String completed = "C";
  static const String recall = "R";
  static const String timeout = "T";
}

class Status {
  static const String onwait = "onWait";
  static const String onqueue = "onQueue";
  static const String completed = "completed";
  static const String recall = "recall";
  static const String timeout = "timeout";
}

class StatusCode {
  static const int onwait = 100;
  static const int onqueue = 200;
  static const int recall = 300;
  static const int completed = 400;
  static const int timeout = 500;
}

class Printer {
  static const String deviceName = 'bluetooth_device_name';
  static const String deviceId = 'bluetooth_device_id';
  static const String diviceConnected = 'bluetooth_device_connected';
}

const List<Color> coolColors = <Color>[
  Color.fromARGB(255, 255, 59, 48),
  Color.fromARGB(255, 255, 149, 0),
  Color.fromARGB(255, 255, 204, 0),
  Color.fromARGB(255, 76, 217, 100),
  Color.fromARGB(255, 90, 200, 250),
  Color.fromARGB(255, 0, 122, 255),
  Color.fromARGB(255, 88, 86, 214),
  Color.fromARGB(255, 255, 45, 85),
];

class StatusColor {
  static const Color onwait = Colors.orange;
  static const Color onqueue = Colors.green;
  static const Color recall = Colors.red;
  static const Color completed = Colors.blue;
  static const Color timeout = Colors.pinkAccent;
}

Map<int, Color> colorMaterial = {
  50: const Color.fromRGBO(136, 14, 79, .1),
  100: const Color.fromRGBO(136, 14, 79, .2),
  200: const Color.fromRGBO(136, 14, 79, .3),
  300: const Color.fromRGBO(136, 14, 79, .4),
  400: const Color.fromRGBO(136, 14, 79, .5),
  500: const Color.fromRGBO(136, 14, 79, .6),
  600: const Color.fromRGBO(136, 14, 79, .7),
  700: const Color.fromRGBO(136, 14, 79, .8),
  800: const Color.fromRGBO(136, 14, 79, .9),
  900: const Color.fromRGBO(136, 14, 79, 1),
};

class ScreenProp {
  static const double width = 700;
  static const double widthScreenLimit = 900;
  static const double widthPhoneScreenLimit = 500;
  static const double heightSettingMenu = 300;

  static double widthExpanded(BuildContext context) {
    double widthExpanded = (Utils.isPhoneSize(context) == true) ? 240 : 280;
    return widthExpanded;
  }
}
