import 'dart:io';

import 'package:flutter/foundation.dart';
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
  final pem =
      getFromBytes(await rootBundle.load('assets/cert/vpaper_xyz_cert.pem'));
  final sc = (kReleaseMode && !kIsWeb)
      ? (SecurityContext()..setTrustedCertificatesBytes(pem))
      : null;
  client = Client(
    apiHost,
    securityContext: sc,
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();
  Logger.log(tag, message: 'client: ${client.host}');

  sessionManager = SessionManager(
    caller: client.modules.auth,
    storage: SharedPreferenceStorage(),
  );
  await sessionManager.initialize();
}

Uint8List getFromBytes(ByteData data) {
  final buffer = data.buffer;
  return buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
