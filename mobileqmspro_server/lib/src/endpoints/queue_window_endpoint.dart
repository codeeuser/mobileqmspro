import 'package:mobileqmspro_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class QueueWindowEndpoint extends Endpoint {
  Future<List<QueueWindow>> getAllByEmail(
      Session session, String email, int? limit, int? offset, bool desc) async {
    return await QueueWindow.db.find(
      session,
      where: (t) => t.profileUser.email.equals(email),
      limit: limit,
      offset: offset,
      orderBy: (t) => t.orderNum,
      orderDescending: desc,
    );
  }

  Future<QueueWindow?> getSelectedByEmail(Session session, String email) async {
    List<QueueWindow> list = await QueueWindow.db.find(
      session,
      where: (t) => t.profileUser.email.equals(email) & t.selected.equals(true),
    );
    if (list.isNotEmpty == true) {
      return list.last;
    }
    return null;
  }

  Future<QueueWindow?> findById(Session session, int id) async {
    return await QueueWindow.db.findById(session, id);
  }

  Future<void> updateSelected(
      Session session, QueueWindow queueWindow, String email) async {
    List<QueueWindow> list =
        await getAllByEmail(session, email, null, null, false);
    for (QueueWindow window in list) {
      window.selected = false;
      if (window.id == queueWindow.id) {
        window.selected = queueWindow.selected;
      }
    }
    await QueueWindow.db.update(session, list);
  }

  Future<QueueWindow> update(Session session, QueueWindow queueWindow) async {
    return await QueueWindow.db.updateRow(session, queueWindow);
  }

  Future<QueueWindow> create(Session session, QueueWindow queueWindow) async {
    return await QueueWindow.db.insertRow(session, queueWindow);
  }

  Future<void> delete(Session session, QueueWindow queueWindow) async {
    await QueueWindow.db.deleteRow(session, queueWindow);
  }

  Future<void> deleteByEmail(Session session, String email) async {
    List<QueueWindow> list = await QueueWindow.db.find(
      session,
      where: (t) => t.profileUser.email.equals(email),
    );
    await QueueWindow.db.delete(session, list);
  }

  Future<int> countByEmail(Session session, String email) async {
    return await QueueWindow.db.count(
      session,
      where: (t) => t.profileUser.email.equals(email),
    );
  }
}
