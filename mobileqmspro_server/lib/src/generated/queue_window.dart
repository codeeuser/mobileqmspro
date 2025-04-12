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

abstract class QueueWindow
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  QueueWindow._({
    this.id,
    required this.name,
    required this.selected,
    required this.orderNum,
    required this.createdDate,
    this.modifiedDate,
    required this.profileUserId,
    this.profileUser,
  });

  factory QueueWindow({
    int? id,
    required String name,
    required bool selected,
    required int orderNum,
    required DateTime createdDate,
    DateTime? modifiedDate,
    required int profileUserId,
    _i2.ProfileUser? profileUser,
  }) = _QueueWindowImpl;

  factory QueueWindow.fromJson(Map<String, dynamic> jsonSerialization) {
    return QueueWindow(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      selected: jsonSerialization['selected'] as bool,
      orderNum: jsonSerialization['orderNum'] as int,
      createdDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdDate']),
      modifiedDate: jsonSerialization['modifiedDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['modifiedDate']),
      profileUserId: jsonSerialization['profileUserId'] as int,
      profileUser: jsonSerialization['profileUser'] == null
          ? null
          : _i2.ProfileUser.fromJson(
              (jsonSerialization['profileUser'] as Map<String, dynamic>)),
    );
  }

  static final t = QueueWindowTable();

  static const db = QueueWindowRepository._();

  @override
  int? id;

  String name;

  bool selected;

  int orderNum;

  DateTime createdDate;

  DateTime? modifiedDate;

  int profileUserId;

  _i2.ProfileUser? profileUser;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [QueueWindow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QueueWindow copyWith({
    int? id,
    String? name,
    bool? selected,
    int? orderNum,
    DateTime? createdDate,
    DateTime? modifiedDate,
    int? profileUserId,
    _i2.ProfileUser? profileUser,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'selected': selected,
      'orderNum': orderNum,
      'createdDate': createdDate.toJson(),
      if (modifiedDate != null) 'modifiedDate': modifiedDate?.toJson(),
      'profileUserId': profileUserId,
      if (profileUser != null) 'profileUser': profileUser?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'selected': selected,
      'orderNum': orderNum,
      'createdDate': createdDate.toJson(),
      if (modifiedDate != null) 'modifiedDate': modifiedDate?.toJson(),
      'profileUserId': profileUserId,
      if (profileUser != null) 'profileUser': profileUser?.toJsonForProtocol(),
    };
  }

  static QueueWindowInclude include({_i2.ProfileUserInclude? profileUser}) {
    return QueueWindowInclude._(profileUser: profileUser);
  }

  static QueueWindowIncludeList includeList({
    _i1.WhereExpressionBuilder<QueueWindowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QueueWindowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QueueWindowTable>? orderByList,
    QueueWindowInclude? include,
  }) {
    return QueueWindowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QueueWindow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(QueueWindow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QueueWindowImpl extends QueueWindow {
  _QueueWindowImpl({
    int? id,
    required String name,
    required bool selected,
    required int orderNum,
    required DateTime createdDate,
    DateTime? modifiedDate,
    required int profileUserId,
    _i2.ProfileUser? profileUser,
  }) : super._(
          id: id,
          name: name,
          selected: selected,
          orderNum: orderNum,
          createdDate: createdDate,
          modifiedDate: modifiedDate,
          profileUserId: profileUserId,
          profileUser: profileUser,
        );

  /// Returns a shallow copy of this [QueueWindow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QueueWindow copyWith({
    Object? id = _Undefined,
    String? name,
    bool? selected,
    int? orderNum,
    DateTime? createdDate,
    Object? modifiedDate = _Undefined,
    int? profileUserId,
    Object? profileUser = _Undefined,
  }) {
    return QueueWindow(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      selected: selected ?? this.selected,
      orderNum: orderNum ?? this.orderNum,
      createdDate: createdDate ?? this.createdDate,
      modifiedDate:
          modifiedDate is DateTime? ? modifiedDate : this.modifiedDate,
      profileUserId: profileUserId ?? this.profileUserId,
      profileUser: profileUser is _i2.ProfileUser?
          ? profileUser
          : this.profileUser?.copyWith(),
    );
  }
}

class QueueWindowTable extends _i1.Table<int> {
  QueueWindowTable({super.tableRelation}) : super(tableName: 'queue_window') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    selected = _i1.ColumnBool(
      'selected',
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
    profileUserId = _i1.ColumnInt(
      'profileUserId',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnBool selected;

  late final _i1.ColumnInt orderNum;

  late final _i1.ColumnDateTime createdDate;

  late final _i1.ColumnDateTime modifiedDate;

  late final _i1.ColumnInt profileUserId;

  _i2.ProfileUserTable? _profileUser;

  _i2.ProfileUserTable get profileUser {
    if (_profileUser != null) return _profileUser!;
    _profileUser = _i1.createRelationTable(
      relationFieldName: 'profileUser',
      field: QueueWindow.t.profileUserId,
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
        name,
        selected,
        orderNum,
        createdDate,
        modifiedDate,
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

class QueueWindowInclude extends _i1.IncludeObject {
  QueueWindowInclude._({_i2.ProfileUserInclude? profileUser}) {
    _profileUser = profileUser;
  }

  _i2.ProfileUserInclude? _profileUser;

  @override
  Map<String, _i1.Include?> get includes => {'profileUser': _profileUser};

  @override
  _i1.Table<int> get table => QueueWindow.t;
}

class QueueWindowIncludeList extends _i1.IncludeList {
  QueueWindowIncludeList._({
    _i1.WhereExpressionBuilder<QueueWindowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(QueueWindow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => QueueWindow.t;
}

class QueueWindowRepository {
  const QueueWindowRepository._();

  final attachRow = const QueueWindowAttachRowRepository._();

  /// Returns a list of [QueueWindow]s matching the given query parameters.
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
  Future<List<QueueWindow>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QueueWindowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QueueWindowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QueueWindowTable>? orderByList,
    _i1.Transaction? transaction,
    QueueWindowInclude? include,
  }) async {
    return session.db.find<QueueWindow>(
      where: where?.call(QueueWindow.t),
      orderBy: orderBy?.call(QueueWindow.t),
      orderByList: orderByList?.call(QueueWindow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [QueueWindow] matching the given query parameters.
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
  Future<QueueWindow?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QueueWindowTable>? where,
    int? offset,
    _i1.OrderByBuilder<QueueWindowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QueueWindowTable>? orderByList,
    _i1.Transaction? transaction,
    QueueWindowInclude? include,
  }) async {
    return session.db.findFirstRow<QueueWindow>(
      where: where?.call(QueueWindow.t),
      orderBy: orderBy?.call(QueueWindow.t),
      orderByList: orderByList?.call(QueueWindow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [QueueWindow] by its [id] or null if no such row exists.
  Future<QueueWindow?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    QueueWindowInclude? include,
  }) async {
    return session.db.findById<QueueWindow>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [QueueWindow]s in the list and returns the inserted rows.
  ///
  /// The returned [QueueWindow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<QueueWindow>> insert(
    _i1.Session session,
    List<QueueWindow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<QueueWindow>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [QueueWindow] and returns the inserted row.
  ///
  /// The returned [QueueWindow] will have its `id` field set.
  Future<QueueWindow> insertRow(
    _i1.Session session,
    QueueWindow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<QueueWindow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [QueueWindow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<QueueWindow>> update(
    _i1.Session session,
    List<QueueWindow> rows, {
    _i1.ColumnSelections<QueueWindowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<QueueWindow>(
      rows,
      columns: columns?.call(QueueWindow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [QueueWindow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<QueueWindow> updateRow(
    _i1.Session session,
    QueueWindow row, {
    _i1.ColumnSelections<QueueWindowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<QueueWindow>(
      row,
      columns: columns?.call(QueueWindow.t),
      transaction: transaction,
    );
  }

  /// Deletes all [QueueWindow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<QueueWindow>> delete(
    _i1.Session session,
    List<QueueWindow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<QueueWindow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [QueueWindow].
  Future<QueueWindow> deleteRow(
    _i1.Session session,
    QueueWindow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<QueueWindow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<QueueWindow>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<QueueWindowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<QueueWindow>(
      where: where(QueueWindow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QueueWindowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<QueueWindow>(
      where: where?.call(QueueWindow.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class QueueWindowAttachRowRepository {
  const QueueWindowAttachRowRepository._();

  /// Creates a relation between the given [QueueWindow] and [ProfileUser]
  /// by setting the [QueueWindow]'s foreign key `profileUserId` to refer to the [ProfileUser].
  Future<void> profileUser(
    _i1.Session session,
    QueueWindow queueWindow,
    _i2.ProfileUser profileUser, {
    _i1.Transaction? transaction,
  }) async {
    if (queueWindow.id == null) {
      throw ArgumentError.notNull('queueWindow.id');
    }
    if (profileUser.id == null) {
      throw ArgumentError.notNull('profileUser.id');
    }

    var $queueWindow = queueWindow.copyWith(profileUserId: profileUser.id);
    await session.db.updateRow<QueueWindow>(
      $queueWindow,
      columns: [QueueWindow.t.profileUserId],
      transaction: transaction,
    );
  }
}
