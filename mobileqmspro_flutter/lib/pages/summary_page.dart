import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';
import 'package:mobileqmspro_flutter/pages/token_status_list_page.dart';
import 'package:mobileqmspro_flutter/commons/dash_separator.dart';
import 'package:mobileqmspro_flutter/logger.dart';
import 'package:mobileqmspro_flutter/serverpod_client.dart';
import 'package:mobileqmspro_flutter/utils/constants.dart';
import 'package:mobileqmspro_flutter/utils/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SummaryPage extends StatefulWidget {
  final SharedPreferences prefs;
  final QueueWindow window;
  const SummaryPage({super.key, required this.prefs, required this.window});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  static const String tag = "SummaryPage";

  final ValueNotifier<int> _countOnWait = ValueNotifier(0);
  final ValueNotifier<int> _countOnQueue = ValueNotifier(0);
  final ValueNotifier<int> _countRecall = ValueNotifier(0);
  final ValueNotifier<int> _countCompleted = ValueNotifier(0);
  final ValueNotifier<int> _countTimeout = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final windowId = widget.window.id;
    if (windowId == null) return;
    List<TokenIssued>? tokenIssuedList =
        await client.tokenIssued.getAllByWindowId(windowId, null, null, true);

    _countOnWait.value =
        tokenIssuedList.where((e) => e.statusCode == StatusCode.onwait).length;
    _countOnQueue.value =
        tokenIssuedList.where((e) => e.statusCode == StatusCode.onqueue).length;
    _countRecall.value =
        tokenIssuedList.where((e) => e.statusCode == StatusCode.recall).length;
    _countCompleted.value = tokenIssuedList
        .where((e) => e.statusCode == StatusCode.completed)
        .length;
    _countTimeout.value =
        tokenIssuedList.where((e) => e.statusCode == StatusCode.timeout).length;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final window = widget.window;
    return _buildCountBox(window);
  }

  Widget _buildCountBox(QueueWindow branch) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: SizedBox(
              height: 120,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ValueListenableBuilder<int>(
                        valueListenable: _countOnWait,
                        builder: (BuildContext context, countOnWait, _) {
                          return _buildInfoBox(
                              Status.onwait.toUpperCase(),
                              countOnWait,
                              StatusColor.onwait,
                              StatusCode.onwait,
                              'Open List for WAIT Status',
                              true);
                        }),
                    const SizedBox(width: 10),
                    ValueListenableBuilder<int>(
                        valueListenable: _countOnQueue,
                        builder: (BuildContext context, countOnQueue, _) {
                          return _buildInfoBox(
                              Status.onqueue.toUpperCase(),
                              countOnQueue,
                              StatusColor.onqueue,
                              StatusCode.onqueue,
                              'Open List for QUEUE Status',
                              true);
                        }),
                    const SizedBox(width: 10),
                    ValueListenableBuilder<int>(
                        valueListenable: _countCompleted,
                        builder: (BuildContext context, countCompleted, _) {
                          return _buildInfoBox(
                              Status.completed.toUpperCase(),
                              countCompleted,
                              StatusColor.completed,
                              StatusCode.completed,
                              'Open List for completed Status',
                              true);
                        }),
                    const SizedBox(width: 10),
                    ValueListenableBuilder<int>(
                        valueListenable: _countRecall,
                        builder: (BuildContext context, countRecall, _) {
                          return _buildInfoBox(
                              Status.recall.toUpperCase(),
                              countRecall,
                              StatusColor.recall,
                              StatusCode.recall,
                              'Open List for recall Status',
                              true);
                        }),
                    const SizedBox(width: 10),
                    ValueListenableBuilder<int>(
                        valueListenable: _countTimeout,
                        builder: (BuildContext context, countTimeout, _) {
                          return _buildInfoBox(
                              Status.timeout.toUpperCase(),
                              countTimeout,
                              StatusColor.timeout,
                              StatusCode.timeout,
                              'Open List for timeout Status',
                              true);
                        }),
                  ],
                ),
              ),
            )),
          ],
        ),
        const DashSeparator(color: Colors.blueGrey, height: 1),
      ],
    );
  }

  Widget _buildInfoBox(
      text, count, color, int statusCode, String message, bool isToken) {
    TextStyle? textStyle =
        Theme.of(context).textTheme.labelMedium?.apply(color: Colors.white);
    TextStyle? textStyle02 = Theme.of(context)
        .textTheme
        .headlineSmall
        ?.apply(color: Colors.white, fontWeightDelta: 50);
    return Tooltip(
      message: message,
      child: InkWell(
        child: Container(
          height: 95.0,
          width: 120.0,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: Colors.white)),
                    child: Text(text, style: textStyle)),
                const SizedBox(height: 5),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text('$count', style: textStyle02),
                ),
              ],
            ),
          ),
        ),
        onTap: () async {
          Logger.log(tag, message: 'pushPage TokenStatusListPage');
          Utils.pushPage(
              context,
              TokenStatusListPage(
                  statusCode: statusCode,
                  prefs: widget.prefs,
                  window: widget.window),
              'TokenStatusListPage');
        },
      ),
    );
  }
}
