// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mobileqmspro/utils/constants.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';
import 'package:mobileqmspro/app_profile.dart';
import 'package:mobileqmspro/generated/l10n.dart';
import 'package:mobileqmspro/logger.dart';
import 'package:mobileqmspro/pages/service_list_page.dart';
import 'package:mobileqmspro/serverpod_client.dart';
import 'package:mobileqmspro/styles.dart';
import 'package:mobileqmspro/utils/functions.dart';
import 'package:mobileqmspro/utils/validation_function.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceNewPage extends StatefulWidget {
  final SharedPreferences prefs;
  final QueueWindow window;
  final int? serviceId;

  const ServiceNewPage(
      {super.key, required this.prefs, required this.window, this.serviceId});

  @override
  State<ServiceNewPage> createState() => _ServiceNewPageState();
}

class _ServiceNewPageState extends State<ServiceNewPage> {
  static const String tag = 'ServiceNewPage';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _letterController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  QueueService? _service;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final serviceId = widget.serviceId;
    if (serviceId == null) return;
    QueueService? service = await client.queueService.findById(serviceId);
    if (service != null) {
      setState(() {
        _service = service;
        _nameController.text = service.name.trim();
        _letterController.text = service.letter.trim();
        _startController.text = service.start.toString();
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _letterController.dispose();
    _startController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            child: SizedBox(
              width: (constraints.maxWidth > WidgetProp.width)
                  ? WidgetProp.width
                  : constraints.maxWidth,
              child: PopScope(
                canPop: true,
                child: Scaffold(
                    key: _scaffoldKey,
                    appBar: AppBar(
                      centerTitle: true,
                      title: Text(S.of(context).serviceForm),
                      backgroundColor: const Color.fromRGBO(35, 197, 221, 1.0),
                      actions: [
                        TextButton(
                          child: (_service == null)
                              ? Text(S.of(context).save.toUpperCase(),
                                  style: Styles.actionBtn)
                              : Text(S.of(context).update.toUpperCase(),
                                  style: Styles.actionBtn),
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
                            if (profileUserId == null || email == null) return;
                            final windowId = widget.window.id;
                            if (windowId == null) return;
                            String name = _nameController.text.trim();
                            String letter = _letterController.text.trim();
                            int start = int.parse(_startController.text.trim());
                            int? count = await client.queueService
                                .countByWindow(windowId);
                            int orderNum = count + 1;
                            DateTime now = DateTime.now();
                            QueueService? service = _service;
                            if (service == null) {
                              QueueService serviceNew = QueueService(
                                  name: name,
                                  letter: letter,
                                  start: start,
                                  enable: false,
                                  orderNum: orderNum,
                                  createdDate: now,
                                  modifiedDate: now,
                                  queueWindowId: windowId,
                                  profileUserId: profileUserId);
                              _service =
                                  await client.queueService.create(serviceNew);
                            } else {
                              service.name = name;
                              service.letter = letter;
                              service.start = start;
                              service.modifiedDate = now;
                              await client.queueService.update(service);
                            }
                            Utils.pushPage(
                                context,
                                ServiceListPage(
                                  prefs: widget.prefs,
                                  window: widget.window,
                                ),
                                'ServiceListPage');
                          },
                        ),
                      ],
                    ),
                    body: _buildContent(context)),
              ),
            ),
          ));
    });
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Text(
                    'Service name may be your business provided services. For example, Book Table, Information, Payment etc',
                    style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 10),
                Text(
                    'The issued token consists of "Service Letter" and "Number". For example, A-1000. Service Letter should be alphanumeric. Start Number should be digits.',
                    style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          ),
          const Divider(height: 12.0),
          Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      icon: const Icon(Icons.room_service,
                          color: Colors.grey, semanticLabel: 'Name'),
                      hintText: 'What is the service name?',
                      labelText: S.of(context).serviceName,
                    ),
                    controller: _nameController,
                    maxLength: 20,
                    validator: (value) {
                      return validateStringMinMax(value, 1, 20);
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      icon: const Icon(Icons.text_fields,
                          color: Colors.grey, semanticLabel: 'Letter'),
                      hintText: 'What is the service letter?',
                      labelText: S.of(context).serviceLetter,
                    ),
                    controller: _letterController,
                    maxLength: 3,
                    validator: (value) {
                      return validateStringMinMax(value, 1, 3);
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      icon: const Icon(Icons.queue,
                          color: Colors.grey, semanticLabel: 'Number'),
                      hintText: 'What is the start number?',
                      labelText: S.of(context).startNumber,
                    ),
                    controller: _startController,
                    maxLength: 4,
                    validator: (value) {
                      return validateNum(value, 1, 9999);
                    },
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
