import 'package:mobileqmspro_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class TokenIssuedEndpoint extends Endpoint {
  static const _channelRunningTokens = 'running-tokens';
  static const _channelCountToken = 'count-token';
  Future<List<TokenIssued>> getAllByWindowId(
      Session session, int windowId, int? limit, int? offset, bool desc) async {
    return await TokenIssued.db.find(session,
        where: (t) => t.queueWindow.id.equals(windowId) & t.reset.equals(false),
        limit: limit,
        offset: offset,
        orderBy: (t) => t.modifiedDate,
        orderDescending: desc,
        include: TokenIssued.include(queueService: QueueService.include()));
  }

  Future<List<TokenIssued>> getAllByWindowAndStatus(Session session,
      int windowId, int statusCode, int? limit, int? offset, bool desc) async {
    return await TokenIssued.db.find(session,
        where: (t) =>
            t.queueWindow.id.equals(windowId) &
            t.statusCode.equals(statusCode) &
            t.reset.equals(false),
        limit: limit,
        offset: offset,
        orderBy: (t) => t.assignedDate,
        orderDescending: desc,
        include: TokenIssued.include(queueService: QueueService.include()));
  }

  Future<List<TokenIssued>> getAllByWindowAndOnQueue(
      Session session, int windowId, int? limit, int? offset, bool desc) async {
    return await TokenIssued.db.find(session,
        where: (t) =>
            t.queueWindow.id.equals(windowId) &
            t.isOnQueue.equals(true) &
            t.reset.equals(false),
        limit: limit,
        offset: offset,
        orderBy: (t) => t.assignedDate,
        orderDescending: desc,
        include: TokenIssued.include(queueService: QueueService.include()));
  }

  Future<List<TokenIssued>> getAllByServiceId(Session session, int serviceId,
      int? limit, int? offset, bool desc) async {
    return await TokenIssued.db.find(
      session,
      where: (t) => t.queueService.id.equals(serviceId) & t.reset.equals(false),
      limit: limit,
      offset: offset,
      orderBy: (t) => t.assignedDate,
      orderDescending: desc,
    );
  }

  Future<TokenIssued?> findByToken(
      Session session, String letter, int start) async {
    List<TokenIssued> list = await TokenIssued.db.find(session,
        where: (t) =>
            t.tokenLetter.equals(letter) &
            t.tokenNumber.equals(start) &
            t.reset.equals(false));
    if (list.isNotEmpty) {
      return list.last;
    }
    return null;
  }

  Future<TokenIssued?> findById(Session session, int id) async {
    return await TokenIssued.db.findById(session, id,
        include: TokenIssued.include(queueService: QueueService.include()));
  }

  Future<TokenIssued?> findLatestTokenIssuedByWindowAndService(
      Session session, int windowId, int serviceId) async {
    List<TokenIssued> list = await TokenIssued.db.find(
      session,
      where: (t) =>
          t.queueWindow.id.equals(windowId) &
          t.queueService.id.equals(serviceId) &
          t.reset.equals(false),
      orderBy: (t) => t.createdDate,
      orderDescending: true,
    );
    if (list.isNotEmpty) {
      return list.first;
    }
    return null;
  }

  Future<TokenIssued> update(Session session, TokenIssued tokenIssued) async {
    final item = await TokenIssued.db.updateRow(session, tokenIssued);
    await _updateRunningStream(session);
    return item;
  }

  Future<List<TokenIssued>> updateAll(
      Session session, List<TokenIssued> tokenIssuedList) async {
    final listNew = await TokenIssued.db.update(session, tokenIssuedList);
    await _updateRunningStream(session);
    return listNew;
  }

  Future<List<TokenIssued>> resetAll(Session session, int windowId) async {
    List<TokenIssued> list =
        await getAllByWindowId(session, windowId, null, null, false);
    for (TokenIssued issued in list) {
      issued.reset = true;
    }
    final listNew = await TokenIssued.db.update(session, list);
    await _updateRunningStream(session);
    return listNew;
  }

  Future<TokenIssued?> create(Session session, TokenIssued tokenIssued) async {
    TokenIssued? tokenIssuedNew =
        await TokenIssued.db.insertRow(session, tokenIssued);
    final id = tokenIssuedNew.id;
    if (id != null) {
      tokenIssuedNew = await findById(session, id);
    }
    await _updateRunningStream(session);
    return tokenIssuedNew;
  }

  Future<void> delete(Session session, TokenIssued tokenIssued) async {
    await TokenIssued.db.deleteRow(session, tokenIssued);
    await _updateRunningStream(session);
  }

  Future<void> deleteByEmail(Session session, String email) async {
    List<TokenIssued> list = await TokenIssued.db.find(
      session,
      where: (t) => t.profileUser.email.equals(email),
    );
    await TokenIssued.db.delete(session, list);
  }

  Future<int> countIsQueueStatus(Session session, int windowId) async {
    var count = await TokenIssued.db.count(
      session,
      where: (t) =>
          t.isOnQueue.equals(true) &
          t.queueWindow.id.equals(windowId) &
          t.reset.equals(false),
    );
    return count;
  }

  Future<int> countStatus(Session session, int statusCode, int windowId) async {
    var count = await TokenIssued.db.count(
      session,
      where: (t) =>
          t.statusCode.equals(statusCode) &
          t.queueWindow.id.equals(windowId) &
          t.reset.equals(false),
    );
    return count;
  }

  Future<void> _updateRunningStream(Session session) async {
    await session.messages.postMessage(_channelRunningTokens, RunningTokens());
  }

  Stream echoStatusStream(
      Session session, int statusCode, int windowId) async* {
    session.log('echoStatusStream---');
    var updateStream =
        session.messages.createStream<CountToken>(_channelCountToken);
    final count = await countStatus(session, statusCode, windowId);
    final countIsQueue = await countIsQueueStatus(session, windowId);
    yield CountToken(countIsQueue: countIsQueue, countWait: count);
    await for (var update in updateStream) {
      session.log('update: $update');
      final count = await countStatus(session, statusCode, windowId);
      final countIsQueue = await countIsQueueStatus(session, windowId);
      yield CountToken(countIsQueue: countIsQueue, countWait: count);
    }
  }

  Stream echoTokensStream(Session session, int windowId) async* {
    session.log('echoTokensStream---');
    var updateStream =
        session.messages.createStream<RunningTokens>(_channelRunningTokens);
    List<TokenIssued> list =
        await getAllByWindowId(session, windowId, 25, 0, true);
    yield RunningTokens(tokens: list);
    await for (var update in updateStream) {
      session.log('update: $update');
      List<TokenIssued> list =
          await getAllByWindowId(session, windowId, 25, 0, true);
      yield RunningTokens(tokens: list);
    }
  }
}
