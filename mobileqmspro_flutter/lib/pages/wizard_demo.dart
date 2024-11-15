// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';
import 'package:mobileqmspro/generated/l10n.dart';
import 'package:mobileqmspro/logger.dart';
import 'package:mobileqmspro/pages/passcode_page.dart';
import 'package:mobileqmspro/serverpod_client.dart';
import 'package:mobileqmspro/utils/constants.dart';
import 'package:mobileqmspro/utils/functions.dart';
import 'package:mobileqmspro/utils/validation_function.dart';
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
                hintText: 'Email Passcode here.',
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
                    await client.profileUser.login(email);
                Logger.log(tag, message: 'email: $email');

                Utils.pushPage(
                    context,
                    PasscodePage(
                      key: const ValueKey('ways-page'),
                      prefs: widget.prefs,
                      profileUser: profileUser,
                    ),
                    'PasscodePage');
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
}
