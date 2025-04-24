/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'queue_window.dart' as _i2;
import 'queue_service.dart' as _i3;
import 'profile_user.dart' as _i4;

abstract class TokenIssued
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TokenIssued._({
    this.id,
    required this.tokenLetter,
    required this.tokenNumber,
    required this.statusName,
    required this.statusCode,
    required this.statusAcronym,
    required this.isOnWait,
    required this.isOnQueue,
    required this.isRecall,
    required this.isCompleted,
    required this.reset,
    required this.createdDate,
    this.assignedDate,
    this.modifiedDate,
    required this.queueWindowId,
    this.queueWindow,
    required this.queueServiceId,
    this.queueService,
    required this.profileUserId,
    this.profileUser,
  });

  factory TokenIssued({
    int? id,
    required String tokenLetter,
    required int tokenNumber,
    required String statusName,
    required int statusCode,
    required String statusAcronym,
    required bool isOnWait,
    required bool isOnQueue,
    required bool isRecall,
    required bool isCompleted,
    required bool reset,
    required DateTime createdDate,
    DateTime? assignedDate,
    DateTime? modifiedDate,
    required int queueWindowId,
    _i2.QueueWindow? queueWindow,
    required int queueServiceId,
    _i3.QueueService? queueService,
    required int profileUserId,
    _i4.ProfileUser? profileUser,
  }) = _TokenIssuedImpl;

  factory TokenIssued.fromJson(Map<String, dynamic> jsonSerialization) {
    return TokenIssued(
      id: jsonSerialization['id'] as int?,
      tokenLetter: jsonSerialization['tokenLetter'] as String,
      tokenNumber: jsonSerialization['tokenNumber'] as int,
      statusName: jsonSerialization['statusName'] as String,
      statusCode: jsonSerialization['statusCode'] as int,
      statusAcronym: jsonSerialization['statusAcronym'] as String,
      isOnWait: jsonSerialization['isOnWait'] as bool,
      isOnQueue: jsonSerialization['isOnQueue'] as bool,
      isRecall: jsonSerialization['isRecall'] as bool,
      isCompleted: jsonSerialization['isCompleted'] as bool,
      reset: jsonSerialization['reset'] as bool,
      createdDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdDate']),
      assignedDate: jsonSerialization['assignedDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['assignedDate']),
      modifiedDate: jsonSerialization['modifiedDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['modifiedDate']),
      queueWindowId: jsonSerialization['queueWindowId'] as int,
      queueWindow: jsonSerialization['queueWindow'] == null
          ? null
          : _i2.QueueWindow.fromJson(
              (jsonSerialization['queueWindow'] as Map<String, dynamic>)),
      queueServiceId: jsonSerialization['queueServiceId'] as int,
      queueService: jsonSerialization['queueService'] == null
          ? null
          : _i3.QueueService.fromJson(
              (jsonSerialization['queueService'] as Map<String, dynamic>)),
      profileUserId: jsonSerialization['profileUserId'] as int,
      profileUser: jsonSerialization['profileUser'] == null
          ? null
          : _i4.ProfileUser.fromJson(
              (jsonSerialization['profileUser'] as Map<String, dynamic>)),
    );
  }

  static final t = TokenIssuedTable();

  static const db = TokenIssuedRepository._();

  @override
  int? id;

  String tokenLetter;

  int tokenNumber;

  String statusName;

  int statusCode;

  String statusAcronym;

  bool isOnWait;

  bool isOnQueue;

  bool isRecall;

  bool isCompleted;

  bool reset;

  DateTime createdDate;

  DateTime? assignedDate;

  DateTime? modifiedDate;

  int queueWindowId;

  _i2.QueueWindow? queueWindow;

  int queueServiceId;

  _i3.QueueService? queueService;

  int profileUserId;

  _i4.ProfileUser? profileUser;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TokenIssued]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TokenIssued copyWith({
    int? id,
    String? tokenLetter,
    int? tokenNumber,
    String? statusName,
    int? statusCode,
    String? statusAcronym,
    bool? isOnWait,
    bool? isOnQueue,
    bool? isRecall,
    bool? isCompleted,
    bool? reset,
    DateTime? createdDate,
    DateTime? assignedDate,
    DateTime? modifiedDate,
    int? queueWindowId,
    _i2.QueueWindow? queueWindow,
    int? queueServiceId,
    _i3.QueueService? queueService,
    int? profileUserId,
    _i4.ProfileUser? profileUser,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'tokenLetter': tokenLetter,
      'tokenNumber': tokenNumber,
      'statusName': statusName,
      'statusCode': statusCode,
      'statusAcronym': statusAcronym,
      'isOnWait': isOnWait,
      'isOnQueue': isOnQueue,
      'isRecall': isRecall,
      'isCompleted': isCompleted,
      'reset': reset,
      'createdDate': createdDate.toJson(),
      if (assignedDate != null) 'assignedDate': assignedDate?.toJson(),
      if (modifiedDate != null) 'modifiedDate': modifiedDate?.toJson(),
      'queueWindowId': queueWindowId,
      if (queueWindow != null) 'queueWindow': queueWindow?.toJson(),
      'queueServiceId': queueServiceId,
      if (queueService != null) 'queueService': queueService?.toJson(),
      'profileUserId': profileUserId,
      if (profileUser != null) 'profileUser': profileUser?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'tokenLetter': tokenLetter,
      'tokenNumber': tokenNumber,
      'statusName': statusName,
      'statusCode': statusCode,
      'statusAcronym': statusAcronym,
      'isOnWait': isOnWait,
      'isOnQueue': isOnQueue,
      'isRecall': isRecall,
      'isCompleted': isCompleted,
      'reset': reset,
      'createdDate': createdDate.toJson(),
      if (assignedDate != null) 'assignedDate': assignedDate?.toJson(),
      if (modifiedDate != null) 'modifiedDate': modifiedDate?.toJson(),
      'queueWindowId': queueWindowId,
      if (queueWindow != null) 'queueWindow': queueWindow?.toJsonForProtocol(),
      'queueServiceId': queueServiceId,
      if (queueService != null)
        'queueService': queueService?.toJsonForProtocol(),
      'profileUserId': profileUserId,
      if (profileUser != null) 'profileUser': profileUser?.toJsonForProtocol(),
    };
  }

  static TokenIssuedInclude include({
    _i2.QueueWindowInclude? queueWindow,
    _i3.QueueServiceInclude? queueService,
    _i4.ProfileUserInclude? profileUser,
  }) {
    return TokenIssuedInclude._(
      queueWindow: queueWindow,
      queueService: queueService,
      profileUser: profileUser,
    );
  }

  static TokenIssuedIncludeList includeList({
    _i1.WhereExpressionBuilder<TokenIssuedTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TokenIssuedTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TokenIssuedTable>? orderByList,
    TokenIssuedInclude? include,
  }) {
    return TokenIssuedIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TokenIssued.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TokenIssued.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TokenIssuedImpl extends TokenIssued {
  _TokenIssuedImpl({
    int? id,
    required String tokenLetter,
    required int tokenNumber,
    required String statusName,
    required int statusCode,
    required String statusAcronym,
    required bool isOnWait,
    required bool isOnQueue,
    required bool isRecall,
    required bool isCompleted,
    required bool reset,
    required DateTime createdDate,
    DateTime? assignedDate,
    DateTime? modifiedDate,
    required int queueWindowId,
    _i2.QueueWindow? queueWindow,
    required int queueServiceId,
    _i3.QueueService? queueService,
    required int profileUserId,
    _i4.ProfileUser? profileUser,
  }) : super._(
          id: id,
          tokenLetter: tokenLetter,
          tokenNumber: tokenNumber,
          statusName: statusName,
          statusCode: statusCode,
          statusAcronym: statusAcronym,
          isOnWait: isOnWait,
          isOnQueue: isOnQueue,
          isRecall: isRecall,
          isCompleted: isCompleted,
          reset: reset,
          createdDate: createdDate,
          assignedDate: assignedDate,
          modifiedDate: modifiedDate,
          queueWindowId: queueWindowId,
          queueWindow: queueWindow,
          queueServiceId: queueServiceId,
          queueService: queueService,
          profileUserId: profileUserId,
          profileUser: profileUser,
        );

  /// Returns a shallow copy of this [TokenIssued]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TokenIssued copyWith({
    Object? id = _Undefined,
    String? tokenLetter,
    int? tokenNumber,
    String? statusName,
    int? statusCode,
    String? statusAcronym,
    bool? isOnWait,
    bool? isOnQueue,
    bool? isRecall,
    bool? isCompleted,
    bool? reset,
    DateTime? createdDate,
    Object? assignedDate = _Undefined,
    Object? modifiedDate = _Undefined,
    int? queueWindowId,
    Object? queueWindow = _Undefined,
    int? queueServiceId,
    Object? queueService = _Undefined,
    int? profileUserId,
    Object? profileUser = _Undefined,
  }) {
    return TokenIssued(
      id: id is int? ? id : this.id,
      tokenLetter: tokenLetter ?? this.tokenLetter,
      tokenNumber: tokenNumber ?? this.tokenNumber,
      statusName: statusName ?? this.statusName,
      statusCode: statusCode ?? this.statusCode,
      statusAcronym: statusAcronym ?? this.statusAcronym,
      isOnWait: isOnWait ?? this.isOnWait,
      isOnQueue: isOnQueue ?? this.isOnQueue,
      isRecall: isRecall ?? this.isRecall,
      isCompleted: isCompleted ?? this.isCompleted,
      reset: reset ?? this.reset,
      createdDate: createdDate ?? this.createdDate,
      assignedDate:
          assignedDate is DateTime? ? assignedDate : this.assignedDate,
      modifiedDate:
          modifiedDate is DateTime? ? modifiedDate : this.modifiedDate,
      queueWindowId: queueWindowId ?? this.queueWindowId,
      queueWindow: queueWindow is _i2.QueueWindow?
          ? queueWindow
          : this.queueWindow?.copyWith(),
      queueServiceId: queueServiceId ?? this.queueServiceId,
      queueService: queueService is _i3.QueueService?
          ? queueService
          : this.queueService?.copyWith(),
      profileUserId: profileUserId ?? this.profileUserId,
      profileUser: profileUser is _i4.ProfileUser?
          ? profileUser
          : this.profileUser?.copyWith(),
    );
  }
}

