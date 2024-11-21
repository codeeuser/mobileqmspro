import 'dart:io';
import 'dart:math';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mobileqmspro_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import 'package:yaml/yaml.dart';

class ProfileUserEndpoint extends Endpoint {
  Future<ProfileUser> login(Session session, String email) async {
    List<ProfileUser> list =
        await ProfileUser.db.find(session, where: (t) => t.email.equals(email));
    ProfileUser? profileUser;
    if (list.isEmpty) {
      profileUser = ProfileUser(
          email: email,
          passcode: _randomDigit(6),
          membership: Membership.basic,
          createdDate: DateTime.now());
      profileUser = await ProfileUser.db.insertRow(session, profileUser);
      // send mail
      await _sendMail(session, profileUser);
    } else {
      profileUser = list.last;
    }
    return profileUser;
  }

  Future<ProfileUser?> forgetPasscode(Session session, String email) async {
    List<ProfileUser> list =
        await ProfileUser.db.find(session, where: (t) => t.email.equals(email));
    ProfileUser? profileUser;
    if (list.isNotEmpty) {
      profileUser = list.last;
      profileUser.passcode = _randomDigit(6);
      profileUser.modifiedDate = DateTime.now();
      profileUser = await ProfileUser.db.updateRow(session, profileUser);
      // send mail
      await _sendMail(session, profileUser);
    }
    return profileUser;
  }

  Future<ProfileUser?> findByEmail(Session session, String email) async {
    List<ProfileUser> list =
        await ProfileUser.db.find(session, where: (t) => t.email.equals(email));
    if (list.isEmpty) return null;
    return list.last;
  }

  Future<ProfileUser> update(Session session, ProfileUser profileUser) async {
    return await ProfileUser.db.updateRow(session, profileUser);
  }

  Future<ProfileUser> create(Session session, ProfileUser profileUser) async {
    return await ProfileUser.db.insertRow(session, profileUser);
  }

  Future<void> delete(Session session, ProfileUser profileUser) async {
    await ProfileUser.db.deleteRow(session, profileUser);
    var rows = await UserInfo.db
        .find(session, where: (t) => t.email.equals(profileUser.email));

    await EmailCreateAccountRequest.db
        .deleteWhere(session, where: (t) => t.email.equals(profileUser.email));
    await EmailAuth.db.deleteWhere(
      session,
      where: (t) => t.email.equals(profileUser.email),
    );
    for (var row in rows) {
      await UserImage.db.deleteWhere(
        session,
        where: (t) => t.userId.equals(row.id),
      );
    }
    await UserInfo.db.deleteWhere(
      session,
      where: (t) => t.email.equals(profileUser.email),
    );
  }

  String _randomDigit(int numberOfDigit) {
    Random random = Random();
    String number = '';
    for (int i = 0; i < numberOfDigit; i++) {
      number = number + random.nextInt(9).toString();
    }
    return number;
  }

  Future<void> _sendMail(Session session, ProfileUser profileUser) async {
    session.log('_sendMail---, email: ${profileUser.email}');
    Map<String, String> passwords = session.passwords;
    String? password = passwords['mailPassword'];
    if (password == null) return;

    String filename = '${session.server.runMode}_mail.yaml';
    final file = File('config/$filename');
    if (file.existsSync() == false) return;
    final yamlString = file.readAsStringSync();
    final map = loadYaml(yamlString)['mail'];
    String? smtp = map['smtp'];
    int port = map['port'] ?? 587;
    bool ssl = map['ssl'] ?? false;
    String? mailAddress = map['mailAddress'];
    String? username = map['username'];
    session.log('mailAddress: $mailAddress, port: $port');
    if (smtp == null || mailAddress == null || username == null) return;
    // Use the SmtpServer class to configure an SMTP server:
    final smtpServer = SmtpServer(smtp,
        port: port, ssl: ssl, username: username, password: password);

    // Create message.
    final passcode = profileUser.passcode;
    var subject = 'Your MobileQMSPro Passcode';
    var html = 'Hello,<br/><br/>';
    html += 'PASSCODE is <strong><h1>$passcode</h1></strong><br/><br/>';
    html +=
        'Please use this passcode to verify your MobileQMSPro account.<br/><br/>';
    html +=
        'If you did not make this request, please ignore this email.<br/><br/>';
    html += 'Thank you for using mobileQMSPro.<br/><br/>';
    html += 'MobileQMS<br/><br/>';
    final message = Message()
      ..from = Address(mailAddress, 'MobileQMSPro')
      ..recipients.add(profileUser.email)
      ..subject = subject
      ..text = 'Your MobileQMSPro Passcode\n\n$passcode.'
      ..html = html;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');
    } on MailerException catch (e) {
      print('Message not sent. $e');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
