// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';
import 'package:mobileqmspro_flutter/generated/l10n.dart';
import 'package:mobileqmspro_flutter/logger.dart';
import 'package:mobileqmspro_flutter/pages/ways_page.dart';
import 'package:mobileqmspro_flutter/serverpod_client.dart';
import 'package:mobileqmspro_flutter/utils/constants.dart';
import 'package:mobileqmspro_flutter/utils/functions.dart';
import 'package:mobileqmspro_flutter/utils/validation_function.dart';
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

  @override
  void initState() {
    Logger.log(tag, message: 'passcode: ${widget.profileUser.passcode}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: Text(S.of(context).passcode),
          backgroundColor: const Color.fromRGBO(35, 197, 221, 1.0),
        ),
        body: _buildContent());
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
                  TextButton(
                    child: Text(S.of(context).login.toUpperCase()),
                    onPressed: () async {
                      if (_formPasscodeKey.currentState?.validate() == false) {
                        Utils.overlayInfoMessage(msg: S.of(context).noAction);
                        return;
                      }
                      final passcode = _passcodeController.text;
                      final profileUser = widget.profileUser;
                      final email = profileUser.email;
                      Logger.log(tag,
                          message:
                              'passcode: $passcode, code: ${profileUser.passcode}');
                      if (profileUser.passcode == passcode) {
                        final count =
                            await client.queueWindow.countByEmail(email);
                        final hasProject = count > 0;
                        if (hasProject == false) {
                          bool success = await _createDemo(profileUser);
                          if (success == false) {
                            Utils.overlayInfoMessage(
                                msg: S.of(context).noAction);
                          }
                        }
                        await widget.prefs
                            .setString(Prefs.windowEmail, profileUser.email);
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
                  'An Email has been sent to you about the Passcode. Wait for couple of minutes. Do not share the Passcode with others.'),
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
