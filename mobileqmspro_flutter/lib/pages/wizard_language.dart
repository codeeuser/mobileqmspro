// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileqmspro_flutter/commons/custom_appbar.dart';
import 'package:mobileqmspro_flutter/generated/l10n.dart';
import 'package:mobileqmspro_flutter/logger.dart';
import 'package:mobileqmspro_flutter/pages/wizard_demo.dart';
import 'package:mobileqmspro_flutter/utils/constants.dart';
import 'package:mobileqmspro_flutter/utils/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WizardLanguage extends StatefulWidget {
  final SharedPreferences prefs;

  const WizardLanguage({super.key, required this.prefs});

  @override
  State<WizardLanguage> createState() => _WizardLanguageState();
}

class _WizardLanguageState extends State<WizardLanguage> {
  static const String tag = 'WizardLanguage';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return PopScope(
          canPop: true,
          child: Scaffold(
              key: _scaffoldKey,
              appBar: CustomAppBar(
                label: S.of(context).title,
                title: Utils.getAppBarTitle(
                    S.of(context).setupLanguage.toUpperCase(), context),
                goBackButton: null,
              ),
              body: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: (constraints.maxWidth > WidgetProp.width)
                        ? WidgetProp.width
                        : constraints.maxWidth,
                    child: _buildContent(context),
                  ))));
    });
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text('English'),
              trailing: const Icon(CupertinoIcons.chevron_right,
                  semanticLabel: 'Next'),
              onTap: () async {
                Logger.log(tag, message: 'en');
                await widget.prefs.setString(Prefs.language, 'en');
                await Utils.assignLanguage(widget.prefs);
                _handlePush(context);
              },
            ),
            ListTile(
              title: const Text('中文'),
              trailing: const Icon(CupertinoIcons.chevron_right,
                  semanticLabel: 'Next'),
              onTap: () async {
                Logger.log(tag, message: 'zh_CN');
                await widget.prefs.setString(Prefs.language, 'zh_CN');
                await Utils.assignLanguage(widget.prefs);
                _handlePush(context);
              },
            ),
            ListTile(
              title: const Text('Español'),
              trailing: const Icon(CupertinoIcons.chevron_right,
                  semanticLabel: 'Next'),
              onTap: () async {
                Logger.log(tag, message: 'es');
                await widget.prefs.setString(Prefs.language, 'es');
                await Utils.assignLanguage(widget.prefs);
                _handlePush(context);
              },
            ),
            ListTile(
              title: const Text('Português'),
              trailing: const Icon(CupertinoIcons.chevron_right,
                  semanticLabel: 'Next'),
              onTap: () async {
                Logger.log(tag, message: 'pt');
                await widget.prefs.setString(Prefs.language, 'pt');
                await Utils.assignLanguage(widget.prefs);
                _handlePush(context);
              },
            ),
            ListTile(
              title: const Text('Français'),
              trailing: const Icon(CupertinoIcons.chevron_right,
                  semanticLabel: 'Next'),
              onTap: () async {
                Logger.log(tag, message: 'fr');
                await widget.prefs.setString(Prefs.language, 'fr');
                await Utils.assignLanguage(widget.prefs);
                _handlePush(context);
              },
            ),
            ListTile(
              title: const Text('Deutsche'),
              trailing: const Icon(CupertinoIcons.chevron_right,
                  semanticLabel: 'Next'),
              onTap: () async {
                Logger.log(tag, message: 'de');
                await widget.prefs.setString(Prefs.language, 'de');
                await Utils.assignLanguage(widget.prefs);
                _handlePush(context);
              },
            ),
            ListTile(
              title: const Text('Russian'),
              trailing: const Icon(CupertinoIcons.chevron_right,
                  semanticLabel: 'Next'),
              onTap: () async {
                Logger.log(tag, message: 'ru');
                await widget.prefs.setString(Prefs.language, 'ru');
                await Utils.assignLanguage(widget.prefs);
                _handlePush(context);
              },
            ),
            ListTile(
              title: const Text('Korea'),
              trailing: const Icon(CupertinoIcons.chevron_right,
                  semanticLabel: 'Next'),
              onTap: () async {
                Logger.log(tag, message: 'ko');
                await widget.prefs.setString(Prefs.language, 'ko');
                await Utils.assignLanguage(widget.prefs);
                _handlePush(context);
              },
            ),
            ListTile(
              title: const Text('Arabic'),
              trailing: const Icon(CupertinoIcons.chevron_right,
                  semanticLabel: 'Next'),
              onTap: () async {
                Logger.log(tag, message: 'ar');
                await widget.prefs.setString(Prefs.language, 'ar');
                await Utils.assignLanguage(widget.prefs);
                _handlePush(context);
              },
            ),
            ListTile(
              title: const Text('Malay'),
              trailing: const Icon(CupertinoIcons.chevron_right,
                  semanticLabel: 'Next'),
              onTap: () async {
                Logger.log(tag, message: 'ms');
                await widget.prefs.setString(Prefs.language, 'ms');
                await Utils.assignLanguage(widget.prefs);
                _handlePush(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handlePush(BuildContext context) {
    Utils.pushPage(context, WizardDemo(prefs: widget.prefs), 'WizardDemo');
  }
}