class TokenIssuedTable extends _i1.Table<int?> {
  TokenIssuedTable({super.tableRelation}) : super(tableName: 'token_issued') {
    tokenLetter = _i1.ColumnString(
      'tokenLetter',
      this,
    );
    tokenNumber = _i1.ColumnInt(
      'tokenNumber',
      this,
    );
    statusName = _i1.ColumnString(
      'statusName',
      this,
    );
    statusCode = _i1.ColumnInt(
      'statusCode',
      this,
    );
    statusAcronym = _i1.ColumnString(
      'statusAcronym',
      this,
    );
    isOnWait = _i1.ColumnBool(
      'isOnWait',
      this,
    );
    isOnQueue = _i1.ColumnBool(
      'isOnQueue',
      this,
    );
    isRecall = _i1.ColumnBool(
      'isRecall',
      this,
    );
    isCompleted = _i1.ColumnBool(
      'isCompleted',
      this,
    );
    reset = _i1.ColumnBool(
      'reset',
      this,
    );
    createdDate = _i1.ColumnDateTime(
      'createdDate',
      this,
    );
    assignedDate = _i1.ColumnDateTime(
      'assignedDate',
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
    queueServiceId = _i1.ColumnInt(
      'queueServiceId',
      this,
    );
    profileUserId = _i1.ColumnInt(
      'profileUserId',
      this,
    );
  }

  late final _i1.ColumnString tokenLetter;

  late final _i1.ColumnInt tokenNumber;

  late final _i1.ColumnString statusName;

  late final _i1.ColumnInt statusCode;

  late final _i1.ColumnString statusAcronym;

  late final _i1.ColumnBool isOnWait;

  late final _i1.ColumnBool isOnQueue;

  late final _i1.ColumnBool isRecall;

  late final _i1.ColumnBool isCompleted;

  late final _i1.ColumnBool reset;

  late final _i1.ColumnDateTime createdDate;

  late final _i1.ColumnDateTime assignedDate;

  late final _i1.ColumnDateTime modifiedDate;

  late final _i1.ColumnInt queueWindowId;

  _i2.QueueWindowTable? _queueWindow;

  late final _i1.ColumnInt queueServiceId;

  _i3.QueueServiceTable? _queueService;

  late final _i1.ColumnInt profileUserId;

  _i4.ProfileUserTable? _profileUser;

  _i2.QueueWindowTable get queueWindow {
    if (_queueWindow != null) return _queueWindow!;
    _queueWindow = _i1.createRelationTable(
      relationFieldName: 'queueWindow',
      field: TokenIssued.t.queueWindowId,
      foreignField: _i2.QueueWindow.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.QueueWindowTable(tableRelation: foreignTableRelation),
    );
    return _queueWindow!;
  }

  _i3.QueueServiceTable get queueService {
    if (_queueService != null) return _queueService!;
    _queueService = _i1.createRelationTable(
      relationFieldName: 'queueService',
      field: TokenIssued.t.queueServiceId,
      foreignField: _i3.QueueService.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.QueueServiceTable(tableRelation: foreignTableRelation),
    );
    return _queueService!;
  }

  _i4.ProfileUserTable get profileUser {
    if (_profileUser != null) return _profileUser!;
    _profileUser = _i1.createRelationTable(
      relationFieldName: 'profileUser',
      field: TokenIssued.t.profileUserId,
      foreignField: _i4.ProfileUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.ProfileUserTable(tableRelation: foreignTableRelation),
    );
    return _profileUser!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        tokenLetter,
        tokenNumber,
        statusName,
        statusCode,
        statusAcronym,
        isOnWait,
        isOnQueue,
        isRecall,
        isCompleted,
        reset,
        createdDate,
        assignedDate,
        modifiedDate,
        queueWindowId,
        queueServiceId,
        profileUserId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'queueWindow') {
      return queueWindow;
    }
    if (relationField == 'queueService') {
      return queueService;
    }
    if (relationField == 'profileUser') {
      return profileUser;
    }
    return null;
  }
}

