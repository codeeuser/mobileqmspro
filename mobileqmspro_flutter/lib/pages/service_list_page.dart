// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';
import 'package:mobileqmspro/app_profile.dart';
import 'package:mobileqmspro/commons/custom_appbar.dart';
import 'package:mobileqmspro/commons/no_data.dart';
import 'package:mobileqmspro/generated/l10n.dart';
import 'package:mobileqmspro/logger.dart';
import 'package:mobileqmspro/pages/more_page.dart';
import 'package:mobileqmspro/pages/service_new_page.dart';
import 'package:mobileqmspro/serverpod_client.dart';
import 'package:mobileqmspro/utils/functions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceListPage extends StatefulWidget {
  final SharedPreferences prefs;
  final QueueWindow window;

  const ServiceListPage({super.key, required this.prefs, required this.window});

  @override
  State<ServiceListPage> createState() => _ServiceListPageState();
}

class _ServiceListPageState extends State<ServiceListPage> {
  static const String tag = 'ServiceListPage';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  bool? _isVisible;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        label: S.of(context).title,
        title: Utils.getAppBarTitle(
            S.of(context).serviceList.toUpperCase(), context),
        goBackButton: Utils.goBackButton(() async {
          AppProfile appProfile = context.read<AppProfile>();
          final profileUser = appProfile.profileUser;
          final profileUserId = profileUser?.id;
          final email = profileUser?.email;
          if (profileUserId == null || email == null) return;
          QueueWindow? window =
              await client.queueWindow.getSelectedByEmail(email);
          if (window == null) return;
          Utils.pushPage(context, MorePage(prefs: widget.prefs, window: window),
              'MorePage');
        }),
      ),
      body: _buildContent(context),
      floatingActionButton: Visibility(
        visible: _isVisible ?? true,
        child: FloatingActionButton(
          child: const Icon(CupertinoIcons.plus, semanticLabel: 'Add'),
          onPressed: () async {
            Utils.pushPage(
                context,
                ServiceNewPage(prefs: widget.prefs, window: widget.window),
                'ServiceNewPage');
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final window = widget.window;
    final queueWindowId = window.id;
    if (queueWindowId == null) return const NoData();
    return SizedBox(
      child: Column(children: <Widget>[
        const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
                'To setup the stall, you should create Services. Press [+] on your right bottom icon for create a Service.')),
        Expanded(
          child: FutureBuilder(
              future: client.queueService
                  .getAllByWindowId(queueWindowId, null, null, false),
              builder: (context, AsyncSnapshot<List<QueueService>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Utils.loadingScreen();
                  case ConnectionState.active:
                  case ConnectionState.done:
                    List<QueueService>? serviceList = snapshot.data;
                    if (serviceList == null) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (serviceList.isEmpty) {
                      return const NoData();
                    }

                    return ListView.builder(
                        itemCount: serviceList.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return _serviceItem(
                              serviceList.elementAt(index), index);
                        });
                  default:
                    return const NoData();
                }
              }),
        ),
      ]),
    );
  }

  Widget _serviceItem(QueueService service, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Switch(
                value: (service.enable == false) ? false : true,
                onChanged: (bool value) async {
                  Logger.log(tag, message: 'service.enable: $value');
                  DateTime now = DateTime.now();
                  service.enable = value;
                  service.modifiedDate = now;
                  await client.queueService.update(service);
                  setState(() {});
                }),
            title: Text(service.name),
            subtitle: Text('${service.letter}-${service.start}'),
            trailing: IconButton(
              icon: const Icon(CupertinoIcons.ellipsis, semanticLabel: 'More'),
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
                        child: _buildSettingMenu(context, service),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingMenu(BuildContext context, QueueService service) {
    double margin = (MediaQuery.of(context).size.width / 2) - 200;
    return Container(
        margin: EdgeInsets.symmetric(horizontal: (margin < 0) ? 0 : margin),
        child: Column(children: <Widget>[
          ListTile(
            leading: const Icon(CupertinoIcons.pencil, semanticLabel: 'Edit'),
            title: Text(S.of(context).editService),
            onTap: () async {
              final serviceId = service.id;
              Logger.log(tag, message: 'serviceId: $serviceId');
              Navigator.of(context).pop();
              Utils.pushPage(
                  context,
                  ServiceNewPage(
                    prefs: widget.prefs,
                    window: widget.window,
                    serviceId: serviceId,
                  ),
                  'ServiceNewPage');
            },
          ),
        ]));
  }
}
