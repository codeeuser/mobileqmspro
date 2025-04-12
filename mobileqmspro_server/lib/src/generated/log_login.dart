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
import 'profile_user.dart' as _i2;

abstract class LogLogin
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  LogLogin._({
    this.id,
    this.msgToken,
    this.platform,
    this.deviceName,
    this.deviceOs,
    this.deviceRelease,
    this.appVersion,
    this.appVersionCode,
    required this.createdDate,
    required this.profileUserId,
    this.profileUser,
  });

  factory LogLogin({
    int? id,
    String? msgToken,
    String? platform,
    String? deviceName,
    String? deviceOs,
    String? deviceRelease,
    String? appVersion,
    String? appVersionCode,
    required DateTime createdDate,
    required int profileUserId,
    _i2.ProfileUser? profileUser,
  }) = _LogLoginImpl;

  factory LogLogin.fromJson(Map<String, dynamic> jsonSerialization) {
    return LogLogin(
      id: jsonSerialization['id'] as int?,
      msgToken: jsonSerialization['msgToken'] as String?,
      platform: jsonSerialization['platform'] as String?,
      deviceName: jsonSerialization['deviceName'] as String?,
      deviceOs: jsonSerialization['deviceOs'] as String?,
      deviceRelease: jsonSerialization['deviceRelease'] as String?,
      appVersion: jsonSerialization['appVersion'] as String?,
      appVersionCode: jsonSerialization['appVersionCode'] as String?,
      createdDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdDate']),
      profileUserId: jsonSerialization['profileUserId'] as int,
      profileUser: jsonSerialization['profileUser'] == null
          ? null
          : _i2.ProfileUser.fromJson(
              (jsonSerialization['profileUser'] as Map<String, dynamic>)),
    );
  }

  static final t = LogLoginTable();

  static const db = LogLoginRepository._();

  @override
  int? id;

  String? msgToken;

  String? platform;

  String? deviceName;

  String? deviceOs;

  String? deviceRelease;

  String? appVersion;

  String? appVersionCode;

  DateTime createdDate;

  int profileUserId;

  _i2.ProfileUser? profileUser;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [LogLogin]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LogLogin copyWith({
    int? id,
    String? msgToken,
    String? platform,
    String? deviceName,
    String? deviceOs,
    String? deviceRelease,
    String? appVersion,
    String? appVersionCode,
    DateTime? createdDate,
    int? profileUserId,
    _i2.ProfileUser? profileUser,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (msgToken != null) 'msgToken': msgToken,
      if (platform != null) 'platform': platform,
      if (deviceName != null) 'deviceName': deviceName,
      if (deviceOs != null) 'deviceOs': deviceOs,
      if (deviceRelease != null) 'deviceRelease': deviceRelease,
      if (appVersion != null) 'appVersion': appVersion,
      if (appVersionCode != null) 'appVersionCode': appVersionCode,
      'createdDate': createdDate.toJson(),
      'profileUserId': profileUserId,
      if (profileUser != null) 'profileUser': profileUser?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (msgToken != null) 'msgToken': msgToken,
      if (platform != null) 'platform': platform,
      if (deviceName != null) 'deviceName': deviceName,
      if (deviceOs != null) 'deviceOs': deviceOs,
      if (deviceRelease != null) 'deviceRelease': deviceRelease,
      if (appVersion != null) 'appVersion': appVersion,
      if (appVersionCode != null) 'appVersionCode': appVersionCode,
      'createdDate': createdDate.toJson(),
      'profileUserId': profileUserId,
      if (profileUser != null) 'profileUser': profileUser?.toJsonForProtocol(),
    };
  }

  static LogLoginInclude include({_i2.ProfileUserInclude? profileUser}) {
    return LogLoginInclude._(profileUser: profileUser);
  }

  static LogLoginIncludeList includeList({
    _i1.WhereExpressionBuilder<LogLoginTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LogLoginTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LogLoginTable>? orderByList,
    LogLoginInclude? include,
  }) {
    return LogLoginIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LogLogin.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LogLogin.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LogLoginImpl extends LogLogin {
  _LogLoginImpl({
    int? id,
    String? msgToken,
    String? platform,
    String? deviceName,
    String? deviceOs,
    String? deviceRelease,
    String? appVersion,
    String? appVersionCode,
    required DateTime createdDate,
    required int profileUserId,
    _i2.ProfileUser? profileUser,
  }) : super._(
          id: id,
          msgToken: msgToken,
          platform: platform,
          deviceName: deviceName,
          deviceOs: deviceOs,
          deviceRelease: deviceRelease,
          appVersion: appVersion,
          appVersionCode: appVersionCode,
          createdDate: createdDate,
          profileUserId: profileUserId,
          profileUser: profileUser,
        );

  /// Returns a shallow copy of this [LogLogin]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LogLogin copyWith({
    Object? id = _Undefined,
    Object? msgToken = _Undefined,
    Object? platform = _Undefined,
    Object? deviceName = _Undefined,
    Object? deviceOs = _Undefined,
    Object? deviceRelease = _Undefined,
    Object? appVersion = _Undefined,
    Object? appVersionCode = _Undefined,
    DateTime? createdDate,
    int? profileUserId,
    Object? profileUser = _Undefined,
  }) {
    return LogLogin(
      id: id is int? ? id : this.id,
      msgToken: msgToken is String? ? msgToken : this.msgToken,
      platform: platform is String? ? platform : this.platform,
      deviceName: deviceName is String? ? deviceName : this.deviceName,
      deviceOs: deviceOs is String? ? deviceOs : this.deviceOs,
      deviceRelease:
          deviceRelease is String? ? deviceRelease : this.deviceRelease,
      appVersion: appVersion is String? ? appVersion : this.appVersion,
      appVersionCode:
          appVersionCode is String? ? appVersionCode : this.appVersionCode,
      createdDate: createdDate ?? this.createdDate,
      profileUserId: profileUserId ?? this.profileUserId,
      profileUser: profileUser is _i2.ProfileUser?
          ? profileUser
          : this.profileUser?.copyWith(),
    );
  }
}

