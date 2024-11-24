import 'dart:math';

import 'package:mobileqmspro_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

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
}
