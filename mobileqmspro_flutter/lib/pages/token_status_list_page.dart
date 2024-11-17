// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';
import 'package:mobileqmspro/commons/custom_appbar.dart';
import 'package:mobileqmspro/commons/no_data.dart';
import 'package:mobileqmspro/generated/l10n.dart';
import 'package:mobileqmspro/logger.dart';
import 'package:mobileqmspro/pages/more_page.dart';
import 'package:mobileqmspro/serverpod_client.dart';
import 'package:mobileqmspro/utils/constants.dart';
import 'package:mobileqmspro/utils/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStatusListPage extends StatefulWidget {
  final SharedPreferences prefs;
  final int statusCode;
  final QueueWindow window;

  const TokenStatusListPage(
      {super.key,
      required this.prefs,
      required this.statusCode,
      required this.window});

  @override
  State<TokenStatusListPage> createState() => _TokenStatusListPageState();
}

class _TokenStatusListPageState extends State<TokenStatusListPage> {
  static const String tag = "TokenStatusListPage";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final _player = AudioPlayer();
  final int _maxLimit = 100;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _player.setAsset('assets/audio/knock.mp3');
    await _player.stop();
  }

  @override
  void dispose() async {
    await _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: CustomAppBar(
                title: Utils.getAppBarTitle(S.of(context).tokenList, context),
                goBackButton: Utils.goBackButton(() => Utils.pushPage(
                    context,
                    MorePage(prefs: widget.prefs, window: widget.window),
                    'MorePage')),
                label: S.of(context).title),
            body: _buildContent(context)));
  }

  Widget _buildContent(BuildContext context) {
    final window = widget.window;
    final windowId = window.id;
    if (windowId == null) return const NoData();
    var text = RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.labelMedium,
        children: <TextSpan>[
          const TextSpan(text: 'Token list of '),
          TextSpan(
              text: '${window.name} ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'branch. Max Item Limit is $_maxLimit.'),
        ],
      ),
    );
    return Align(
      alignment: Alignment.topCenter,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: (constraints.maxWidth > WidgetProp.width)
              ? WidgetProp.width
              : constraints.maxWidth,
          child: Column(
            children: [
              Padding(padding: const EdgeInsets.all(10), child: text),
              Expanded(
                child: FutureBuilder(
                    future: client.tokenIssued.getAllByWindowAndStatus(
                        windowId, widget.statusCode, _maxLimit, 0, true),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<TokenIssued>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Utils.loadingScreen();
                        case ConnectionState.active:
                        case ConnectionState.done:
                          List<TokenIssued>? tokenIssuedList =
                              (snapshot.hasData) ? snapshot.data : null;
                          if (tokenIssuedList == null) {
                            return Utils.loadingScreen();
                          } else if (tokenIssuedList.isEmpty) {
                            return const NoData();
                          }

                          return ListView.builder(
                              itemCount: tokenIssuedList.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return _tokenIssuedItem(
                                    tokenIssuedList.elementAt(index), index);
                              });
                        default:
                          return const NoData();
                      }
                    }),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _tokenIssuedItem(TokenIssued tokenIssued, int index) {
    return Card(
      child: ListTile(
          leading: ClipOval(
            child: Container(
              color: Utils.getStatusColor(tokenIssued.statusName),
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(10.0),
              child: Center(
                  child: Text(tokenIssued.statusAcronym,
                      style: const TextStyle(
                          fontSize: 25.0, color: Colors.white))),
            ),
          ),
          title: Text('${tokenIssued.tokenLetter}-${tokenIssued.tokenNumber}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${tokenIssued.queueService?.name}'),
              Text(Utils.printAgo(
                  tokenIssued.createdDate.millisecondsSinceEpoch, 'en')),
            ],
          ),
          isThreeLine: true,
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
                      child: _buildSettingMenu(context, tokenIssued),
                    );
                  });
            },
          )),
    );
  }

  Widget _buildSettingMenu(BuildContext context, TokenIssued tokenIssued) {
    double margin = (MediaQuery.of(context).size.width / 2) - ScreenProp.width;
    double height =
        (MediaQuery.of(context).size.height > ScreenProp.heightSettingMenu)
            ? ScreenProp.heightSettingMenu
            : MediaQuery.of(context).size.height;
    return Container(
        height: height,
        margin: EdgeInsets.symmetric(horizontal: (margin < 0) ? 0 : margin),
        child: ListView(children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Center(
                child: Text(
                    '${tokenIssued.statusName.toUpperCase()}: ${tokenIssued.tokenLetter}-${tokenIssued.tokenNumber}',
                    style: Theme.of(context).textTheme.labelMedium)),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(CupertinoIcons.play, semanticLabel: 'Recall'),
            title: Text(
                '${S.of(context).recallToken} ${(tokenIssued.isOnWait == false) ? "" : "(Disabled)"}'),
            onTap: () async {
              if (tokenIssued.isOnWait == true) return;
              final tokenIssuedId = tokenIssued.id;
              if (tokenIssuedId == null) return;
              Logger.log(tag, message: 'open recallToken');
              await _player.seek(Duration.zero);
              _player.play();
              TokenIssued? latestTokenIssued =
                  await client.tokenIssued.findById(tokenIssuedId);
              if (latestTokenIssued != null) {
                bool b = await _buildDialogRecallToken(tokenIssued);
                if (b) {
                  setState(() {});
                }
              } else {
                Utils.overlayInfoMessage(msg: S.of(context).noAction);
              }
              Navigator.of(context).pop();
            },
          ),
          const Divider(),
        ]));
  }

  Future<bool> _buildDialogRecallToken(TokenIssued tokenIssued) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title:
          'Recall Token ${tokenIssued.tokenLetter.toUpperCase()}-${tokenIssued.tokenNumber}',
      message: '${S.of(context).doYouAccept}?',
      onPopInvokedWithResult: (didPop, result) {
        Logger.log(tag, message: 'didPop: $didPop, result: $result');
      },
    );
    Logger.log(tag, message: 'resulttt: $result');
    if (result == OkCancelResult.ok) {
      DateTime now = DateTime.now();
      tokenIssued.statusName = Status.recall;
      tokenIssued.statusCode = StatusCode.recall;
      tokenIssued.statusAcronym = StatusAcronym.recall;
      tokenIssued.isOnWait = false;
      tokenIssued.isOnQueue = true;
      tokenIssued.isCompleted = false;
      tokenIssued.isRecall = true;
      tokenIssued.assignedDate = now;
      tokenIssued.modifiedDate = now;
      await client.tokenIssued.update(tokenIssued);
      return true;
    }
    return false;
  }
}
