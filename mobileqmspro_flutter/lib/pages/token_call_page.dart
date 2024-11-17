// ignore_for_file: use_build_context_synchronously

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
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

class TokenCallPage extends StatefulWidget {
  final SharedPreferences prefs;
  final QueueWindow window;
  const TokenCallPage({super.key, required this.prefs, required this.window});

  @override
  State<TokenCallPage> createState() => _TokenCallPageState();
}

class _TokenCallPageState extends State<TokenCallPage> {
  static const String tag = "TokenCallPage";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _player = AudioPlayer();

  final TextEditingController _phoneController = TextEditingController();
  List<TokenIssued>? _tokenIssuedList;

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
  void dispose() {
    super.dispose();
    _player.dispose();
    _phoneController.dispose();
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
                  S.of(context).callToken.toUpperCase(), context),
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
    QueueWindow window = widget.window;
    final windowId = window.id;
    if (windowId == null) return const NoData();
    var text = RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.labelMedium,
        children: <TextSpan>[
          const TextSpan(text: 'Tokens for '),
          TextSpan(
              text: window.name,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const TextSpan(
              text:
                  'window. Select one of the waiting tokens for proceed to counter'),
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
          child: Column(children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                child: text),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    child: Text(S.of(context).markAllAsTimeout),
                    onPressed: () async {
                      await _player.seek(Duration.zero);
                      _player.play();
                      bool b = await _buildDialogTimeoutAllToken();
                      if (b) {
                        setState(() {});
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.refresh,
                        semanticLabel: 'Refresh'),
                    onPressed: () async {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: client.tokenIssued.getAllByWindowAndStatus(
                      windowId, StatusCode.onwait, null, null, false),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<TokenIssued>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Utils.loadingScreen();
                      case ConnectionState.active:
                      case ConnectionState.done:
                        List<TokenIssued>? tokenIssuedList =
                            (snapshot.hasData) ? snapshot.data : null;
                        _tokenIssuedList = tokenIssuedList;
                        if (tokenIssuedList == null) {
                          return Utils.loadingScreen();
                        } else if (tokenIssuedList.isEmpty == true) {
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
            )
          ]),
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
            bool b = await _buildDialogCallToken(tokenIssued);
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
    return Container(
        margin: EdgeInsets.symmetric(horizontal: (margin < 0) ? 0 : margin),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Text('${tokenIssued.tokenLetter}-${tokenIssued.tokenNumber}',
                style: Theme.of(context).textTheme.labelMedium),
            const Divider(),
            ListTile(
              leading:
                  const Icon(CupertinoIcons.play, semanticLabel: 'Call Token'),
              title: Text(S.of(context).callToken),
              onTap: () async {
                bool b = await _buildDialogCallToken(tokenIssued);
                Navigator.of(context).pop();
                if (b) {
                  setState(() {});
                }
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(CupertinoIcons.play,
                  semanticLabel: 'Timeout Token'),
              title: Text(S.of(context).timeoutToken),
              onTap: () async {
                bool b = await _buildDialogTimeoutToken(tokenIssued);
                Navigator.of(context).pop();
                if (b) {
                  setState(() {});
                }
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
                  await Share.share(text, subject: 'Token Info');
                } else {
                  Utils.overlayInfoMessage(msg: S.of(context).noAction);
                }
                Navigator.of(context).pop();
              },
            ),
            const Divider(),
            ListTile(
              leading:
                  const Icon(CupertinoIcons.phone_circle, semanticLabel: 'SMS'),
              title: Text(S.of(context).sendSms),
              onTap: () async {
                final result =
                    await showTextInputDialog(context: context, textFields: [
                  const DialogTextField(
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: false, signed: false),
                      hintText: '+601234567'),
                ]);
                Logger.log(tag, message: 'result: $result');
                if (result != null &&
                    result.isNotEmpty == true &&
                    Utils.isMobile &&
                    !kIsWeb) {
                  String phone = result.first;
                  var text = Utils.printTokenInfo(
                      widget.window.name,
                      tokenIssued.queueService?.name,
                      tokenIssued.tokenLetter,
                      tokenIssued.tokenNumber);
                  if (text != null) {
                    await Utils.sendMessage(text, [phone]);
                  } else {
                    Utils.overlayInfoMessage(msg: S.of(context).noAction);
                  }
                }
                Navigator.of(context).pop();
              },
            ),
            const Divider(),
          ]),
        ));
  }

  Future<bool> _buildDialogTimeoutToken(TokenIssued tokenIssued) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title: S.of(context).timeoutToken.toUpperCase(),
      message: '${S.of(context).doYouAccept}?',
      onPopInvokedWithResult: (didPop, result) {
        Logger.log(tag, message: 'didPop: $didPop, result: $result');
      },
    );
    Logger.log(tag, message: 'resulttt: $result');
    if (result == OkCancelResult.ok) {
      DateTime now = DateTime.now();
      tokenIssued.statusName = Status.timeout;
      tokenIssued.statusCode = StatusCode.timeout;
      tokenIssued.statusAcronym = StatusAcronym.timeout;
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

  Future<bool> _buildDialogCallToken(TokenIssued tokenIssued) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title:
          '${S.of(context).callToken.toUpperCase()} ${tokenIssued.tokenLetter}-${tokenIssued.tokenNumber}',
      message: '${S.of(context).doYouAccept}?',
      onPopInvokedWithResult: (didPop, result) {
        Logger.log(tag, message: 'didPop: $didPop, result: $result');
      },
    );
    Logger.log(tag, message: 'resulttt: $result');
    if (result == OkCancelResult.ok) {
      DateTime now = DateTime.now();
      tokenIssued.statusName = Status.onqueue;
      tokenIssued.statusCode = StatusCode.onqueue;
      tokenIssued.statusAcronym = StatusAcronym.onqueue;
      tokenIssued.isOnWait = false;
      tokenIssued.isOnQueue = true;
      tokenIssued.isCompleted = false;
      tokenIssued.isRecall = false;
      tokenIssued.assignedDate = now;
      tokenIssued.modifiedDate = now;
      await client.tokenIssued.update(tokenIssued);
      return true;
    }
    return false;
  }

  Future<bool> _buildDialogTimeoutAllToken() async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title: S.of(context).markAllAsTimeout.toUpperCase(),
      message: '${S.of(context).doYouAccept}?',
      onPopInvokedWithResult: (didPop, result) {
        Logger.log(tag, message: 'didPop: $didPop, result: $result');
      },
    );
    Logger.log(tag, message: 'resulttt: $result');
    if (result == OkCancelResult.ok) {
      DateTime now = DateTime.now();
      for (TokenIssued tokenIssued in _tokenIssuedList ?? []) {
        tokenIssued.statusName = Status.timeout;
        tokenIssued.statusCode = StatusCode.timeout;
        tokenIssued.statusAcronym = StatusAcronym.timeout;
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
