// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileqmspro/utils/constants.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';
import 'package:mobileqmspro/app_profile.dart';
import 'package:mobileqmspro/commons/custom_appbar.dart';
import 'package:mobileqmspro/commons/no_data.dart';
import 'package:mobileqmspro/generated/l10n.dart';
import 'package:mobileqmspro/logger.dart';
import 'package:mobileqmspro/pages/more_page.dart';
import 'package:mobileqmspro/pages/window_new_page.dart';
import 'package:mobileqmspro/serverpod_client.dart';
import 'package:mobileqmspro/utils/functions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WindowListPage extends StatefulWidget {
  final SharedPreferences prefs;
  const WindowListPage({super.key, required this.prefs});

  @override
  State<WindowListPage> createState() => _WindowListPageState();
}

class _WindowListPageState extends State<WindowListPage> {
  static const String tag = 'WindowListPage';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  bool? _isVisible;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
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
                S.of(context).setupWindow.toUpperCase(), context),
            goBackButton: Utils.goBackButton(() async {
              AppProfile appProfile = context.read<AppProfile>();
              final profileUser = appProfile.profileUser;
              final profileUserId = profileUser?.id;
              final email = profileUser?.email;
              if (profileUserId == null || email == null) return;
              QueueWindow? window =
                  await client.queueWindow.getSelectedByEmail(email);
              if (window == null) return;
              Utils.pushPage(context,
                  MorePage(prefs: widget.prefs, window: window), 'MorePage');
            }),
          ),
          body: _buildContent(context),
          floatingActionButton: Visibility(
            visible: _isVisible ?? true,
            child: Visibility(
              child: FloatingActionButton(
                child: const Icon(CupertinoIcons.plus,
                    semanticLabel: 'Add Window'),
                onPressed: () async {
                  Utils.pushPage(context, WindowNewPage(prefs: widget.prefs),
                      'WindowNewPage');
                },
              ),
            ),
          ),
        ));
  }

  Widget _buildContent(BuildContext context) {
    AppProfile appProfile = context.read<AppProfile>();
    final profileUser = appProfile.profileUser;
    final email = profileUser?.email;
    if (email == null) return const NoData();
    return Align(
        alignment: Alignment.topCenter,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            width: (constraints.maxWidth > WidgetProp.width)
                ? WidgetProp.width
                : constraints.maxWidth,
            child: Column(
              children: <Widget>[
                const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                        'To setup the stall, you should create Windows and Services. Press [+] on your right bottom icon for create a Window.')),
                Expanded(
                  child: FutureBuilder(
                      future: client.queueWindow
                          .getAllByEmail(email, null, null, false),
                      builder:
                          (context, AsyncSnapshot<List<QueueWindow>> snapshot) {
                        if (snapshot.hasData) {
                          List<QueueWindow>? windowList = snapshot.data;
                          if (windowList == null || windowList.isEmpty) {
                            return const NoData();
                          }

                          return ListView.builder(
                              itemCount: windowList.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                QueueWindow? w = windowList.elementAt(index);
                                return _windowItem(w, index);
                              });
                        }
                        return Utils.loadingScreen();
                      }),
                ),
              ],
            ),
          );
        }));
  }

  Widget _windowItem(QueueWindow window, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(window.name),
            leading: (window.selected == true)
                ? (const Icon(CupertinoIcons.square_fill_on_circle_fill,
                    color: Colors.green, semanticLabel: 'On'))
                : const Icon(CupertinoIcons.square_on_circle,
                    color: Colors.grey, semanticLabel: 'Off'),
            trailing: IconButton(
              icon: const Icon(CupertinoIcons.ellipsis_vertical,
                  semanticLabel: 'More'),
              onPressed: () async {
                await showModalBottomSheet(
                    context: context,
                    builder: (context2) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                        child: _buildSettingMenu(context, window),
                      );
                    });
              },
            ),
            onTap: () {
              Utils.pushPage(
                  context,
                  WindowNewPage(prefs: widget.prefs, windowId: window.id),
                  'WindowNewPage');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingMenu(BuildContext context, QueueWindow window) {
    double margin = (MediaQuery.of(context).size.width / 2) - ScreenProp.width;
    double height =
        (MediaQuery.of(context).size.height > ScreenProp.heightSettingMenu)
            ? ScreenProp.heightSettingMenu
            : MediaQuery.of(context).size.height - 20;
    return SingleChildScrollView(
      child: Container(
          height: height,
          margin: EdgeInsets.symmetric(horizontal: (margin < 0) ? 0 : margin),
          child: Column(children: <Widget>[
            Text(window.name, style: Theme.of(context).textTheme.labelMedium),
            ListTile(
              leading: const Icon(CupertinoIcons.tag_circle,
                  semanticLabel: 'Enable Window'),
              title: Text(S.of(context).enableWindow),
              onTap: () async {
                bool b = await _buildDialogEnableWindow(window);
                Navigator.of(context).pop();
                if (b) {
                  setState(() {});
                }
              },
            ),
            ListTile(
                leading: const Icon(CupertinoIcons.pencil,
                    semanticLabel: 'Edit Window'),
                title: Text(S.of(context).editWindow),
                onTap: () async {
                  Navigator.of(context).pop();
                  Utils.pushPage(
                      context,
                      WindowNewPage(prefs: widget.prefs, windowId: window.id),
                      'WindowNewPage');
                }),
          ])),
    );
  }

  Future<bool> _buildDialogEnableWindow(QueueWindow window) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title: '${S.of(context).enableWindow.toUpperCase()}\n(${window.name})',
      message: '${S.of(context).doYouAccept}?',
      onPopInvokedWithResult: (didPop, result) {
        Logger.log(tag, message: 'didPop: $didPop, result: $result');
      },
    );
    Logger.log(tag, message: 'resulttt: $result');
    if (result == OkCancelResult.ok) {
      AppProfile appProfile = context.read<AppProfile>();
      final profileUser = appProfile.profileUser;
      final profileUserId = profileUser?.id;
      final email = profileUser?.email;
      if (profileUserId == null || email == null) return false;
      DateTime now = DateTime.now();
      window.selected = true;
      window.modifiedDate = now;
      await client.queueWindow.updateSelected(window, email);
      return true;
    }
    return false;
  }
}
