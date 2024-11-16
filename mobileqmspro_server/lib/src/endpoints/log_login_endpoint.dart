import 'package:mobileqmspro_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class LogLoginEndpoint extends Endpoint {
  Future<List<LogLogin>> getAll(
      Session session, int? limit, int? offset, bool desc) async {
    return await LogLogin.db.find(
      session,
      limit: limit,
      offset: offset,
      orderBy: (t) => t.createdDate,
      orderDescending: desc,
    );
  }

  Future<LogLogin> update(Session session, LogLogin logLogin) async {
    return await LogLogin.db.updateRow(session, logLogin);
  }

  Future<LogLogin> create(Session session, LogLogin logLogin) async {
    return await LogLogin.db.insertRow(session, logLogin);
  }

  Future<void> delete(Session session, LogLogin logLogin) async {
    await LogLogin.db.deleteRow(session, logLogin);
  }

  Future<void> deleteByEmail(Session session, String email) async {
    List<LogLogin> list = await LogLogin.db.find(
      session,
      where: (t) => t.profileUser.email.equals(email),
    );
    await LogLogin.db.delete(session, list);
  }
}
