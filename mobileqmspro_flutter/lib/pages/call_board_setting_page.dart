// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mobileqmspro/commons/custom_appbar.dart';
import 'package:mobileqmspro/generated/l10n.dart';
import 'package:mobileqmspro/logger.dart';
import 'package:mobileqmspro/pages/call_board_page.dart';
import 'package:mobileqmspro/serverpod_client.dart';
import 'package:mobileqmspro/utils/constants.dart';
import 'package:mobileqmspro/utils/functions.dart';
import 'package:mobileqmspro/utils/validation_function.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallBoardSettingPage extends StatefulWidget {
  final QueueWindow window;
  final SharedPreferences prefs;
  final FlutterTts flutterTts;
  const CallBoardSettingPage(
      {super.key,
      required this.window,
      required this.prefs,
      required this.flutterTts});

  @override
  State<CallBoardSettingPage> createState() => _CallBoardSettingPageState();
}

class _CallBoardSettingPageState extends State<CallBoardSettingPage> {
  static const String tag = "CallBoardSettingPage";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final ValueNotifier<double> _volume = ValueNotifier(0.5);
  final ValueNotifier<double> _pitch = ValueNotifier(1.0);
  final ValueNotifier<double> _rate = ValueNotifier(0.5);
  final TextEditingController _windowIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final windowId = widget.window.id;
    Logger.log(tag, message: '_initialize: windowId: $windowId');
    _windowIdController.text = '${windowId ?? ''}';
    _volume.value = widget.prefs.getDouble(Prefs.volume) ?? 1.0;
    _rate.value = widget.prefs.getDouble(Prefs.rate) ?? 0.5;
    _pitch.value = widget.prefs.getDouble(Prefs.pitch) ?? 0.5;

    await widget.prefs.setDouble(Prefs.volume, _volume.value);
    await widget.prefs.setDouble(Prefs.rate, _rate.value);
    await widget.prefs.setDouble(Prefs.pitch, _pitch.value);
  }

  @override
  void dispose() {
    _volume.dispose();
    _pitch.dispose();
    _rate.dispose();
    _windowIdController.dispose();
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
                  S.of(context).setting.toUpperCase(), context),
              actionButton: TextButton(
                child: Text(S.of(context).save),
                onPressed: () async {
                  final windowId =
                      int.tryParse(_windowIdController.text.trim());
                  if (windowId == null) return;
                  Logger.log(tag, message: 'SAVE: windowId: $windowId');
                  final window = await client.queueWindow.findById(windowId);
                  if (window == null) return;

                  await widget.prefs.setDouble(Prefs.volume, _volume.value);
                  await widget.prefs.setDouble(Prefs.rate, _rate.value);
                  await widget.prefs.setDouble(Prefs.pitch, _pitch.value);
                  await widget.flutterTts.setVolume(_volume.value);
                  await widget.flutterTts.setSpeechRate(_rate.value);
                  await widget.flutterTts.setPitch(_pitch.value);
                  Utils.pushAndRemoveUntilPage(
                    context,
                    CallBoardPage(window: window, prefs: widget.prefs),
                    'CallBoardPage',
                  );
                },
              ),
              goBackButton: Utils.goBackButton(() => Utils.pushPage(
                  context,
                  CallBoardPage(
                    key: const ValueKey('call-board-page'),
                    prefs: widget.prefs,
                    window: widget.window,
                  ),
                  'CallBoardPage')),
            ),
            body: SafeArea(
              top: false,
              child: Align(
                alignment: Alignment.topCenter,
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return SizedBox(
                      width: (constraints.maxWidth > WidgetProp.width)
                          ? WidgetProp.width
                          : constraints.maxWidth,
                      child: _buildContent());
                }),
              ),
            )));
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildTextInput(),
          _buildSlider(),
        ],
      ),
    );
  }

  Widget _buildTextInput() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        icon: const Icon(Icons.widgets,
            color: Colors.grey, semanticLabel: 'WindowId'),
        hintText: 'What is the Window ID?',
        labelText: S.of(context).windowId,
        suffixIcon: IconButton(
          icon: Icon(CupertinoIcons.xmark, size: 12),
          onPressed: () {
            _windowIdController.clear();
          },
        ),
      ),
      controller: _windowIdController,
      maxLength: 4,
      validator: (value) {
        return validateNum(value, 1, 9999);
      },
    );
  }

  Widget _buildSlider() {
    TextStyle? captionStyle = Theme.of(context).textTheme.labelSmall;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).volumn, style: captionStyle),
              const SizedBox(height: 8),
              _buildVolume(),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).rate, style: captionStyle),
              const SizedBox(height: 8),
              _buildRate(),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).pitch, style: captionStyle),
              const SizedBox(height: 8),
              _buildPitch(),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildVolume() {
    return ValueListenableBuilder(
        valueListenable: _volume,
        builder: (context, double v, _) {
          return Slider(
            value: v,
            onChanged: (newVolume) async {
              newVolume = double.parse(newVolume.toStringAsFixed(2));
              _volume.value = newVolume;
            },
            min: 0.0,
            max: 1.0,
            divisions: 10,
          );
        });
  }

  Widget _buildPitch() {
    return ValueListenableBuilder(
        valueListenable: _pitch,
        builder: (context, double p, _) {
          return Slider(
            value: p,
            onChanged: (newPitch) async {
              newPitch = double.parse(newPitch.toStringAsFixed(2));
              _pitch.value = newPitch;
            },
            min: 0.5,
            max: 2.0,
            divisions: 10,
          );
        });
  }

  Widget _buildRate() {
    return ValueListenableBuilder(
        valueListenable: _rate,
        builder: (context, double r, _) {
          return Slider(
            value: r,
            onChanged: (newRate) async {
              newRate = double.parse(newRate.toStringAsFixed(2));
              _rate.value = newRate;
            },
            min: 0.0,
            max: 1.0,
            divisions: 10,
          );
        });
  }
}
