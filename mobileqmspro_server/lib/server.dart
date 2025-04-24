import 'dart:io';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;
import 'package:yaml/yaml.dart';

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

void run(List<String> args) async {
  final sc =
      (args.contains('production')) ? SecurityContext.defaultContext : null;
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: auth.authenticationHandler,
    securityContextConfig:
        SecurityContextConfig(apiServer: sc, webServer: sc, insightsServer: sc),
  );
  // If you are using any future calls, they need to be registered here.
  // pod.registerFutureCall(ExampleFutureCall(), 'exampleFutureCall');

  // Setup a default page at the web root.
  // pod.webServer.addRoute(RouteRoot(), '/');
  // pod.webServer.addRoute(RouteRoot(), '/index.html');
  // // Serve all files in the /static directory.
  // pod.webServer.addRoute(
  //   RouteStaticDirectory(serverDirectory: 'static', basePath: '/'),
  //   '/*',
  // );

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

  print(
      'publicScheme: $publicScheme, existKey: $existKey, existP12: $existP12');
  if (publicScheme == 'https' && existKey && existP12) {
    String? sslPassword = pod.getPassword('sslPassword');
    sc?.usePrivateKey(key, password: '');
    sc?.useCertificateChain(p12, password: sslPassword);
  }

  auth.AuthConfig.set(auth.AuthConfig(
    sendValidationEmail: (session, email, validationCode) async {
      // Send the validation email to the user.
      // Return `true` if the email was successfully sent, otherwise `false`.
      session.log('$email, validationCode: $validationCode');
      return sendNewMail(session, email, validationCode);
    },
    sendPasswordResetEmail: (session, userInfo, validationCode) async {
      // Send the password reset email to the user.
      // Return `true` if the email was successfully sent, otherwise `false`.
      session.log('${userInfo.email}, validationCode: $validationCode');
      return sendResetMail(session, userInfo, validationCode);
    },
  ));

  // Start the server.
  await pod.start().onError((e, s) {
    print('e:$e, s: $s');
  });

  await pod.webServer.stop();
}

Future<bool> sendResetMail(
    Session session, auth.UserInfo userInfo, String validationCode) async {
  final email = userInfo.email;
  if (email == null) return false;
  final smtpServer = creatSmtpServer(session, email);
  final mailAddress = smtpServer?.username;
  if (mailAddress == null) return false;
  // Create message.
  var subject = 'Your MobileQMSPro Reset Password';
  var html = 'Hello,<br/><br/>';
  html +=
      'Validation Code is <strong><h1>$validationCode</h1></strong><br/><br/>';
  html +=
      'Please use this Validation Code to verify your MobileQMSPro account.<br/><br/>';
  html +=
      'If you did not make this request, please ignore this email.<br/><br/>';
  html += 'Thank you for using mobileQMSPro.<br/><br/>';
  html += 'MobileQMSPro<br/><br/>';
  final message = Message()
    ..from = Address(mailAddress, 'MobileQMSPro')
    ..recipients.add(email)
    ..subject = subject
    ..text = 'Your MobileQMSPro Validation Code\n\n$validationCode.'
    ..html = html;

  return sendMail(session, message, smtpServer);
}

Future<bool> sendNewMail(
    Session session, String email, String validationCode) async {
  final smtpServer = creatSmtpServer(session, email);
  final mailAddress = smtpServer?.username;
  if (mailAddress == null) return false;
  // Create message.
  var subject = 'Your MobileQMSPro Validation Code';
  var html = 'Hello,<br/><br/>';
  html +=
      'Validation Code is <strong><h1>$validationCode</h1></strong><br/><br/>';
  html +=
      'Please use this Validation Code to verify your MobileQMSPro account.<br/><br/>';
  html +=
      'If you did not make this request, please ignore this email.<br/><br/>';
  html += 'Thank you for using mobileQMSPro.<br/><br/>';
  html += 'MobileQMSPro<br/><br/>';
  final message = Message()
    ..from = Address(mailAddress, 'MobileQMSPro')
    ..recipients.add(email)
    ..subject = subject
    ..text = 'Your MobileQMSPro Validation Code\n\n$validationCode.'
    ..html = html;

  return sendMail(session, message, smtpServer);
}

SmtpServer? creatSmtpServer(Session session, String email) {
  session.log('_sendMail---, email: $email');
  Map<String, String> passwords = session.passwords;
  String? password = passwords['mailPassword'];
  if (password == null) return null;

  String filename = '${session.server.runMode}_mail.yaml';
  final file = File('config/$filename');
  if (file.existsSync() == false) return null;
  final yamlString = file.readAsStringSync();
  final map = loadYaml(yamlString)['mail'];
  String? smtp = map['smtp'];
  int port = map['port'] ?? 587;
  bool ssl = map['ssl'] ?? false;
  String? username = map['username'];
  session.log('username: $username, port: $port');
  if (smtp == null || username == null) return null;
  // Use the SmtpServer class to configure an SMTP server:
  final smtpServer = SmtpServer(smtp,
      port: port, ssl: ssl, username: username, password: password);
  return smtpServer;
}

Future<bool> sendMail(
    Session session, Message message, SmtpServer? smtpServer) async {
  if (smtpServer == null) return false;
  try {
    final sendReport = await send(message, smtpServer);
    session.log('Message sent: $sendReport');
    return true;
  } on MailerException catch (e) {
    print('Message not sent. $e');
    for (var p in e.problems) {
      session.log('Problem: ${p.code}: ${p.msg}');
    }
    return false;
  }
}