class LogLoginTable extends _i1.Table<int> {
  LogLoginTable({super.tableRelation}) : super(tableName: 'log_login') {
    msgToken = _i1.ColumnString(
      'msgToken',
      this,
    );
    platform = _i1.ColumnString(
      'platform',
      this,
    );
    deviceName = _i1.ColumnString(
      'deviceName',
      this,
    );
    deviceOs = _i1.ColumnString(
      'deviceOs',
      this,
    );
    deviceRelease = _i1.ColumnString(
      'deviceRelease',
      this,
    );
    appVersion = _i1.ColumnString(
      'appVersion',
      this,
    );
    appVersionCode = _i1.ColumnString(
      'appVersionCode',
      this,
    );
    createdDate = _i1.ColumnDateTime(
      'createdDate',
      this,
    );
    profileUserId = _i1.ColumnInt(
      'profileUserId',
      this,
    );
  }

  late final _i1.ColumnString msgToken;

  late final _i1.ColumnString platform;

  late final _i1.ColumnString deviceName;

  late final _i1.ColumnString deviceOs;

  late final _i1.ColumnString deviceRelease;

  late final _i1.ColumnString appVersion;

  late final _i1.ColumnString appVersionCode;

  late final _i1.ColumnDateTime createdDate;

  late final _i1.ColumnInt profileUserId;

  _i2.ProfileUserTable? _profileUser;

  _i2.ProfileUserTable get profileUser {
    if (_profileUser != null) return _profileUser!;
    _profileUser = _i1.createRelationTable(
      relationFieldName: 'profileUser',
      field: LogLogin.t.profileUserId,
      foreignField: _i2.ProfileUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ProfileUserTable(tableRelation: foreignTableRelation),
    );
    return _profileUser!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        msgToken,
        platform,
        deviceName,
        deviceOs,
        deviceRelease,
        appVersion,
        appVersionCode,
        createdDate,
        profileUserId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'profileUser') {
      return profileUser;
    }
    return null;
  }
}

