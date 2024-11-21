import 'package:flutter/services.dart';
import 'package:mobileqmspro/logger.dart';
import 'package:mobileqmspro/utils/constants.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';
import 'package:yaml/yaml.dart';

// late SessionManager sessionManager;
late Client client;
late SessionManager sessionManager;
late dynamic mapConfig;

Future<void> initializeServerpodClient() async {
  const tag = 'initializeServerpodClient';
  final config = await rootBundle.loadString('assets/config/$configFile');
  mapConfig = loadYaml(config);
  final apiHost = mapConfig['serverpod']['apiHost'];
  Logger.log(tag, message: 'apiHost: $apiHost');
  // Sets up a singleton client object that can be used to talk to the server from
  // anywhere in our app. The client is generated from your server code.
  // The client is set up to connect to a Serverpod running on a local server on
  // the default port. You will need to modify this to connect to staging or
  // production servers.
  client = Client(
    apiHost,
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();
  Logger.log(tag, message: 'client: ${client.host}');

  sessionManager = SessionManager(
    caller: client.modules.auth,
    storage: SharedPreferenceStorage(),
  );
  await sessionManager.initialize();
}
