// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobileqmspro/app_profile.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';
import 'package:mobileqmspro/generated/l10n.dart';
import 'package:mobileqmspro/logger.dart';
import 'package:mobileqmspro/pages/ways_page.dart';
import 'package:mobileqmspro/serverpod_client.dart';
import 'package:mobileqmspro/utils/constants.dart';
import 'package:mobileqmspro/utils/functions.dart';
import 'package:mobileqmspro/utils/validation_function.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasscodePage extends StatefulWidget {
  final SharedPreferences prefs;
  final ProfileUser profileUser;
  const PasscodePage(
      {super.key, required this.prefs, required this.profileUser});

  @override
  State<PasscodePage> createState() => _PasscodePageState();
}

class _PasscodePageState extends State<PasscodePage> {
  static const String tag = "PasscodePage";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formPasscodeKey = GlobalKey<FormState>();
  final TextEditingController _passcodeController = TextEditingController();

  ProfileUser? _profileUser;

  @override
  void initState() {
    Logger.log(tag,
        message: 'initState---, passcode: ${widget.profileUser.passcode}');
    _profileUser = widget.profileUser;
    super.initState();
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
            title: Text(S.of(context).passcode),
            backgroundColor: const Color.fromRGBO(35, 197, 221, 1.0),
          ),
          body: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: (constraints.maxWidth > WidgetProp.width)
                    ? WidgetProp.width
                    : constraints.maxWidth,
                child: _buildContent(),
              )));
    });
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Form(
        key: _formPasscodeKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _showPasscodeMessage(),
              const SizedBox(height: 10),
              Text(_profileUser?.email ?? '',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 6,
                controller: _passcodeController,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  icon: const Icon(Icons.key,
                      color: Colors.grey, semanticLabel: 'Number'),
                  hintText: 'What is the PASSCODE?',
                  labelText: S.of(context).passcode,
                ),
                validator: (value) {
                  return validateDigitMinMax(value, 6, 6);
                },
              ),
              const SizedBox(height: 10),
              _showAgreement(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text(S.of(context).login.toUpperCase()),
                    onPressed: () async {
                      if (_formPasscodeKey.currentState?.validate() == false) {
                        Utils.overlayInfoMessage(msg: S.of(context).noAction);
                        return;
                      }
                      final passcode = _passcodeController.text;
                      final profileUser = _profileUser;
                      if (profileUser == null) return;
                      final email = profileUser.email;
                      final profileId = profileUser.id;
                      Logger.log(tag,
                          message:
                              'passcode: $passcode, code: ${profileUser.passcode}');
                      if (profileId != null &&
                          profileUser.passcode == passcode) {
                        final count =
                            await client.queueWindow.countByEmail(email);
                        final hasProject = count > 0;
                        if (hasProject == false) {
                          bool success = await _createDemo(profileUser);
                          if (success == false) {
                            Utils.overlayInfoMessage(
                                msg: S.of(context).noAction);
                            return;
                          }
                        }
                        await widget.prefs.setString(Prefs.windowEmail, email);

                        PackageInfo packageInfo =
                            await PackageInfo.fromPlatform();
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

                        profileUser.verified = true;
                        // profileUser.ipAddress = '';
                        final profileUserUpdate =
                            await client.profileUser.update(profileUser);

                        AppProfile appProfile = context.read<AppProfile>();
                        appProfile.profileUser = profileUserUpdate;

                        Utils.pushPage(
                            context,
                            WaysPage(
                                key: const ValueKey('ways-page'),
                                prefs: widget.prefs),
                            'WaysPage');
                      } else {
                        Utils.overlayInfoMessage(msg: S.of(context).invalid);
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    child: Text(S.of(context).forgotPasscode),
                    onPressed: () async {
                      final user = _profileUser;
                      if (user == null) return;
                      final profileUser =
                          await client.profileUser.forgetPasscode(user.email);
                      if (profileUser == null) {
                        Utils.overlayInfoMessage(msg: S.of(context).noAction);
                        return;
                      }
                      final result = await showOkAlertDialog(
                        context: context,
                        title: S.of(context).emailPasscode.toUpperCase(),
                        message: S.of(context).passcodeHasBeenSent,
                        onPopInvokedWithResult: (didPop, result) {
                          Logger.log(tag,
                              message: 'didPop: $didPop, result: $result');
                        },
                      );
                      Logger.log(tag, message: 'resulttt: $result');
                      if (result == OkCancelResult.ok) {
                        Logger.log(tag,
                            message:
                                'FORGOT: ${profileUser.email} : ${profileUser.passcode}');
                        _profileUser = profileUser;
                        setState(() {});
                      }
                    },
                  )
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showPasscodeMessage() {
    var text = RichText(
        text: TextSpan(
            style: Theme.of(context).textTheme.bodySmall,
            children: const <TextSpan>[
          TextSpan(
              text:
                  'Enter the Passcode that you have OR check your email for getting the passcode. Wait for couple of minutes. Do not share the Passcode with others.'),
        ]));
    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
        child: Container(child: text));
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
        padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
        child: Container(child: text));
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
}