class LogLoginInclude extends _i1.IncludeObject {
  LogLoginInclude._({_i2.ProfileUserInclude? profileUser}) {
    _profileUser = profileUser;
  }

  _i2.ProfileUserInclude? _profileUser;

  @override
  Map<String, _i1.Include?> get includes => {'profileUser': _profileUser};

  @override
  _i1.Table<int> get table => LogLogin.t;
}

class LogLoginIncludeList extends _i1.IncludeList {
  LogLoginIncludeList._({
    _i1.WhereExpressionBuilder<LogLoginTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LogLogin.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => LogLogin.t;
}

class LogLoginRepository {
  const LogLoginRepository._();

  final attachRow = const LogLoginAttachRowRepository._();

  /// Returns a list of [LogLogin]s matching the given query parameters.
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
  Future<List<LogLogin>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LogLoginTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LogLoginTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LogLoginTable>? orderByList,
    _i1.Transaction? transaction,
    LogLoginInclude? include,
  }) async {
    return session.db.find<LogLogin>(
      where: where?.call(LogLogin.t),
      orderBy: orderBy?.call(LogLogin.t),
      orderByList: orderByList?.call(LogLogin.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [LogLogin] matching the given query parameters.
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
  Future<LogLogin?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LogLoginTable>? where,
    int? offset,
    _i1.OrderByBuilder<LogLoginTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LogLoginTable>? orderByList,
    _i1.Transaction? transaction,
    LogLoginInclude? include,
  }) async {
    return session.db.findFirstRow<LogLogin>(
      where: where?.call(LogLogin.t),
      orderBy: orderBy?.call(LogLogin.t),
      orderByList: orderByList?.call(LogLogin.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [LogLogin] by its [id] or null if no such row exists.
  Future<LogLogin?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    LogLoginInclude? include,
  }) async {
    return session.db.findById<LogLogin>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [LogLogin]s in the list and returns the inserted rows.
  ///
  /// The returned [LogLogin]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<LogLogin>> insert(
    _i1.Session session,
    List<LogLogin> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<LogLogin>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [LogLogin] and returns the inserted row.
  ///
  /// The returned [LogLogin] will have its `id` field set.
  Future<LogLogin> insertRow(
    _i1.Session session,
    LogLogin row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LogLogin>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LogLogin]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LogLogin>> update(
    _i1.Session session,
    List<LogLogin> rows, {
    _i1.ColumnSelections<LogLoginTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LogLogin>(
      rows,
      columns: columns?.call(LogLogin.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LogLogin]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LogLogin> updateRow(
    _i1.Session session,
    LogLogin row, {
    _i1.ColumnSelections<LogLoginTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LogLogin>(
      row,
      columns: columns?.call(LogLogin.t),
      transaction: transaction,
    );
  }

  /// Deletes all [LogLogin]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LogLogin>> delete(
    _i1.Session session,
    List<LogLogin> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LogLogin>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LogLogin].
  Future<LogLogin> deleteRow(
    _i1.Session session,
    LogLogin row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LogLogin>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LogLogin>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LogLoginTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LogLogin>(
      where: where(LogLogin.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LogLoginTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LogLogin>(
      where: where?.call(LogLogin.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class LogLoginAttachRowRepository {
  const LogLoginAttachRowRepository._();

  /// Creates a relation between the given [LogLogin] and [ProfileUser]
  /// by setting the [LogLogin]'s foreign key `profileUserId` to refer to the [ProfileUser].
  Future<void> profileUser(
    _i1.Session session,
    LogLogin logLogin,
    _i2.ProfileUser profileUser, {
    _i1.Transaction? transaction,
  }) async {
    if (logLogin.id == null) {
      throw ArgumentError.notNull('logLogin.id');
    }
    if (profileUser.id == null) {
      throw ArgumentError.notNull('profileUser.id');
    }

    var $logLogin = logLogin.copyWith(profileUserId: profileUser.id);
    await session.db.updateRow<LogLogin>(
      $logLogin,
      columns: [LogLogin.t.profileUserId],
      transaction: transaction,
    );
  }
}
