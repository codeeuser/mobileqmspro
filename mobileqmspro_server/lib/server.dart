import 'dart:io';

import 'package:serverpod/serverpod.dart';

import 'package:mobileqmspro_server/src/web/routes/root.dart';

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(), // modified serverpod code
    securityContext: SecurityContext.defaultContext,
  );
  // If you are using any future calls, they need to be registered here.
  // pod.registerFutureCall(ExampleFutureCall(), 'exampleFutureCall');

  // Setup a default page at the web root.
  pod.webServer.addRoute(RouteRoot(), '/');
  pod.webServer.addRoute(RouteRoot(), '/index.html');
  // Serve all files in the /static directory.
  pod.webServer.addRoute(
    RouteStaticDirectory(serverDirectory: 'static', basePath: '/'),
    '/*',
  );

  String runMode = pod.runMode;
  String serverId = pod.serverId;
  String publicScheme = pod.config.apiServer.publicScheme;
  String basePath = '..';
  String privatekeyPath = '$basePath/certificates/${runMode}_$serverId.key';
  String p12Path = '$basePath/certificates/${runMode}_$serverId.p12';
  String key = Platform.script.resolve(privatekeyPath).toFilePath();
  String p12 = Platform.script.resolve(p12Path).toFilePath();
  bool existKey = File(key).existsSync();
  bool existP12 = File(p12).existsSync();
  SecurityContext? sc;
  print(
      'publicScheme: $publicScheme, existKey: $existKey, existP12: $existP12');
  if (publicScheme == 'https' && existKey) {
    String? sslPassword = pod.getPassword('sslPassword');
    sc = pod.securityContext;
    sc?.usePrivateKey(key, password: '');
    sc?.useCertificateChain(p12, password: sslPassword);
  }

  // Start the server.
  await pod.start();
}
