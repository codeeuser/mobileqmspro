/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'queue_window.dart' as _i2;
import 'profile_user.dart' as _i3;

abstract class QueueService implements _i1.TableRow, _i1.ProtocolSerialization {
  QueueService._({
    this.id,
    required this.name,
    required this.letter,
    required this.start,
    this.enable,
    required this.orderNum,
    required this.createdDate,
    this.modifiedDate,
    required this.queueWindowId,
    this.queueWindow,
    required this.profileUserId,
    this.profileUser,
  });

  factory QueueService({
    int? id,
    required String name,
    required String letter,
    required int start,
    bool? enable,
    required int orderNum,
    required DateTime createdDate,
    DateTime? modifiedDate,
    required int queueWindowId,
    _i2.QueueWindow? queueWindow,
    required int profileUserId,
    _i3.ProfileUser? profileUser,
  }) = _QueueServiceImpl;

  factory QueueService.fromJson(Map<String, dynamic> jsonSerialization) {
    return QueueService(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      letter: jsonSerialization['letter'] as String,
      start: jsonSerialization['start'] as int,
      enable: jsonSerialization['enable'] as bool?,
      orderNum: jsonSerialization['orderNum'] as int,
      createdDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdDate']),
      modifiedDate: jsonSerialization['modifiedDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['modifiedDate']),
      queueWindowId: jsonSerialization['queueWindowId'] as int,
      queueWindow: jsonSerialization['queueWindow'] == null
          ? null
          : _i2.QueueWindow.fromJson(
              (jsonSerialization['queueWindow'] as Map<String, dynamic>)),
      profileUserId: jsonSerialization['profileUserId'] as int,
      profileUser: jsonSerialization['profileUser'] == null
          ? null
          : _i3.ProfileUser.fromJson(
              (jsonSerialization['profileUser'] as Map<String, dynamic>)),
    );
  }

  static final t = QueueServiceTable();

  static const db = QueueServiceRepository._();

  @override
  int? id;

  String name;

  String letter;

  int start;

  bool? enable;

  int orderNum;

  DateTime createdDate;

  DateTime? modifiedDate;

  int queueWindowId;

  _i2.QueueWindow? queueWindow;

  int profileUserId;

  _i3.ProfileUser? profileUser;

  @override
  _i1.Table get table => t;

  QueueService copyWith({
    int? id,
    String? name,
    String? letter,
    int? start,
    bool? enable,
    int? orderNum,
    DateTime? createdDate,
    DateTime? modifiedDate,
    int? queueWindowId,
    _i2.QueueWindow? queueWindow,
    int? profileUserId,
    _i3.ProfileUser? profileUser,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'letter': letter,
      'start': start,
      if (enable != null) 'enable': enable,
      'orderNum': orderNum,
      'createdDate': createdDate.toJson(),
      if (modifiedDate != null) 'modifiedDate': modifiedDate?.toJson(),
      'queueWindowId': queueWindowId,
      if (queueWindow != null) 'queueWindow': queueWindow?.toJson(),
      'profileUserId': profileUserId,
      if (profileUser != null) 'profileUser': profileUser?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'letter': letter,
      'start': start,
      if (enable != null) 'enable': enable,
      'orderNum': orderNum,
      'createdDate': createdDate.toJson(),
      if (modifiedDate != null) 'modifiedDate': modifiedDate?.toJson(),
      'queueWindowId': queueWindowId,
      if (queueWindow != null) 'queueWindow': queueWindow?.toJsonForProtocol(),
      'profileUserId': profileUserId,
      if (profileUser != null) 'profileUser': profileUser?.toJsonForProtocol(),
    };
  }

  static QueueServiceInclude include({
    _i2.QueueWindowInclude? queueWindow,
    _i3.ProfileUserInclude? profileUser,
  }) {
    return QueueServiceInclude._(
      queueWindow: queueWindow,
      profileUser: profileUser,
    );
  }

  static QueueServiceIncludeList includeList({
    _i1.WhereExpressionBuilder<QueueServiceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QueueServiceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QueueServiceTable>? orderByList,
    QueueServiceInclude? include,
  }) {
    return QueueServiceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QueueService.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(QueueService.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QueueServiceImpl extends QueueService {
  _QueueServiceImpl({
    int? id,
    required String name,
    required String letter,
    required int start,
    bool? enable,
    required int orderNum,
    required DateTime createdDate,
    DateTime? modifiedDate,
    required int queueWindowId,
    _i2.QueueWindow? queueWindow,
    required int profileUserId,
    _i3.ProfileUser? profileUser,
  }) : super._(
          id: id,
          name: name,
          letter: letter,
          start: start,
          enable: enable,
          orderNum: orderNum,
          createdDate: createdDate,
          modifiedDate: modifiedDate,
          queueWindowId: queueWindowId,
          queueWindow: queueWindow,
          profileUserId: profileUserId,
          profileUser: profileUser,
        );

  @override
  QueueService copyWith({
    Object? id = _Undefined,
    String? name,
    String? letter,
    int? start,
    Object? enable = _Undefined,
    int? orderNum,
    DateTime? createdDate,
    Object? modifiedDate = _Undefined,
    int? queueWindowId,
    Object? queueWindow = _Undefined,
    int? profileUserId,
    Object? profileUser = _Undefined,
  }) {
    return QueueService(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      letter: letter ?? this.letter,
      start: start ?? this.start,
      enable: enable is bool? ? enable : this.enable,
      orderNum: orderNum ?? this.orderNum,
      createdDate: createdDate ?? this.createdDate,
      modifiedDate:
          modifiedDate is DateTime? ? modifiedDate : this.modifiedDate,
      queueWindowId: queueWindowId ?? this.queueWindowId,
      queueWindow: queueWindow is _i2.QueueWindow?
          ? queueWindow
          : this.queueWindow?.copyWith(),
      profileUserId: profileUserId ?? this.profileUserId,
      profileUser: profileUser is _i3.ProfileUser?
          ? profileUser
          : this.profileUser?.copyWith(),
    );
  }
}

class QueueServiceTable extends _i1.Table {
  QueueServiceTable({super.tableRelation}) : super(tableName: 'queue_service') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    letter = _i1.ColumnString(
      'letter',
      this,
    );
    start = _i1.ColumnInt(
      'start',
      this,
    );
    enable = _i1.ColumnBool(
      'enable',
      this,
    );
    orderNum = _i1.ColumnInt(
      'orderNum',
      this,
    );
    createdDate = _i1.ColumnDateTime(
      'createdDate',
      this,
    );
    modifiedDate = _i1.ColumnDateTime(
      'modifiedDate',
      this,
    );
    queueWindowId = _i1.ColumnInt(
      'queueWindowId',
      this,
    );
    profileUserId = _i1.ColumnInt(
      'profileUserId',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString letter;

  late final _i1.ColumnInt start;

  late final _i1.ColumnBool enable;

  late final _i1.ColumnInt orderNum;

  late final _i1.ColumnDateTime createdDate;

  late final _i1.ColumnDateTime modifiedDate;

  late final _i1.ColumnInt queueWindowId;

  _i2.QueueWindowTable? _queueWindow;

  late final _i1.ColumnInt profileUserId;

  _i3.ProfileUserTable? _profileUser;

  _i2.QueueWindowTable get queueWindow {
    if (_queueWindow != null) return _queueWindow!;
    _queueWindow = _i1.createRelationTable(
      relationFieldName: 'queueWindow',
      field: QueueService.t.queueWindowId,
      foreignField: _i2.QueueWindow.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.QueueWindowTable(tableRelation: foreignTableRelation),
    );
    return _queueWindow!;
  }

  _i3.ProfileUserTable get profileUser {
    if (_profileUser != null) return _profileUser!;
    _profileUser = _i1.createRelationTable(
      relationFieldName: 'profileUser',
      field: QueueService.t.profileUserId,
      foreignField: _i3.ProfileUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ProfileUserTable(tableRelation: foreignTableRelation),
    );
    return _profileUser!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        letter,
        start,
        enable,
        orderNum,
        createdDate,
        modifiedDate,
        queueWindowId,
        profileUserId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'queueWindow') {
      return queueWindow;
    }
    if (relationField == 'profileUser') {
      return profileUser;
    }
    return null;
  }
}

class QueueServiceInclude extends _i1.IncludeObject {
  QueueServiceInclude._({
    _i2.QueueWindowInclude? queueWindow,
    _i3.ProfileUserInclude? profileUser,
  }) {
    _queueWindow = queueWindow;
    _profileUser = profileUser;
  }

  _i2.QueueWindowInclude? _queueWindow;

  _i3.ProfileUserInclude? _profileUser;

  @override
  Map<String, _i1.Include?> get includes => {
        'queueWindow': _queueWindow,
        'profileUser': _profileUser,
      };

  @override
  _i1.Table get table => QueueService.t;
}

class QueueServiceIncludeList extends _i1.IncludeList {
  QueueServiceIncludeList._({
    _i1.WhereExpressionBuilder<QueueServiceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(QueueService.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => QueueService.t;
}

class QueueServiceRepository {
  const QueueServiceRepository._();

  final attachRow = const QueueServiceAttachRowRepository._();

  Future<List<QueueService>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QueueServiceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QueueServiceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QueueServiceTable>? orderByList,
    _i1.Transaction? transaction,
    QueueServiceInclude? include,
  }) async {
    return session.db.find<QueueService>(
      where: where?.call(QueueService.t),
      orderBy: orderBy?.call(QueueService.t),
      orderByList: orderByList?.call(QueueService.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<QueueService?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QueueServiceTable>? where,
    int? offset,
    _i1.OrderByBuilder<QueueServiceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QueueServiceTable>? orderByList,
    _i1.Transaction? transaction,
    QueueServiceInclude? include,
  }) async {
    return session.db.findFirstRow<QueueService>(
      where: where?.call(QueueService.t),
      orderBy: orderBy?.call(QueueService.t),
      orderByList: orderByList?.call(QueueService.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<QueueService?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    QueueServiceInclude? include,
  }) async {
    return session.db.findById<QueueService>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<QueueService>> insert(
    _i1.Session session,
    List<QueueService> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<QueueService>(
      rows,
      transaction: transaction,
    );
  }

  Future<QueueService> insertRow(
    _i1.Session session,
    QueueService row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<QueueService>(
      row,
      transaction: transaction,
    );
  }

  Future<List<QueueService>> update(
    _i1.Session session,
    List<QueueService> rows, {
    _i1.ColumnSelections<QueueServiceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<QueueService>(
      rows,
      columns: columns?.call(QueueService.t),
      transaction: transaction,
    );
  }

  Future<QueueService> updateRow(
    _i1.Session session,
    QueueService row, {
    _i1.ColumnSelections<QueueServiceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<QueueService>(
      row,
      columns: columns?.call(QueueService.t),
      transaction: transaction,
    );
  }

  Future<List<QueueService>> delete(
    _i1.Session session,
    List<QueueService> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<QueueService>(
      rows,
      transaction: transaction,
    );
  }

  Future<QueueService> deleteRow(
    _i1.Session session,
    QueueService row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<QueueService>(
      row,
      transaction: transaction,
    );
  }

  Future<List<QueueService>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<QueueServiceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<QueueService>(
      where: where(QueueService.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QueueServiceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<QueueService>(
      where: where?.call(QueueService.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class QueueServiceAttachRowRepository {
  const QueueServiceAttachRowRepository._();

  Future<void> queueWindow(
    _i1.Session session,
    QueueService queueService,
    _i2.QueueWindow queueWindow, {
    _i1.Transaction? transaction,
  }) async {
    if (queueService.id == null) {
      throw ArgumentError.notNull('queueService.id');
    }
    if (queueWindow.id == null) {
      throw ArgumentError.notNull('queueWindow.id');
    }

    var $queueService = queueService.copyWith(queueWindowId: queueWindow.id);
    await session.db.updateRow<QueueService>(
      $queueService,
      columns: [QueueService.t.queueWindowId],
      transaction: transaction,
    );
  }

  Future<void> profileUser(
    _i1.Session session,
    QueueService queueService,
    _i3.ProfileUser profileUser, {
    _i1.Transaction? transaction,
  }) async {
    if (queueService.id == null) {
      throw ArgumentError.notNull('queueService.id');
    }
    if (profileUser.id == null) {
      throw ArgumentError.notNull('profileUser.id');
    }

    var $queueService = queueService.copyWith(profileUserId: profileUser.id);
    await session.db.updateRow<QueueService>(
      $queueService,
      columns: [QueueService.t.profileUserId],
      transaction: transaction,
    );
  }
}
