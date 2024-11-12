// ignore_for_file: use_build_context_synchronously

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';
import 'package:mobileqmspro_flutter/generated/l10n.dart';
import 'package:mobileqmspro_flutter/logger.dart';
import 'package:mobileqmspro_flutter/pages/ways_page.dart';
import 'package:mobileqmspro_flutter/utils/functions.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenNumPage extends StatefulWidget {
  final SharedPreferences prefs;
  final QueueWindow window;
  final QueueService service;
  final TokenIssued tokenIssued;
  const TokenNumPage(
      {super.key,
      required this.prefs,
      required this.window,
      required this.service,
      required this.tokenIssued});

  @override
  State<TokenNumPage> createState() => _TokenNumPageState();
}

class _TokenNumPageState extends State<TokenNumPage> {
  static const String tag = "TokenNumPage";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {}

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        child: SafeArea(
          child: Scaffold(
              key: _scaffoldKey,
              body: SafeArea(
                top: false,
                child: _buildContent(context),
              )),
        ));
  }

  Widget _buildContent(BuildContext context) {
    ButtonStyle buttonStyle = OutlinedButton.styleFrom(
      minimumSize: const Size(120, 60),
    );
    QueueWindow window = widget.window;
    QueueService service = widget.service;
    TokenIssued tokenIssued = widget.tokenIssued;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          ElevatedButton.icon(
              icon: const Icon(CupertinoIcons.phone_circle,
                  color: Colors.blue, semanticLabel: 'SMS'),
              label: Text(S.of(context).sendSms,
                  style: const TextStyle(color: Colors.blue)),
              style: buttonStyle,
              onPressed: () async {
                final result = await showTextInputDialog(
                    context: context,
                    style: AdaptiveStyle.iOS,
                    textFields: [
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
              }),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
                child: Text(window.name, style: const TextStyle(fontSize: 30))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                  '${tokenIssued.tokenLetter}-${tokenIssued.tokenNumber}',
                  style: const TextStyle(fontSize: 70)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
                child:
                    Text(service.name, style: const TextStyle(fontSize: 40))),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              OutlinedButton.icon(
                icon:
                    const Icon(CupertinoIcons.home, semanticLabel: 'Dashboard'),
                label: Text(S.of(context).dashboard),
                style: buttonStyle,
                onPressed: () async {
                  Utils.pushAndRemoveUntilPage(
                      context,
                      WaysPage(
                          key: const ValueKey('ways-page'),
                          prefs: widget.prefs),
                      'WaysPage');
                },
              ),
              OutlinedButton.icon(
                icon: const Icon(CupertinoIcons.plus_rectangle,
                    semanticLabel: 'Issue Token'),
                label: Text(S.of(context).issueToken),
                style: buttonStyle,
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const SizedBox(height: 30),
          OutlinedButton.icon(
            icon: const Icon(CupertinoIcons.share, semanticLabel: 'Share'),
            label: Text(S.of(context).shareTokenInfo),
            style: buttonStyle,
            onPressed: () async {
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
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
