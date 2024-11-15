// ignore_for_file: use_build_context_synchronously

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';
import 'package:mobileqmspro_flutter/app_profile.dart';
import 'package:mobileqmspro_flutter/app_theme.dart';
import 'package:mobileqmspro_flutter/commons/custom_appbar.dart';
import 'package:mobileqmspro_flutter/commons/custom_divider.dart';
import 'package:mobileqmspro_flutter/generated/l10n.dart';
import 'package:mobileqmspro_flutter/logger.dart';
import 'package:mobileqmspro_flutter/pages/service_list_page.dart';
import 'package:mobileqmspro_flutter/pages/summary_page.dart';
import 'package:mobileqmspro_flutter/pages/ways_page.dart';
import 'package:mobileqmspro_flutter/pages/window_list_page.dart';
import 'package:mobileqmspro_flutter/serverpod_client.dart';
import 'package:mobileqmspro_flutter/utils/constants.dart';
import 'package:mobileqmspro_flutter/utils/functions.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MorePage extends StatefulWidget {
  final SharedPreferences prefs;
  final QueueWindow window;
  const MorePage({super.key, required this.prefs, required this.window});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  static const String tag = "MorePage";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  String? _packageName;
  String? _version;
  String? _buildNumber;
  bool? _appearanceDark;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) async {
      AppTheme appTheme = context.read<AppTheme>();
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;

      setState(() {
        _packageName = packageName;
        _version = version;
        _buildNumber = buildNumber;
        _appearanceDark = appTheme.appearanceDark;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: CustomAppBar(
              label: S.of(context).title,
              title: Utils.getAppBarTitle(
                  S.of(context).moreOptions.toUpperCase(), context),
              goBackButton: Utils.goBackButton(() => Utils.pushPage(
                  context,
                  WaysPage(
                      key: const ValueKey('ways-page'), prefs: widget.prefs),
                  'WaysPage')),
            ),
            body: SafeArea(
              top: false,
              child: _buildContent(),
            )));
  }

  Widget _buildContent() {
    return ListView(
      children: [
        const SizedBox(height: 5.0),
        SummaryPage(
            key: UniqueKey(), prefs: widget.prefs, window: widget.window),
        const SizedBox(height: 5.0),
        CustomDivider(
            height: 50, title: S.of(context).appearance.toUpperCase()),
        ListTile(
          leading: const Icon(CupertinoIcons.moon, semanticLabel: 'Theme Mode'),
          title: Text(S.of(context).appearance),
          subtitle: const Text('The place to enable Dark Mode'),
          trailing: CupertinoSwitch(
            value: _appearanceDark ?? false,
            activeColor: Colors.black,
            onChanged: (bool value) async {
              AppTheme appTheme = context.read<AppTheme>();
              appTheme.appearanceDark = value;
              setState(() {
                _appearanceDark = value;
              });
            },
          ),
        ),
        CustomDivider(
            height: 50, title: S.of(context).setupTheStall.toUpperCase()),
        ListTile(
          leading: const Icon(CupertinoIcons.home, semanticLabel: 'Setup'),
          title: Text(S.of(context).setupTheStall),
          subtitle: const Text(
              'The place to initialize your stall. Windows and Services should be created for fully function.'),
          trailing:
              const Icon(CupertinoIcons.chevron_right, semanticLabel: 'Next'),
          onTap: () async {
            Utils.pushPage(
                context,
                WindowListPage(
                  prefs: widget.prefs,
                ),
                'WindowListPage');
          },
        ),
        const Divider(color: Colors.grey),
        ListTile(
          leading: const Icon(CupertinoIcons.home, semanticLabel: 'Setup'),
          title: Text(S.of(context).serviceList),
          subtitle:
              const Text('Services should be created for fully function.'),
          trailing:
              const Icon(CupertinoIcons.chevron_right, semanticLabel: 'Next'),
          onTap: () async {
            Utils.pushPage(
                context,
                ServiceListPage(
                  prefs: widget.prefs,
                  window: widget.window,
                ),
                'ServiceListPage');
          },
        ),
        CustomDivider(
            height: 50, title: S.of(context).resetTokenNumber.toUpperCase()),
        ListTile(
          leading: const Icon(CupertinoIcons.refresh, semanticLabel: 'Reset'),
          title: Text(S.of(context).resetTokenNumber),
          subtitle: const Text(
              'The place to reset the token number. The reset token cannot be found on this APP.'),
          trailing:
              const Icon(CupertinoIcons.chevron_right, semanticLabel: 'Next'),
          onTap: () async {
            await _buildDialogResetToken(widget.window);
            setState(() {});
          },
        ),
        CustomDivider(height: 50, title: S.of(context).appInfo.toUpperCase()),
        ListTile(
          leading:
              const Icon(CupertinoIcons.bookmark, semanticLabel: 'Read This'),
          title: Text(S.of(context).termsOfUse),
          subtitle: const Text('Please read this'),
          trailing:
              const Icon(CupertinoIcons.chevron_right, semanticLabel: 'Next'),
          onTap: () {
            Utils.launchURLString(termUrl);
          },
        ),
        const Divider(color: Colors.grey),
        ListTile(
          leading:
              const Icon(CupertinoIcons.bookmark, semanticLabel: 'Read This'),
          title: Text(S.of(context).privacy),
          subtitle: const Text('Please read this'),
          trailing:
              const Icon(CupertinoIcons.chevron_right, semanticLabel: 'Next'),
          onTap: () {
            Utils.launchURLString(privacyUrl);
          },
        ),
        const Divider(color: Colors.grey),
        ListTile(
          leading:
              const Icon(CupertinoIcons.wind, semanticLabel: 'Current Window'),
          title: Text(S.of(context).currentWindowName),
          subtitle: Text(widget.window.name),
        ),
        const Divider(color: Colors.grey),
        ListTile(
          leading:
              const Icon(CupertinoIcons.info, semanticLabel: 'Package Name'),
          title: Text(S.of(context).packageName),
          subtitle: Text('$_packageName'),
        ),
        const Divider(color: Colors.grey),
        ListTile(
          leading:
              const Icon(CupertinoIcons.info, semanticLabel: 'Build Number'),
          title: Text(S.of(context).buildNumber),
          subtitle: Text('$_buildNumber'),
        ),
        const Divider(color: Colors.grey),
        ListTile(
          leading: const Icon(CupertinoIcons.info, semanticLabel: 'Version'),
          title: Text(S.of(context).version),
          subtitle: Text('$_version'),
        ),
        const Divider(color: Colors.grey),
        ListTile(
          leading: const Icon(CupertinoIcons.person, semanticLabel: 'Version'),
          title: Text(S.of(context).login),
          subtitle:
              Text(context.read<AppProfile>().profileUser?.email ?? 'Empty'),
        ),
        const Divider(color: Colors.grey),
        ListTile(
          leading:
              const Icon(CupertinoIcons.info, semanticLabel: 'Runing Token'),
          title: Text(S.of(context).runningTokens),
          subtitle: const Text('Show Running Tokens on Web Page'),
          trailing:
              const Icon(CupertinoIcons.chevron_right, semanticLabel: 'Next'),
          onTap: () {
            Utils.launchURLString('$myBaseUrl${widget.window.id}');
          },
        ),
        const Divider(color: Colors.grey),
        ListTile(
          tileColor: Colors.red.shade500,
          leading: const Icon(
            FontAwesomeIcons.rightFromBracket,
            semanticLabel: 'Version',
            color: Colors.white,
          ),
          title: Text(
            S.of(context).logout,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: const Text(
            'The Place for signing out',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () async {
            final result = await showOkCancelAlertDialog(
              context: context,
              title: S.of(context).logout.toUpperCase(),
              message: '${S.of(context).doYouAccept}?',
              onPopInvokedWithResult: (didPop, result) {
                Logger.log(tag, message: 'didPop: $didPop, result: $result');
              },
            );
            Logger.log(tag, message: 'resulttt: $result');
            if (result == OkCancelResult.ok) {
              AppProfile appProfile = context.read<AppProfile>();
              appProfile.profileUser = null;
              await widget.prefs.clear();
              Utils.pushPage(
                  context,
                  WaysPage(
                      key: const ValueKey('ways-page'), prefs: widget.prefs),
                  'WaysPage');
            }
          },
        ),
        const Divider(color: Colors.grey),
      ],
    );
  }

  Future<void> _buildDialogResetToken(QueueWindow window) async {
    final windowId = window.id;
    if (windowId == null) return;
    final result = await showOkCancelAlertDialog(
      context: context,
      title: S.of(context).resetTokenNumber.toUpperCase(),
      message: '${S.of(context).doYouAccept}?',
      onPopInvokedWithResult: (didPop, result) {
        Logger.log(tag, message: 'didPop: $didPop, result: $result');
      },
    );
    Logger.log(tag, message: 'resulttt: $result');
    if (result == OkCancelResult.ok) {
      await client.tokenIssued.resetAll(windowId);
    }
  }
}
