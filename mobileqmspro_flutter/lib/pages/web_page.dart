import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';
import 'package:mobileqmspro/commons/no_data.dart';
import 'package:mobileqmspro/generated/l10n.dart';
import 'package:mobileqmspro/logger.dart';
import 'package:mobileqmspro/serverpod_client.dart';
import 'package:mobileqmspro/utils/functions.dart';

class WebPage extends StatefulWidget {
  final int windowId;
  const WebPage({super.key, required this.windowId});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  static const String tag = "WebPage";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final double _boxWidth = 300;
  final ValueNotifier<List<TokenIssued>> _tokenIssuedList = ValueNotifier([]);

  TokenIssued? _latest;
  StreamSubscription<RunningTokens>? _sub;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.debug(tag, message: '_initialize---');
    final windowId = widget.windowId;
    await _listenToUpdates(windowId);
  }

  @override
  void dispose() async {
    _tokenIssuedList.dispose();
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
            )));
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

  Widget _buildEmptyMessage() {
    return NoData(
        message: 'No Data to be shown \nOR \nNetwork Connection Issues');
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

  Widget _buildSmallScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 4),
          Utils.buildDesc(60),
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

  Widget _tokenIssuedItem(TokenIssued tokenIssued) {
    bool animation = (tokenIssued.id == _latest?.id);
    return Padding(
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
    );
  }

  Widget _buildWindowName() {
    return FutureBuilder<QueueWindow?>(
        future: client.queueWindow.findById(widget.windowId),
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

  Future<void> _listenToUpdates(int windowId) async {
    var tokenUpdates = client.tokenIssued.echoTokensStream(windowId);
    _sub = tokenUpdates.listen((update) {
      _handleUpdate(update);
    })
      ..onError((error) async {
        Logger.log(tag, message: '_listenToUpdates: onError: $error');
        await Future.delayed(Duration(seconds: 3), () async {
          _sub?.cancel();
          _tokenIssuedList.value = [];
          final windowId = widget.windowId;
          await _listenToUpdates(windowId);
        });
      });
  }

  void _handleUpdate(update) {
    List<TokenIssued>? list = update.tokens;
    if (list == null) return;
    list.sort((a, b) => b.statusCode.compareTo(a.statusCode));
    final listCompleted = list.where((e) => e.isCompleted).toList();
    final listNoneCompleted =
        list.where((e) => e.isCompleted == false).toList();
    _tokenIssuedList.value = listNoneCompleted..addAll(listCompleted);
  }
}
