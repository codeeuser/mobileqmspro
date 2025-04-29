// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mobileqmspro/commons/custom_appbar.dart';
import 'package:mobileqmspro/commons/no_data.dart';
import 'package:mobileqmspro/generated/l10n.dart';
import 'package:mobileqmspro/logger.dart';
import 'package:mobileqmspro/pages/token_num_page.dart';
import 'package:mobileqmspro/pages/ways_page.dart';
import 'package:mobileqmspro/serverpod_client.dart';
import 'package:mobileqmspro/utils/functions.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenIssuePage extends StatefulWidget {
  final SharedPreferences prefs;
  final QueueWindow window;
  const TokenIssuePage({super.key, required this.prefs, required this.window});

  @override
  State<TokenIssuePage> createState() => _TokenIssuePageState();
}

class _TokenIssuePageState extends State<TokenIssuePage> {
  static const String tag = "TokenIssuePage";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _player = AudioPlayer();

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
              label: S.of(context).title,
              title: Utils.getAppBarTitle(
                  S.of(context).issueToken.toUpperCase(), context),
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
              child: _buildContent(),
            )));
  }

  Widget _buildContent() {
    final windowId = widget.window.id;
    if (windowId == null) return const NoData();
    return Column(
      children: [
        const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
                'Select one of the services below for issue a queue number.')),
        Expanded(
          child: FutureBuilder(
              future: client.queueService
                  .getAllByWindowIdAndEnable(windowId, false),
              builder: (context, AsyncSnapshot<List<QueueService>> snapshot) {
                if (snapshot.hasData) {
                  List<QueueService>? serviceList = snapshot.data;
                  if (serviceList == null || serviceList.isEmpty) {
                    return const NoData();
                  }
                  return ListView.builder(
                      itemCount: serviceList.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        QueueService? service = serviceList.elementAt(index);
                        return _serviceItem(service, index);
                      });
                }
                return Utils.loadingScreen();
              }),
        )
      ],
    );
  }

  Widget _serviceItem(QueueService service, int index) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 32.0),
            backgroundColor: Colors.grey[200],
          ),
          child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(service.name,
                  style: const TextStyle(fontSize: 70, color: Colors.black))),
          onPressed: () async {
            await _player.seek(Duration.zero);
            _player.play();
            TokenIssued? tokenIssued =
                await Utils.handleSubmit(context, widget.window, service);
            if (tokenIssued != null) {
              Logger.log(tag,
                  message:
                      'tokenIssued: ${tokenIssued.tokenLetter}-${tokenIssued.tokenNumber}');
              Utils.pushAndRemoveUntilPage(
                  context,
                  TokenNumPage(
                      key: const ValueKey('token-num-page'),
                      prefs: widget.prefs,
                      window: widget.window,
                      service: service,
                      tokenIssued: tokenIssued),
                  'TokenNumberPage');
            } else {
              Utils.overlayInfoMessage(msg: S.of(context).noAction);
            }
          },
        ),
      ),
    );
  }
}
