// ignore_for_file: use_build_context_synchronously

import 'package:adaptive_dialog/adaptive_dialog.dart';
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

class WizardDemo extends StatefulWidget {
  final SharedPreferences prefs;

  const WizardDemo({super.key, required this.prefs});

  @override
  State<WizardDemo> createState() => _WizardDemoState();
}

class _WizardDemoState extends State<WizardDemo> {
  static const String tag = "WizardDemo";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {}

  @override
  void dispose() {
    _emailController.dispose();
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
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: text,
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                icon: const Icon(Icons.email,
                    color: Colors.grey, semanticLabel: 'Email'),
                hintText: 'What is the email?',
                labelText: S.of(context).email,
              ),
              controller: _emailController,
              maxLength: 100,
              validator: (value) {
                return validateEmail(value);
              },
            ),
            OutlinedButton(
              child: Text(S.of(context).next),
              onPressed: () async {
                if (_formKey.currentState?.validate() == false) {
                  Utils.overlayInfoMessage(msg: S.of(context).noAction);
                  return;
                }
                String email = _emailController.text;
                ProfileUser? profileUser =
                    await client.profileUser.findByEmail(email);
                final count = await client.queueWindow.countByEmail(email);
                final hasProject = count > 0;
                final result = await showOkCancelAlertDialog(
                  context: context,
                  title: (hasProject)
                      ? S.of(context).proceed.toUpperCase()
                      : S.of(context).createDemoProject.toUpperCase(),
                  message: '${S.of(context).doYouAccept}?',
                  onPopInvokedWithResult: (didPop, result) {
                    Logger.log(tag,
                        message: 'didPop: $didPop, result: $result');
                  },
                );
                Logger.log(tag, message: 'resulttt: $result');
                if (result == OkCancelResult.ok) {
                  if (profileUser == null) {
                    profileUser = ProfileUser(
                        email: email,
                        passcode: Utils.randomDigit(6),
                        membership: Membership.basic,
                        createdDate: DateTime.now());
                    profileUser = await client.profileUser.create(profileUser);
                  }
                  if (hasProject == false) {
                    bool success = await _createDemo(profileUser);
                    if (success == false) {
                      Utils.overlayInfoMessage(msg: S.of(context).noAction);
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
                }
              },
            ),
            const SizedBox(height: 50),
            const Text('--- OR ---'),
            const SizedBox(height: 50),
            OutlinedButton(
              child: const Text('Exit'),
              onPressed: () async {
                await Utils.exitApp(context);
              },
            ),
          ],
        ),
      ),
    );
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
