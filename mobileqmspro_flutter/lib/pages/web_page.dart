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

  final ValueNotifier<List<TokenIssued>> _tokenIssuedList = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final windowId = widget.windowId;
    await _listenToUpdates(windowId);
  }

  @override
  void dispose() {
    _tokenIssuedList.dispose();
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 4),
                    Utils.buildDesc(60),
                    FutureBuilder<QueueWindow?>(
                        future: client.queueWindow.findById(widget.windowId),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Utils.loadingScreen();
                            case ConnectionState.active:
                            case ConnectionState.done:
                              final window =
                                  (snapshot.hasData) ? snapshot.data : null;
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      window?.name ??
                                          '${S.of(context).loading}...',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                ),
                              );
                            default:
                              return const NoData();
                          }
                        }),
                    ValueListenableBuilder<List<TokenIssued>>(
                        valueListenable: _tokenIssuedList,
                        builder: (BuildContext context, tokenIssuedList, _) {
                          if (tokenIssuedList.isEmpty) {
                            return const NoData();
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
              ),
            )));
  }

  Widget _tokenIssuedItem(TokenIssued tokenIssued) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 300,
        height: 160,
        color: Utils.getStatusColor(tokenIssued.statusName),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
    );
  }

  Future<void> _listenToUpdates(int windowId) async {
    Logger.log(tag, message: '_listenToUpdates');
    final tokenUpdates = client.tokenIssued.echoTokensStream(windowId);
    await for (final update in tokenUpdates) {
      List<TokenIssued> list = update.tokens;
      list.sort((a, b) => b.statusCode.compareTo(a.statusCode));
      final listCompleted = list.where((e) => e.isCompleted).toList();
      final listNoneCompleted =
          list.where((e) => e.isCompleted == false).toList();
      _tokenIssuedList.value = listNoneCompleted..addAll(listCompleted);
    }
  }
}