class TokenIssuedInclude extends _i1.IncludeObject {
  TokenIssuedInclude._({
    _i2.QueueWindowInclude? queueWindow,
    _i3.QueueServiceInclude? queueService,
    _i4.ProfileUserInclude? profileUser,
  }) {
    _queueWindow = queueWindow;
    _queueService = queueService;
    _profileUser = profileUser;
  }

  _i2.QueueWindowInclude? _queueWindow;

  _i3.QueueServiceInclude? _queueService;

  _i4.ProfileUserInclude? _profileUser;

  @override
  Map<String, _i1.Include?> get includes => {
        'queueWindow': _queueWindow,
        'queueService': _queueService,
        'profileUser': _profileUser,
      };

  @override
  _i1.Table<int?> get table => TokenIssued.t;
}

class TokenIssuedIncludeList extends _i1.IncludeList {
  TokenIssuedIncludeList._({
    _i1.WhereExpressionBuilder<TokenIssuedTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TokenIssued.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TokenIssued.t;
}

class TokenIssuedRepository {
  const TokenIssuedRepository._();

  final attachRow = const TokenIssuedAttachRowRepository._();

  /// Returns a list of [TokenIssued]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<TokenIssued>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TokenIssuedTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TokenIssuedTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TokenIssuedTable>? orderByList,
    _i1.Transaction? transaction,
    TokenIssuedInclude? include,
  }) async {
    return session.db.find<TokenIssued>(
      where: where?.call(TokenIssued.t),
      orderBy: orderBy?.call(TokenIssued.t),
      orderByList: orderByList?.call(TokenIssued.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [TokenIssued] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<TokenIssued?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TokenIssuedTable>? where,
    int? offset,
    _i1.OrderByBuilder<TokenIssuedTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TokenIssuedTable>? orderByList,
    _i1.Transaction? transaction,
    TokenIssuedInclude? include,
  }) async {
    return session.db.findFirstRow<TokenIssued>(
      where: where?.call(TokenIssued.t),
      orderBy: orderBy?.call(TokenIssued.t),
      orderByList: orderByList?.call(TokenIssued.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [TokenIssued] by its [id] or null if no such row exists.
  Future<TokenIssued?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    TokenIssuedInclude? include,
  }) async {
    return session.db.findById<TokenIssued>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [TokenIssued]s in the list and returns the inserted rows.
  ///
  /// The returned [TokenIssued]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<TokenIssued>> insert(
    _i1.Session session,
    List<TokenIssued> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<TokenIssued>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [TokenIssued] and returns the inserted row.
  ///
  /// The returned [TokenIssued] will have its `id` field set.
  Future<TokenIssued> insertRow(
    _i1.Session session,
    TokenIssued row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TokenIssued>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TokenIssued]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TokenIssued>> update(
    _i1.Session session,
    List<TokenIssued> rows, {
    _i1.ColumnSelections<TokenIssuedTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TokenIssued>(
      rows,
      columns: columns?.call(TokenIssued.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TokenIssued]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TokenIssued> updateRow(
    _i1.Session session,
    TokenIssued row, {
    _i1.ColumnSelections<TokenIssuedTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TokenIssued>(
      row,
      columns: columns?.call(TokenIssued.t),
      transaction: transaction,
    );
  }

  /// Deletes all [TokenIssued]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TokenIssued>> delete(
    _i1.Session session,
    List<TokenIssued> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TokenIssued>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TokenIssued].
  Future<TokenIssued> deleteRow(
    _i1.Session session,
    TokenIssued row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TokenIssued>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TokenIssued>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TokenIssuedTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TokenIssued>(
      where: where(TokenIssued.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TokenIssuedTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TokenIssued>(
      where: where?.call(TokenIssued.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class TokenIssuedAttachRowRepository {
  const TokenIssuedAttachRowRepository._();

  /// Creates a relation between the given [TokenIssued] and [QueueWindow]
  /// by setting the [TokenIssued]'s foreign key `queueWindowId` to refer to the [QueueWindow].
  Future<void> queueWindow(
    _i1.Session session,
    TokenIssued tokenIssued,
    _i2.QueueWindow queueWindow, {
    _i1.Transaction? transaction,
  }) async {
    if (tokenIssued.id == null) {
      throw ArgumentError.notNull('tokenIssued.id');
    }
    if (queueWindow.id == null) {
      throw ArgumentError.notNull('queueWindow.id');
    }

    var $tokenIssued = tokenIssued.copyWith(queueWindowId: queueWindow.id);
    await session.db.updateRow<TokenIssued>(
      $tokenIssued,
      columns: [TokenIssued.t.queueWindowId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TokenIssued] and [QueueService]
  /// by setting the [TokenIssued]'s foreign key `queueServiceId` to refer to the [QueueService].
  Future<void> queueService(
    _i1.Session session,
    TokenIssued tokenIssued,
    _i3.QueueService queueService, {
    _i1.Transaction? transaction,
  }) async {
    if (tokenIssued.id == null) {
      throw ArgumentError.notNull('tokenIssued.id');
    }
    if (queueService.id == null) {
      throw ArgumentError.notNull('queueService.id');
    }

    var $tokenIssued = tokenIssued.copyWith(queueServiceId: queueService.id);
    await session.db.updateRow<TokenIssued>(
      $tokenIssued,
      columns: [TokenIssued.t.queueServiceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TokenIssued] and [ProfileUser]
  /// by setting the [TokenIssued]'s foreign key `profileUserId` to refer to the [ProfileUser].
  Future<void> profileUser(
    _i1.Session session,
    TokenIssued tokenIssued,
    _i4.ProfileUser profileUser, {
    _i1.Transaction? transaction,
  }) async {
    if (tokenIssued.id == null) {
      throw ArgumentError.notNull('tokenIssued.id');
    }
    if (profileUser.id == null) {
      throw ArgumentError.notNull('profileUser.id');
    }

    var $tokenIssued = tokenIssued.copyWith(profileUserId: profileUser.id);
    await session.db.updateRow<TokenIssued>(
      $tokenIssued,
      columns: [TokenIssued.t.profileUserId],
      transaction: transaction,
    );
  }
}
