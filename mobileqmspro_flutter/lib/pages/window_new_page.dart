// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mobileqmspro/utils/constants.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';
import 'package:mobileqmspro/app_profile.dart';
import 'package:mobileqmspro/generated/l10n.dart';
import 'package:mobileqmspro/logger.dart';
import 'package:mobileqmspro/pages/window_list_page.dart';
import 'package:mobileqmspro/serverpod_client.dart';
import 'package:mobileqmspro/styles.dart';
import 'package:mobileqmspro/utils/functions.dart';
import 'package:mobileqmspro/utils/validation_function.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WindowNewPage extends StatefulWidget {
  final SharedPreferences prefs;
  final int? windowId;

  const WindowNewPage({super.key, required this.prefs, this.windowId});

  @override
  State<WindowNewPage> createState() => _WindowNewPageState();
}

class _WindowNewPageState extends State<WindowNewPage> {
  static const String tag = 'WindowNewPage';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  QueueWindow? _window;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final windowId = widget.windowId;
    if (windowId == null) return;
    QueueWindow? window = await client.queueWindow.findById(windowId);
    if (window != null) {
      setState(() {
        _window = window;
        _nameController.text = window.name;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              title: Text(S.of(context).windowForm),
              backgroundColor: const Color.fromRGBO(35, 197, 221, 1.0),
              actions: [
                TextButton(
                    onPressed: () async {
                      Logger.log(tag, message: 'SAVE/UPDATE');
                      _formKey.currentState?.save();
                      if (_formKey.currentState?.validate() == false) {
                        return;
                      }
                      AppProfile appProfile = context.read<AppProfile>();
                      final profileUser = appProfile.profileUser;
                      final profileUserId = profileUser?.id;
                      final email = profileUser?.email;
                      Membership? membership = profileUser?.membership;
                      if (profileUserId == null || email == null) {
                        return;
                      }
                      int countWindow =
                          await client.queueWindow.countByEmail(email);
                      Logger.log(tag, message: 'countWindow: $countWindow');
                      // Check Membership - SAVE Window
                      if (_window == null) {
                        if (membership == Membership.basic &&
                            (countWindow >= 1)) {
                          Utils.overlayInfoMessage(
                              msg: S.of(context).membershipLimitation);
                          return;
                        }
                        if (membership == Membership.advance &&
                            countWindow >= 3) {
                          Utils.overlayInfoMessage(
                              msg: S.of(context).membershipLimitation);
                          return;
                        }
                      }
                      // Check Membership END

                      String name = _nameController.text.trim();
                      int count = await client.queueWindow.countByEmail(email);
                      int orderNum = count + 1;
                      DateTime now = DateTime.now();
                      QueueWindow? window = _window;
                      if (window == null) {
                        QueueWindow windowNew = QueueWindow(
                            name: name,
                            selected: false,
                            orderNum: orderNum,
                            createdDate: now,
                            modifiedDate: now,
                            profileUserId: profileUserId);
                        _window = await client.queueWindow.create(windowNew);
                      } else {
                        window.name = name;
                        window.modifiedDate = now;
                        await client.queueWindow.update(window);
                      }
                      Utils.pushPage(
                          context,
                          WindowListPage(prefs: widget.prefs),
                          'WindowListPage');
                    },
                    child: (_window == null)
                        ? Text(S.of(context).save.toUpperCase(),
                            style: Styles.actionBtn)
                        : Text(S.of(context).update.toUpperCase(),
                            style: Styles.actionBtn))
              ],
            ),
            body: _buildContent(context)));
  }

  Widget _buildContent(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: (constraints.maxWidth > WidgetProp.width)
              ? WidgetProp.width
              : constraints.maxWidth,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            'Window name may be your business name. For example, ABC Clinic, Wheref Restaurant, DEF Service Center, etc',
                            style: Theme.of(context).textTheme.labelMedium)
                      ],
                    ),
                  ),
                  const Divider(height: 12.0),
                  const SizedBox(height: 20),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              icon: const Icon(Icons.widgets,
                                  color: Colors.grey, semanticLabel: 'Name'),
                              hintText: 'What is the window name?',
                              labelText: S.of(context).windowName,
                            ),
                            controller: _nameController,
                            maxLength: 30,
                            validator: (value) {
                              return validateStringMinMax(value, 1, 30);
                            },
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
