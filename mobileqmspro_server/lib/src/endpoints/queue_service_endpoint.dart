import 'package:mobileqmspro_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class QueueServiceEndpoint extends Endpoint {
  Future<List<QueueService>> getAllByWindowId(Session session,
      int queueWindowId, int? limit, int? offset, bool desc) async {
    return await QueueService.db.find(
      session,
      where: (t) => t.queueWindow.id.equals(queueWindowId),
      limit: limit,
      offset: offset,
      orderBy: (t) => t.orderNum,
      orderDescending: desc,
    );
  }

  Future<List<QueueService>> getAllByWindowIdAndEnable(
      Session session, int queueWindowId, bool desc) async {
    return await QueueService.db.find(
      session,
      where: (t) =>
          t.queueWindow.id.equals(queueWindowId) & t.enable.equals(true),
      orderBy: (t) => t.orderNum,
      orderDescending: desc,
    );
  }

  Future<QueueService?> findById(Session session, int id) async {
    return await QueueService.db.findById(session, id);
  }

  Future<QueueService> update(
      Session session, QueueService queueService) async {
    return await QueueService.db.updateRow(session, queueService);
  }

  Future<List<QueueService>> createAll(
      Session session, List<QueueService> queueServiceList) async {
    return await QueueService.db.insert(session, queueServiceList);
  }

  Future<QueueService> create(
      Session session, QueueService queueService) async {
    return await QueueService.db.insertRow(session, queueService);
  }

  Future<void> delete(Session session, QueueService queueService) async {
    await QueueService.db.deleteRow(session, queueService);
  }

  Future<void> deleteByEmail(Session session, String email) async {
    List<QueueService> list = await QueueService.db.find(
      session,
      where: (t) => t.profileUser.email.equals(email),
    );
    await QueueService.db.delete(session, list);
  }

  Future<int> countByWindow(Session session, int windowId) async {
    return await QueueService.db.count(
      session,
      where: (t) => t.queueWindow.id.equals(windowId),
    );
  }
}
