// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mobileqmspro/commons/custom_appbar.dart';
import 'package:mobileqmspro/commons/no_data.dart';
import 'package:mobileqmspro/generated/l10n.dart';
import 'package:mobileqmspro/logger.dart';
import 'package:mobileqmspro/pages/call_board_setting_page.dart';
import 'package:mobileqmspro/pages/ways_page.dart';
import 'package:mobileqmspro/serverpod_client.dart';
import 'package:mobileqmspro/utils/functions.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallBoardPage extends StatefulWidget {
  final QueueWindow window;
  final SharedPreferences prefs;
  const CallBoardPage({super.key, required this.window, required this.prefs});

  @override
  State<CallBoardPage> createState() => _CallBoardPageState();
}

class _CallBoardPageState extends State<CallBoardPage> {
  static const String tag = "CallBoardPage";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _flutterTts = FlutterTts();
  final double _boxWidth = 300;
  final ValueNotifier<List<TokenIssued>> _tokenIssuedList = ValueNotifier([]);
  final List<int> _calledIds = [];

  TokenIssued? _latest;
  StreamSubscription<RunningTokens>? _sub;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.debug(tag, message: '_initialize---');
    final windowId = widget.window.id;
    await _listenToUpdates(windowId);
  }

  @override
  void dispose() async {
    _tokenIssuedList.dispose();
    await _flutterTts.stop();
    await _sub?.cancel();
    await client.closeStreamingConnection();
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
                S.of(context).callBoard.toUpperCase(), context),
            goBackButton: Utils.goBackButton(() async {
              await _flutterTts.stop();
              await _sub?.cancel();
              await client.closeStreamingConnection();
              Utils.pushAndRemoveUntilPage(
                  context,
                  WaysPage(
                    key: const ValueKey('ways-page'),
                    prefs: widget.prefs,
                    window: widget.window,
                  ),
                  'WaysPage');
            }),
          ),
          body: SafeArea(
            top: false,
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth > 1000) {
                return Center(
                    child: SizedBox(width: 1000, child: _buildBigScreen()));
              } else {
                return _buildSmallScreen();
              }
            }),
          ),
          floatingActionButton: FloatingActionButton(
            child:
                const Icon(CupertinoIcons.settings, semanticLabel: 'Settings'),
            onPressed: () async {
              Utils.pushPage(
                  context,
                  CallBoardSettingPage(
                    prefs: widget.prefs,
                    window: widget.window,
                    flutterTts: _flutterTts,
                  ),
                  'ServiceNewPage');
            },
          ),
        ));
  }

  Widget _buildBigScreen() {
    return Column(
      children: [
        const SizedBox(height: 4),
        Utils.buildDesc(60),
        _buildWindowName(),
        Expanded(
          child: ValueListenableBuilder<List<TokenIssued>>(
              valueListenable: _tokenIssuedList,
              builder: (context, list, _) {
                if (list.isEmpty) {
                  return _buildEmptyMessage();
                }
                final List<TokenIssued> listClone = List.from(list);
                listClone
                    .sort((a, b) => b.modifiedDate!.compareTo(a.modifiedDate!));

                final latest = listClone.firstOrNull;
                _latest = latest;
                Logger.log(tag,
                    message:
                        'firstID, ${latest?.tokenLetter}-${latest?.tokenNumber}');

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWaitColumn(list),
                    _buildQueueColumn(list),
                    _buildCompletedColumn(list),
                  ],
                );
              }),
        ),
      ],
    );
  }

  Widget _buildSmallScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 8),
          Utils.buildDesc(20),
          _buildWindowName(),
          ValueListenableBuilder<List<TokenIssued>>(
              valueListenable: _tokenIssuedList,
              builder: (BuildContext context, tokenIssuedList, _) {
                if (tokenIssuedList.isEmpty) {
                  return _buildEmptyMessage();
                }
                return Wrap(
                  children: [
                    for (var token in tokenIssuedList) ...[
                      _tokenIssuedItem(token),
                    ]
                  ],
                );
              }),
        ],
      ),
    );
  }

  Widget _buildWaitColumn(List<TokenIssued> list) {
    final tokens = list.where((e) => e.isOnWait).toList();
    return _buildVerticalColumn(tokens, S.of(context).pleaseWait);
  }

  Widget _buildQueueColumn(List<TokenIssued> list) {
    final tokens = list.where((e) => e.isOnQueue).toList();
    return _buildVerticalColumn(tokens, S.of(context).myQueue);
  }

  Widget _buildCompletedColumn(List<TokenIssued> list) {
    final tokens = list.where((e) => e.isCompleted).toList();
    tokens.sort((a, b) => a.statusCode.compareTo(b.statusCode));
    return _buildVerticalColumn(tokens, S.of(context).completedTokens);
  }

  Widget _buildVerticalColumn(List<TokenIssued> tokens, String title) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: _boxWidth,
            height: 40,
            color: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.apply(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          for (TokenIssued token in tokens) ...[
            _tokenIssuedItem(token),
          ]
        ],
      ),
    );
  }

  Widget _tokenIssuedItem(TokenIssued tokenIssued) {
    bool animation = (tokenIssued.id == _latest?.id);
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Pulse(
          key: ValueKey('token-${tokenIssued.id}'),
          duration: (animation) ? const Duration(seconds: 1) : Duration.zero,
          child: Container(
            width: _boxWidth,
            height: 160,
            color: Utils.getStatusColor(tokenIssued.statusName),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(color: Colors.white, spreadRadius: 1),
                      ],
                    ),
                    child: Text(
                      tokenIssued.statusName.toUpperCase(),
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${tokenIssued.tokenLetter}-${tokenIssued.tokenNumber}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  if (tokenIssued.isOnQueue) ...[
                    const SizedBox(height: 16),
                    Text(
                      S.of(context).proceedToCounter,
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () async {
        await _speak(tokenIssued);
      },
    );
  }

  Widget _buildEmptyMessage() {
    return NoData(
        message: 'No Data to be shown \nOR \nNetwork Connection Issues');
  }

  Widget _buildWindowName() {
    final windowId = widget.window.id;
    if (windowId == null) return const SizedBox();
    return FutureBuilder<QueueWindow?>(
        future: client.queueWindow.findById(windowId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final window = snapshot.data;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(window?.name ?? '${S.of(context).loading}...',
                    style: Theme.of(context).textTheme.titleLarge),
              ),
            );
          }
          return Utils.loadingScreen();
        });
  }

  Future<void> _speak(TokenIssued? tokenIssued) async {
    Logger.log(tag, message: '_speak: tokenIssued: $tokenIssued');
    if (tokenIssued == null) return;
    List numberList =
        Utils.toSeparatedString(tokenIssued.tokenNumber.toString());
    List letterList = Utils.toSeparatedString(tokenIssued.tokenLetter);
    String text = '';
    for (String letter in letterList) {
      text = '$text $letter'.trim();
    }

    String numText = '';
    for (String num in numberList) {
      numText = '$numText $num';
    }
    text = '"$text" ${numText.trim()}'.trim();
    Logger.log(tag, message: 'speak: $text');
    final result = _flutterTts.speak(text);
    Logger.log(tag, message: 'result: $result');
  }

  Future<void> _listenToUpdates(int? windowId) async {
    if (windowId == null) return;
    var tokenUpdates = client.tokenIssued.echoTokensStream(windowId);
    _sub = tokenUpdates.listen((update) async {
      await _handleUpdate(update);
    })
      ..onError((error) async {
        Logger.log(tag, message: '_listenToUpdates: onError: $error');
        await Future.delayed(Duration(seconds: 3), () async {
          _sub?.cancel();
          _tokenIssuedList.value = [];
          await _listenToUpdates(windowId);
        });
      });
  }

  Future<void> _handleUpdate(update) async {
    List<TokenIssued>? list = update.tokens;
    if (list == null || list.isEmpty == true) return;
    list.sort((a, b) => b.statusCode.compareTo(a.statusCode));
    final listQueue = list.where((e) => e.isOnQueue).toList();
    listQueue.sort((a, b) {
      final date1 = a.modifiedDate;
      final date2 = b.modifiedDate;
      if (date1 == null && date2 == null) return 0;
      if (date1 == null) return 1;
      if (date2 == null) return -1;
      return date2.compareTo(date1);
    });
    final queueToken = (listQueue.isNotEmpty) ? listQueue.first : null;
    final listCompleted = list.where((e) => e.isCompleted).toList();
    final listNoneCompleted =
        list.where((e) => e.isCompleted == false).toList();
    _tokenIssuedList.value = listNoneCompleted..addAll(listCompleted);
    // initial callIDs
    if (_calledIds.isEmpty) {
      for (var token in listCompleted) {
        final tokenId = token.id;
        if (tokenId == null) continue;
        _calledIds.add(tokenId);
      }
    }
    // check speak
    final queueId = queueToken?.id;
    if (queueId != null &&
        (_calledIds.contains(queueId) == false ||
            queueToken?.isRecall == true)) {
      await _speak(queueToken);
      _calledIds.add(queueId);
    }
  }
}
