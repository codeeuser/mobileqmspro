import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:mobileqmspro_client/mobileqmspro_client.dart';

// late SessionManager sessionManager;
late Client client;

Future<void> initializeServerpodClient() async {
  // Sets up a singleton client object that can be used to talk to the server from
  // anywhere in our app. The client is generated from your server code.
  // The client is set up to connect to a Serverpod running on a local server on
  // the default port. You will need to modify this to connect to staging or
  // production servers.
  client = Client(
    'http://localhost:8080/',
  )..connectivityMonitor = FlutterConnectivityMonitor();
}
