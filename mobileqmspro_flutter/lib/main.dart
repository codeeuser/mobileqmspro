import 'dart:async';

import 'package:catcher_2/catcher_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:mobileqmspro/app_profile.dart';
import 'package:mobileqmspro/app_theme.dart';
import 'package:mobileqmspro/generated/l10n.dart';
import 'package:mobileqmspro/logger.dart';
import 'package:mobileqmspro/pages/ways_page.dart';
import 'package:mobileqmspro/pages/web_page.dart';
import 'package:mobileqmspro/serverpod_client.dart';
import 'package:mobileqmspro/utils/functions.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();

    SharedPreferences.setPrefix('mobileqmspro_');
    final sharedPreference = await SharedPreferences.getInstance();

    await initializeServerpodClient();

    // handle Windows Size
    if (Utils.isMacos || Utils.isWindows) {
      await windowManager.ensureInitialized();

      WindowOptions windowOptions = const WindowOptions(
        size: Size(400, 800),
        minimumSize: Size(400, 600),
        center: true,
        skipTaskbar: false,
      );
      windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.setTitleBarStyle(
          TitleBarStyle.hidden,
          windowButtonVisibility: true,
        );
        await windowManager.show();
        await windowManager.focus();
      });
    }
    DateTime now = DateTime.now().toLocal();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    if (kIsWeb) {
      usePathUrlStrategy();
    }

    String? reportUrl = mapConfig['serverpod']['reportUrl'];

    Catcher2Options debugOptions = Catcher2Options(SilentReportMode(), [
      ConsoleHandler(
          enableApplicationParameters: false,
          enableDeviceParameters: false,
          enableCustomParameters: false)
    ]);
    Catcher2Options releaseOptions = Catcher2Options(SilentReportMode(), [
      if (reportUrl != null && reportUrl.trim() != '') ...[
        HttpHandler(
          HttpRequestType.post,
          Uri.parse(reportUrl),
          enableCustomParameters: true,
          printLogs: true,
        ),
      ],
      ConsoleHandler(
          enableApplicationParameters: false,
          enableDeviceParameters: false,
          enableCustomParameters: false)
    ], customParameters: {
      'timeZoneOffset': now.timeZoneOffset.inHours.toString(),
      'timeZoneName': now.timeZoneName,
      'appName': 'mobileQMSPro',
      'appVersion':
          '${packageInfo.version}, buildNumber:${packageInfo.buildNumber}',
      'platform': Utils.getPlatformName(),
      'ipInfo': '',
    });
    Catcher2.addDefaultErrorWidget(showStacktrace: true);

    Catcher2(
        navigatorKey: Catcher2.navigatorKey,
        rootWidget: buildProvider(sharedPreference),
        debugConfig: debugOptions,
        releaseConfig: releaseOptions);
  });
}

Widget buildProvider(SharedPreferences prefs) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppProfile()),
      ChangeNotifierProvider(create: (_) => AppTheme(prefs: prefs)),
    ],
    child: MyApp(prefs: prefs),
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({super.key, required this.prefs});

  static const String tag = 'MyApp';

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(builder: (context, appTheme, _) {
      return OverlaySupport.global(
          child: MaterialApp(
        title: 'MobileQMS Pro',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          S.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale('en'),
        themeMode: appTheme.appearanceDark ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
            primaryColor: Colors.white,
            brightness: Brightness.light,
            primaryColorDark: Colors.black,
            canvasColor: Colors.white,
            buttonTheme: const ButtonThemeData(
              buttonColor: Colors.black,
              textTheme: ButtonTextTheme.accent,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity),
        darkTheme: ThemeData(
          cupertinoOverrideTheme: const CupertinoThemeData(
            textTheme: CupertinoTextThemeData(), // This is required
          ),
          primaryColor: Colors.black,
          primaryColorLight: Colors.black,
          brightness: Brightness.dark,
          primaryColorDark: Colors.black,
          indicatorColor: Colors.white,
          canvasColor: Colors.black,
          buttonTheme: const ButtonThemeData(
            buttonColor: Colors.white,
            textTheme: ButtonTextTheme.normal,
          ),
        ),
        onGenerateRoute: (settings) {
          String? name = settings.name;
          name = name?.substring(1, name.length);
          Logger.log(tag, message: 'name: $name');
          List<String>? segments = name?.split('/');
          String param = segments?.first ?? '';
          Logger.debug(tag, message: 'param: $param');
          int? windowId = int.tryParse(param);
          return MaterialPageRoute(builder: (context) {
            return (kIsWeb && windowId != null)
                ? WebPage(windowId: windowId)
                : (kIsWeb == false)
                    ? WaysPage(key: const ValueKey('ways-page'), prefs: prefs)
                    : const Placeholder();
          });
        },
      ));
    });
  }
}
