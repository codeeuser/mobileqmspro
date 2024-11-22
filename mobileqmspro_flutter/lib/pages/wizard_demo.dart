// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobileqmspro/app_profile.dart';
import 'package:mobileqmspro/generated/l10n.dart';
import 'package:mobileqmspro/logger.dart';
import 'package:mobileqmspro/pages/ways_page.dart';
import 'package:mobileqmspro/serverpod_client.dart';
import 'package:mobileqmspro/utils/constants.dart';
import 'package:mobileqmspro/utils/functions.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:serverpod_auth_google_flutter/serverpod_auth_google_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WizardDemo extends StatefulWidget {
  final SharedPreferences prefs;

  const WizardDemo({super.key, required this.prefs});

  @override
  State<WizardDemo> createState() => _WizardDemoState();
}

class _WizardDemoState extends State<WizardDemo> {
  static const String tag = "WizardDemo";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: true,
            title: Text(S.of(context).windowWizard),
            backgroundColor: const Color.fromRGBO(35, 197, 221, 1.0),
          ),
          body: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: (constraints.maxWidth > WidgetProp.width)
                    ? WidgetProp.width
                    : constraints.maxWidth,
                height: double.infinity,
                child: _buildContent(),
              )));
    });
  }

  Widget _buildContent() {
    var text = RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.labelMedium,
        children: const <TextSpan>[
          TextSpan(
              text:
                  'You will create a Demo project that pre-defined Window and Services. '),
          TextSpan(
              text:
                  'Window name may be your business name. Window name here will be '),
          TextSpan(
              text: '"Demo Wheref". ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
              text:
                  'Service name may be your business provided services. Service name here will be '),
          TextSpan(
              text: '"Payment", ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
              text: '"Booking" ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'and '),
          TextSpan(
              text: '"Information". ',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: text,
          ),
          const SizedBox(height: 20),
          SignInWithEmailButton(
              caller: client.modules.auth,
              minPasswordLength: 8,
              onSignedIn: () async {
                await _onSignedIn();
              }),
          const SizedBox(height: 20),
          SignInWithGoogleButton(
            caller: client.modules.auth,
            redirectUri: Uri.parse('https://wheref.com/mobileqmspro.php'),
            onSignedIn: () async {
              await _onSignedIn();
            },
            onFailure: () {
              Logger.log(tag, message: 'SignInWithGoogleButton onFailure---');
            },
          ),
          const SizedBox(height: 60),
          _showAgreement(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _showAgreement() {
    var text = RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodySmall,
        children: <TextSpan>[
          const TextSpan(text: 'By clicking '),
          const TextSpan(
              text: 'Log In ', style: TextStyle(fontWeight: FontWeight.bold)),
          const TextSpan(text: ', you agree to our '),
          TextSpan(
              text: 'Terms of Service',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Utils.launchURLString(termUrl);
                }),
          const TextSpan(text: ' and '),
          TextSpan(
              text: 'Privacy Policy',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Utils.launchURLString(privacyUrl);
                }),
          const TextSpan(
              text:
                  '. You may receive Email Notifications or Push Notification from ${Utils.titleApp} '),
          const TextSpan(text: 'and can opt out at any time. '),
        ],
      ),
    );
    return Padding(
        padding: const EdgeInsets.all(16), child: Container(child: text));
  }

  Future<ProfileUser> _updateProfileUser(ProfileUser profileUser) async {
    profileUser.verified = true;
    // profileUser.ipAddress = '';
    final profileUserUpdate = await client.profileUser.update(profileUser);
    return profileUserUpdate;
  }

  Future<void> _logLogin(int? profileId) async {
    if (profileId == null) return;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final logLogin = LogLogin(
        createdDate: DateTime.now(),
        appVersion: packageInfo.version,
        appVersionCode: packageInfo.buildNumber,
        platform: (Utils.isIos)
            ? 'ios'
            : (Utils.isAndroid)
                ? 'android'
                : (Utils.isMacos)
                    ? 'macos'
                    : '',
        deviceName: '',
        deviceOs: json.encode(deviceInfo.data),
        deviceRelease: '',
        msgToken: '',
        profileUserId: profileId);
    await client.logLogin.create(logLogin);
  }

  Future<void> _createDemoProject(ProfileUser profileUser) async {
    final count = await client.queueWindow.countByEmail(profileUser.email);
    final hasProject = count > 0;
    if (hasProject == false) {
      bool success = await _createDemo(profileUser);
      if (success == false) {
        Utils.overlayInfoMessage(msg: S.of(context).noAction);
        return;
      }
    }
  }

  Future<bool> _createDemo(ProfileUser profileUser) async {
    final profileUserId = profileUser.id;
    if (profileUserId != null) {
      DateTime now = DateTime.now();
      QueueWindow window = QueueWindow(
          name: 'Demo Wheref',
          selected: true,
          orderNum: 1,
          createdDate: now,
          profileUserId: profileUserId);
      window = await client.queueWindow.create(window);

      final windowId = window.id;
      if (windowId != null) {
        QueueService service01 = QueueService(
            name: 'Payment',
            letter: 'P',
            start: 100,
            orderNum: 1,
            enable: true,
            createdDate: now,
            queueWindowId: windowId,
            profileUserId: profileUserId);
        QueueService service02 = QueueService(
            name: 'Booking',
            letter: 'B',
            start: 200,
            orderNum: 2,
            enable: true,
            createdDate: now,
            queueWindowId: windowId,
            profileUserId: profileUserId);
        QueueService service03 = QueueService(
            name: 'Information',
            letter: 'INF',
            start: 300,
            orderNum: 3,
            enable: true,
            createdDate: now,
            queueWindowId: windowId,
            profileUserId: profileUserId);
        await client.queueService.createAll([service01, service02, service03]);
        return true;
      }
    }
    return false;
  }

  Future<void> _onSignedIn() async {
    final userInfo = sessionManager.signedInUser;
    final email = userInfo?.email;
    Logger.log(tag, message: 'userInfo: $userInfo');
    if (userInfo == null || email == null) {
      Utils.overlayInfoMessage(msg: S.of(context).noAction);
      return;
    }
    // login
    ProfileUser? profileUser = await client.profileUser.login(email);
    Logger.log(tag, message: 'email: $email');
    await _createDemoProject(profileUser);
    await _logLogin(profileUser.id);
    final profileUserUpdate = await _updateProfileUser(profileUser);

    AppProfile appProfile = context.read<AppProfile>();
    appProfile.profileUser = profileUserUpdate;
    await widget.prefs.setString(Prefs.windowEmail, email);

    Utils.pushPage(
        context,
        WaysPage(
          key: const ValueKey('ways-page'),
          prefs: widget.prefs,
        ),
        'PasscodePage');
  }
}
