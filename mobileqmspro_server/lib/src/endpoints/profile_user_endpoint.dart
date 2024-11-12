import 'package:mobileqmspro_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ProfileUserEndpoint extends Endpoint {
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
  }
}
