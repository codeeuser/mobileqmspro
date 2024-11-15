import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';
import 'package:mobileqmspro/app_profile.dart';
import 'package:mobileqmspro/commons/header.dart';
import 'package:mobileqmspro/commons/no_data.dart';
import 'package:mobileqmspro/generated/l10n.dart';
import 'package:mobileqmspro/logger.dart';
import 'package:mobileqmspro/pages/more_page.dart';
import 'package:mobileqmspro/pages/token_call_page.dart';
import 'package:mobileqmspro/pages/token_issue_page.dart';
import 'package:mobileqmspro/pages/token_list_page.dart';
import 'package:mobileqmspro/pages/wizard_language.dart';
import 'package:mobileqmspro/serverpod_client.dart';
import 'package:mobileqmspro/utils/constants.dart';
import 'package:mobileqmspro/utils/functions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaysPage extends StatefulWidget {
  final SharedPreferences prefs;

  const WaysPage({super.key, required this.prefs});

  @override
  State<WaysPage> createState() => _WaysPageState();
}

class _WaysPageState extends State<WaysPage> {
  static const String tag = "WaysPage";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final ValueNotifier<int> _countMyOnWait = ValueNotifier(0);
  final ValueNotifier<int> _countMyNonOnWait = ValueNotifier(0);
  final ValueNotifier<dynamic> _screen = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    AppProfile appProfile = context.read<AppProfile>();
    final email = widget.prefs.getString(Prefs.windowEmail);
    if (email != null) {
      ProfileUser? profileUser = await client.profileUser.findByEmail(email);
      appProfile.profileUser = profileUser;
    }
  }

  @override
  void dispose() {
    _countMyOnWait.dispose();
    _countMyNonOnWait.dispose();
    _screen.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<dynamic>(
        valueListenable: _screen,
        builder: (BuildContext context, screen, _) {
          if (screen == null) {
            return _buildContent();
          } else {
            return screen;
          }
        });
  }

  Widget _buildContent() {
    return Consumer<AppProfile>(builder: (_, appProfile, child) {
      final email = appProfile.profileUser?.email;
      if (email == null) {
        return WizardLanguage(prefs: widget.prefs);
      }
      return FutureBuilder(
          future: client.queueWindow.getSelectedByEmail(email),
          builder:
              (BuildContext builder, AsyncSnapshot<QueueWindow?> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Utils.loadingScreen();
              case ConnectionState.active:
              case ConnectionState.done:
                final window = (snapshot.hasData) ? snapshot.data : null;
                final windowId = window?.id;
                if (window != null && windowId != null) {
                  _listenToUpdates(windowId);
                  return _buildPhoneContent(window);
                }
                return WizardLanguage(prefs: widget.prefs);
              default:
                return const NoData();
            }
          });
    });
  }

  Widget _buildPhoneContent(QueueWindow window) {
    double shortestSide = MediaQuery.of(context).size.shortestSide;
    double sizeButton =
        (shortestSide > 300) ? shortestSide * 0.25 : shortestSide * 0.15;
    return PopScope(
        canPop: true,
        child: Scaffold(
            key: _scaffoldKey,
            body: SafeArea(
              top: false,
              child: Column(
                children: <Widget>[
                  const Header(),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(window.name,
                                style: Theme.of(context).textTheme.titleMedium),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: SizedBox(
                                  width: shortestSide * 0.9,
                                  height: shortestSide,
                                  child: SizedBox(
                                      child: GridView.count(
                                    crossAxisCount: 2,
                                    physics:
                                        const NeverScrollableScrollPhysics(), // It disables scrolling functionality of GridView, which means now we have only SingleChildScrollView who provide the scrolling functionality.
                                    children: <Widget>[
                                      ValueListenableBuilder<int>(
                                          valueListenable: _countMyNonOnWait,
                                          builder: (BuildContext context,
                                              countMyNonOnWait, _) {
                                            return _buildButton(
                                                Icon(FontAwesomeIcons.list,
                                                    size: sizeButton,
                                                    color: Colors.redAccent,
                                                    semanticLabel: 'List'),
                                                S
                                                    .of(context)
                                                    .markComplete
                                                    .toUpperCase(),
                                                countMyNonOnWait, () async {
                                              _screen.value = TokenListPage(
                                                  prefs: widget.prefs,
                                                  window: window);
                                            });
                                          }),
                                      _buildButton(
                                          Icon(FontAwesomeIcons.squarePlus,
                                              size: sizeButton,
                                              color: Colors.redAccent,
                                              semanticLabel: 'Issue Token'),
                                          S
                                              .of(context)
                                              .issueToken
                                              .toUpperCase(),
                                          null, () async {
                                        _screen.value = TokenIssuePage(
                                            key: const ValueKey(
                                                'token-issued-page'),
                                            prefs: widget.prefs,
                                            window: window);
                                      }),
                                      ValueListenableBuilder<int>(
                                          valueListenable: _countMyOnWait,
                                          builder: (BuildContext context,
                                              countMyOnWait, _) {
                                            return _buildButton(
                                                Icon(
                                                    FontAwesomeIcons
                                                        .forwardStep,
                                                    size: sizeButton,
                                                    color: Colors.redAccent,
                                                    semanticLabel:
                                                        'Call Token'),
                                                S
                                                    .of(context)
                                                    .callToken
                                                    .toUpperCase(),
                                                countMyOnWait, () async {
                                              _screen.value = TokenCallPage(
                                                  prefs: widget.prefs,
                                                  window: window);
                                            });
                                          }),
                                      _buildButton(
                                          Icon(FontAwesomeIcons.ellipsis,
                                              size: sizeButton,
                                              color: Colors.redAccent,
                                              semanticLabel: 'More'),
                                          S.of(context).more.toUpperCase(),
                                          null, () async {
                                        _screen.value = MorePage(
                                          prefs: widget.prefs,
                                          window: window,
                                        );
                                      }),
                                    ],
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(CupertinoIcons.question_circle,
                              color: Colors.blue, semanticLabel: 'Help'),
                          iconSize: 30,
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
                                    child: _buildHelpMenu(context),
                                  );
                                });
                          },
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Icon(CupertinoIcons.link,
                                  semanticLabel: 'Link'),
                              const SizedBox(width: 10),
                              Text('Powered by Wheref.com',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                          onPressed: () async {
                            Utils.launchURLString(myBaseUrl);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  Widget _buildButton(
      Icon icon, String label, int? count, VoidCallback onPressed) {
    return SizedBox(
        child: Center(
      child: TextButton(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[icon, Text(label)],
            ),
            (count != null)
                ? Positioned(
                    // draw a red marble
                    top: 10.0,
                    right: 0.0,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                      child: Text(' $count ',
                          style: Theme.of(context).textTheme.labelMedium?.apply(
                              color: Colors.black, fontWeightDelta: 10)),
                    ))
                : const SizedBox(height: 0)
          ],
        ),
        onPressed: () {
          Logger.log(tag, message: 'label: $label');
          onPressed();
        },
      ),
    ));
  }

  Widget _buildHelpMenu(BuildContext context) {
    var stepTitle = RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.headlineSmall,
        children: const <TextSpan>[
          TextSpan(
              text: 'Token Life Cycle',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );

    var step01 = RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.labelMedium,
        children: const <TextSpan>[
          TextSpan(
              text: 'STEP 1: ', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'Issue Token'),
        ],
      ),
    );

    var step02 = RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.labelMedium,
        children: const <TextSpan>[
          TextSpan(
              text: 'STEP 2: ', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'Call Token'),
        ],
      ),
    );

    var step03 = RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.labelMedium,
        children: const <TextSpan>[
          TextSpan(
              text: 'STEP 3: ', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'Mark Token as Completed'),
        ],
      ),
    );

    double margin = (MediaQuery.of(context).size.width / 2) - 200;
    return Container(
        margin: EdgeInsets.symmetric(horizontal: (margin < 0) ? 0 : margin),
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                stepTitle,
                const SizedBox(height: 5),
                step01,
                step02,
                step03,
                const SizedBox(height: 20),
              ],
            ),
          ),
        ])));
  }

  Future<void> _listenToUpdates(int windowId) async {
    Logger.log(tag, message: '_listenToUpdates, windowId: $windowId');
    final statusUpdates =
        client.tokenIssued.echoStatusStream(StatusCode.onwait, windowId);
    try {
      await for (final update in statusUpdates) {
        _countMyOnWait.value = update.countWait;
        _countMyNonOnWait.value = update.countIsQueue;
      }
    } catch (e) {
      Logger.log(tag, message: '_listenToUpdatesError: $e');
    }
  }
}
