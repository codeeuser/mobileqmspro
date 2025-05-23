// ignore_for_file: use_build_context_synchronously

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mobileqmspro/pages/printing_page.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';
import 'package:mobileqmspro/commons/custom_appbar.dart';
import 'package:mobileqmspro/commons/no_data.dart';
import 'package:mobileqmspro/generated/l10n.dart';
import 'package:mobileqmspro/logger.dart';
import 'package:mobileqmspro/pages/ways_page.dart';
import 'package:mobileqmspro/serverpod_client.dart';
import 'package:mobileqmspro/utils/constants.dart';
import 'package:mobileqmspro/utils/functions.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenListPage extends StatefulWidget {
  final SharedPreferences prefs;
  final QueueWindow window;
  const TokenListPage({super.key, required this.prefs, required this.window});

  @override
  State<TokenListPage> createState() => _TokenListPageState();
}

class _TokenListPageState extends State<TokenListPage> {
  static const String tag = "TokenListPage";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _player = AudioPlayer();

  List<TokenIssued>? _tokenIssuedList;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _player.setUrl('asset:assets/audio/knock.mp3');
  }

  @override
  void dispose() async {
    super.dispose();
    await _player.dispose();
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
                  S.of(context).markComplete.toUpperCase(), context),
              goBackButton: Utils.goBackButton(() => Utils.pushPage(
                  context,
                  WaysPage(
                    key: const ValueKey('ways-page'),
                    prefs: widget.prefs,
                    window: widget.window,
                  ),
                  'WaysPage')),
            ),
            body: SafeArea(
              top: false,
              child: _buildContent(context),
            )));
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
          const TextSpan(text: 'window. You can Complete the selected token.'),
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
            children: <Widget>[
              Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                  child: text),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      child: Text(S.of(context).markAllAsCompleted),
                      onPressed: () async {
                        await _player.seek(Duration.zero);
                        _player.play();
                        bool b = await _buildDialogCompleteAllToken(windowId);
                        if (b) {
                          setState(() {});
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(CupertinoIcons.refresh,
                          semanticLabel: 'Refresh'),
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: client.tokenIssued
                        .getAllByWindowAndOnQueue(windowId, null, null, true),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<TokenIssued>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          List<TokenIssued>? tokenIssuedList = snapshot.data;
                          if (tokenIssuedList == null ||
                              tokenIssuedList.isEmpty) {
                            return const NoData();
                          }
                          _tokenIssuedList = tokenIssuedList;
                          return ListView.builder(
                              itemCount: tokenIssuedList.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return _tokenIssuedItem(
                                    tokenIssuedList.elementAt(index), index);
                              });
                        }
                      }
                      return Utils.loadingScreen();
                    }),
              )
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
          onTap: () async {
            await _player.seek(Duration.zero);
            _player.play();
            bool b = await _buildDialogCompleteToken(tokenIssued);
            if (b) {
              setState(() {});
            }
          },
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
            : MediaQuery.of(context).size.height - 20;
    return Container(
        height: height,
        margin: EdgeInsets.symmetric(horizontal: (margin < 0) ? 0 : margin),
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Text('${tokenIssued.tokenLetter}-${tokenIssued.tokenNumber}',
              style: Theme.of(context).textTheme.labelMedium),
          const Divider(),
          ListTile(
            leading: const Icon(CupertinoIcons.check_mark,
                semanticLabel: 'Completed'),
            title: Text(S.of(context).markAsCompleted),
            onTap: () async {
              bool b = await _buildDialogCompleteToken(tokenIssued);
              Navigator.of(context).pop();
              if (b) {
                setState(() {});
              }
            },
          ),
          const Divider(),
          ListTile(
            leading:
                const Icon(CupertinoIcons.printer, semanticLabel: 'Printing'),
            title: Text(S.of(context).printToken),
            onTap: () async {
              var text = Utils.printTokenInfo(
                  widget.window.name,
                  tokenIssued.queueService?.name,
                  tokenIssued.tokenLetter,
                  tokenIssued.tokenNumber);
              if (text == null) return;
              Utils.pushPage(context, PrintingPage(text: text), 'Printing');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(CupertinoIcons.share, semanticLabel: 'Share'),
            title: Text(S.of(context).shareTokenInfo),
            onTap: () async {
              var text = Utils.printTokenInfo(
                  widget.window.name,
                  tokenIssued.queueService?.name,
                  tokenIssued.tokenLetter,
                  tokenIssued.tokenNumber);
              if (text != null) {
                await SharePlus.instance
                    .share(ShareParams(text: text, subject: 'Token Info'));
              } else {
                Utils.overlayInfoMessage(msg: S.of(context).noAction);
              }
              Navigator.of(context).pop();
            },
          ),
          const Divider(),
        ])));
  }

  Future<bool> _buildDialogCompleteToken(TokenIssued tokenIssued) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title:
          '${S.of(context).markComplete.toUpperCase()} ${tokenIssued.tokenLetter}-${tokenIssued.tokenNumber}',
      message: '${S.of(context).doYouAccept}?',
      onPopInvokedWithResult: (didPop, result) {
        Logger.log(tag, message: 'didPop: $didPop, result: $result');
      },
    );
    Logger.log(tag, message: 'resulttt: $result');
    if (result == OkCancelResult.ok) {
      DateTime now = DateTime.now();
      tokenIssued.statusName = Status.completed;
      tokenIssued.statusCode = StatusCode.completed;
      tokenIssued.statusAcronym = StatusAcronym.completed;
      tokenIssued.isOnWait = false;
      tokenIssued.isOnQueue = false;
      tokenIssued.isCompleted = true;
      tokenIssued.isRecall = false;
      tokenIssued.assignedDate = now;
      tokenIssued.modifiedDate = now;
      await client.tokenIssued.update(tokenIssued);
      return true;
    }
    return false;
  }

  Future<bool> _buildDialogCompleteAllToken(int windowId) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title: S.of(context).markAllAsCompleted.toUpperCase(),
      message: '${S.of(context).doYouAccept}?',
      onPopInvokedWithResult: (didPop, result) {
        Logger.log(tag, message: 'didPop: $didPop, result: $result');
      },
    );
    Logger.log(tag, message: 'resulttt: $result');
    if (result == OkCancelResult.ok) {
      DateTime now = DateTime.now();
      for (TokenIssued tokenIssued in _tokenIssuedList ?? []) {
        tokenIssued.statusName = Status.completed;
        tokenIssued.statusCode = StatusCode.completed;
        tokenIssued.statusAcronym = StatusAcronym.completed;
        tokenIssued.isOnWait = false;
        tokenIssued.isOnQueue = false;
        tokenIssued.isCompleted = true;
        tokenIssued.isRecall = false;
        tokenIssued.assignedDate = now;
        tokenIssued.modifiedDate = now;
      }
      await client.tokenIssued.updateAll(_tokenIssuedList ?? []);
      return true;
    }
    return false;
  }
}
