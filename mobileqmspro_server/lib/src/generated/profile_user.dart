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
import 'membership_enum.dart' as _i2;

abstract class ProfileUser implements _i1.TableRow, _i1.ProtocolSerialization {
  ProfileUser._({
    this.id,
    this.username,
    required this.email,
    this.phone,
    required this.passcode,
    this.verified,
    required this.membership,
    this.ipAddress,
    this.birthDate,
    this.gender,
    required this.createdDate,
    this.modifiedDate,
  });

  factory ProfileUser({
    int? id,
    String? username,
    required String email,
    String? phone,
    required String passcode,
    bool? verified,
    required _i2.Membership membership,
    String? ipAddress,
    DateTime? birthDate,
    String? gender,
    required DateTime createdDate,
    DateTime? modifiedDate,
  }) = _ProfileUserImpl;

  factory ProfileUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProfileUser(
      id: jsonSerialization['id'] as int?,
      username: jsonSerialization['username'] as String?,
      email: jsonSerialization['email'] as String,
      phone: jsonSerialization['phone'] as String?,
      passcode: jsonSerialization['passcode'] as String,
      verified: jsonSerialization['verified'] as bool?,
      membership:
          _i2.Membership.fromJson((jsonSerialization['membership'] as String)),
      ipAddress: jsonSerialization['ipAddress'] as String?,
      birthDate: jsonSerialization['birthDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['birthDate']),
      gender: jsonSerialization['gender'] as String?,
      createdDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdDate']),
      modifiedDate: jsonSerialization['modifiedDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['modifiedDate']),
    );
  }

  static final t = ProfileUserTable();

  static const db = ProfileUserRepository._();

  @override
  int? id;

  String? username;

  String email;

  String? phone;

  String passcode;

  bool? verified;

  _i2.Membership membership;

  String? ipAddress;

  DateTime? birthDate;

  String? gender;

  DateTime createdDate;

  DateTime? modifiedDate;

  @override
  _i1.Table get table => t;

  ProfileUser copyWith({
    int? id,
    String? username,
    String? email,
    String? phone,
    String? passcode,
    bool? verified,
    _i2.Membership? membership,
    String? ipAddress,
    DateTime? birthDate,
    String? gender,
    DateTime? createdDate,
    DateTime? modifiedDate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      'email': email,
      if (phone != null) 'phone': phone,
      'passcode': passcode,
      if (verified != null) 'verified': verified,
      'membership': membership.toJson(),
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (birthDate != null) 'birthDate': birthDate?.toJson(),
      if (gender != null) 'gender': gender,
      'createdDate': createdDate.toJson(),
      if (modifiedDate != null) 'modifiedDate': modifiedDate?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      'email': email,
      if (phone != null) 'phone': phone,
      'passcode': passcode,
      if (verified != null) 'verified': verified,
      'membership': membership.toJson(),
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (birthDate != null) 'birthDate': birthDate?.toJson(),
      if (gender != null) 'gender': gender,
      'createdDate': createdDate.toJson(),
      if (modifiedDate != null) 'modifiedDate': modifiedDate?.toJson(),
    };
  }

  static ProfileUserInclude include() {
    return ProfileUserInclude._();
  }

  static ProfileUserIncludeList includeList({
    _i1.WhereExpressionBuilder<ProfileUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProfileUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProfileUserTable>? orderByList,
    ProfileUserInclude? include,
  }) {
    return ProfileUserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProfileUser.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ProfileUser.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProfileUserImpl extends ProfileUser {
  _ProfileUserImpl({
    int? id,
    String? username,
    required String email,
    String? phone,
    required String passcode,
    bool? verified,
    required _i2.Membership membership,
    String? ipAddress,
    DateTime? birthDate,
    String? gender,
    required DateTime createdDate,
    DateTime? modifiedDate,
  }) : super._(
          id: id,
          username: username,
          email: email,
          phone: phone,
          passcode: passcode,
          verified: verified,
          membership: membership,
          ipAddress: ipAddress,
          birthDate: birthDate,
          gender: gender,
          createdDate: createdDate,
          modifiedDate: modifiedDate,
        );

  @override
  ProfileUser copyWith({
    Object? id = _Undefined,
    Object? username = _Undefined,
    String? email,
    Object? phone = _Undefined,
    String? passcode,
    Object? verified = _Undefined,
    _i2.Membership? membership,
    Object? ipAddress = _Undefined,
    Object? birthDate = _Undefined,
    Object? gender = _Undefined,
    DateTime? createdDate,
    Object? modifiedDate = _Undefined,
  }) {
    return ProfileUser(
      id: id is int? ? id : this.id,
      username: username is String? ? username : this.username,
      email: email ?? this.email,
      phone: phone is String? ? phone : this.phone,
      passcode: passcode ?? this.passcode,
      verified: verified is bool? ? verified : this.verified,
      membership: membership ?? this.membership,
      ipAddress: ipAddress is String? ? ipAddress : this.ipAddress,
      birthDate: birthDate is DateTime? ? birthDate : this.birthDate,
      gender: gender is String? ? gender : this.gender,
      createdDate: createdDate ?? this.createdDate,
      modifiedDate:
          modifiedDate is DateTime? ? modifiedDate : this.modifiedDate,
    );
  }
}

class ProfileUserTable extends _i1.Table {
  ProfileUserTable({super.tableRelation}) : super(tableName: 'profile_user') {
    username = _i1.ColumnString(
      'username',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    passcode = _i1.ColumnString(
      'passcode',
      this,
    );
    verified = _i1.ColumnBool(
      'verified',
      this,
    );
    membership = _i1.ColumnEnum(
      'membership',
      this,
      _i1.EnumSerialization.byName,
    );
    ipAddress = _i1.ColumnString(
      'ipAddress',
      this,
    );
    birthDate = _i1.ColumnDateTime(
      'birthDate',
      this,
    );
    gender = _i1.ColumnString(
      'gender',
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
  }

  late final _i1.ColumnString username;

  late final _i1.ColumnString email;

  late final _i1.ColumnString phone;

  late final _i1.ColumnString passcode;

  late final _i1.ColumnBool verified;

  late final _i1.ColumnEnum<_i2.Membership> membership;

  late final _i1.ColumnString ipAddress;

  late final _i1.ColumnDateTime birthDate;

  late final _i1.ColumnString gender;

  late final _i1.ColumnDateTime createdDate;

  late final _i1.ColumnDateTime modifiedDate;

  @override
  List<_i1.Column> get columns => [
        id,
        username,
        email,
        phone,
        passcode,
        verified,
        membership,
        ipAddress,
        birthDate,
        gender,
        createdDate,
        modifiedDate,
      ];
}

class ProfileUserInclude extends _i1.IncludeObject {
  ProfileUserInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => ProfileUser.t;
}

class ProfileUserIncludeList extends _i1.IncludeList {
  ProfileUserIncludeList._({
    _i1.WhereExpressionBuilder<ProfileUserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProfileUser.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => ProfileUser.t;
}

class ProfileUserRepository {
  const ProfileUserRepository._();

  Future<List<ProfileUser>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProfileUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProfileUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProfileUserTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ProfileUser>(
      where: where?.call(ProfileUser.t),
      orderBy: orderBy?.call(ProfileUser.t),
      orderByList: orderByList?.call(ProfileUser.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<ProfileUser?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProfileUserTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProfileUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProfileUserTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ProfileUser>(
      where: where?.call(ProfileUser.t),
      orderBy: orderBy?.call(ProfileUser.t),
      orderByList: orderByList?.call(ProfileUser.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<ProfileUser?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ProfileUser>(
      id,
      transaction: transaction,
    );
  }

  Future<List<ProfileUser>> insert(
    _i1.Session session,
    List<ProfileUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ProfileUser>(
      rows,
      transaction: transaction,
    );
  }

  Future<ProfileUser> insertRow(
    _i1.Session session,
    ProfileUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProfileUser>(
      row,
      transaction: transaction,
    );
  }

  Future<List<ProfileUser>> update(
    _i1.Session session,
    List<ProfileUser> rows, {
    _i1.ColumnSelections<ProfileUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ProfileUser>(
      rows,
      columns: columns?.call(ProfileUser.t),
      transaction: transaction,
    );
  }

  Future<ProfileUser> updateRow(
    _i1.Session session,
    ProfileUser row, {
    _i1.ColumnSelections<ProfileUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProfileUser>(
      row,
      columns: columns?.call(ProfileUser.t),
      transaction: transaction,
    );
  }

  Future<List<ProfileUser>> delete(
    _i1.Session session,
    List<ProfileUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ProfileUser>(
      rows,
      transaction: transaction,
    );
  }

  Future<ProfileUser> deleteRow(
    _i1.Session session,
    ProfileUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProfileUser>(
      row,
      transaction: transaction,
    );
  }

  Future<List<ProfileUser>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ProfileUserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ProfileUser>(
      where: where(ProfileUser.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProfileUserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ProfileUser>(
      where: where?.call(ProfileUser.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
