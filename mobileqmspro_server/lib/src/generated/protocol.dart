/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'count_token.dart' as _i3;
import 'log_login.dart' as _i4;
import 'membership_enum.dart' as _i5;
import 'profile_user.dart' as _i6;
import 'queue_service.dart' as _i7;
import 'queue_window.dart' as _i8;
import 'running_tokens.dart' as _i9;
import 'token_issued.dart' as _i10;
import 'protocol.dart' as _i11;
import 'package:mobileqmspro_server/src/generated/log_login.dart' as _i12;
import 'package:mobileqmspro_server/src/generated/queue_service.dart' as _i13;
import 'package:mobileqmspro_server/src/generated/queue_window.dart' as _i14;
import 'package:mobileqmspro_server/src/generated/token_issued.dart' as _i15;
export 'count_token.dart';
export 'log_login.dart';
export 'membership_enum.dart';
export 'profile_user.dart';
export 'queue_service.dart';
export 'queue_window.dart';
export 'running_tokens.dart';
export 'token_issued.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'log_login',
      dartName: 'LogLogin',
      schema: 'public',
      module: 'mobileqmspro',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'log_login_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'msgToken',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'platform',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'deviceName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'deviceOs',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'deviceRelease',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'appVersion',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'appVersionCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'profileUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'log_login_fk_0',
          columns: ['profileUserId'],
          referenceTable: 'profile_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'log_login_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'profile_user',
      dartName: 'ProfileUser',
      schema: 'public',
      module: 'mobileqmspro',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'profile_user_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'username',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'phone',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'passcode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'verified',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'membership',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Membership',
        ),
        _i2.ColumnDefinition(
          name: 'ipAddress',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'birthDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'gender',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'modifiedDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'profile_user_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'queue_service',
      dartName: 'QueueService',
      schema: 'public',
      module: 'mobileqmspro',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'queue_service_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'letter',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'start',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'enable',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'orderNum',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'modifiedDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'queueWindowId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'profileUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'queue_service_fk_0',
          columns: ['queueWindowId'],
          referenceTable: 'queue_window',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'queue_service_fk_1',
          columns: ['profileUserId'],
          referenceTable: 'profile_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'queue_service_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'queue_window',
      dartName: 'QueueWindow',
      schema: 'public',
      module: 'mobileqmspro',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'queue_window_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'selected',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'orderNum',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'modifiedDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'profileUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'queue_window_fk_0',
          columns: ['profileUserId'],
          referenceTable: 'profile_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'queue_window_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'token_issued',
      dartName: 'TokenIssued',
      schema: 'public',
      module: 'mobileqmspro',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'token_issued_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'tokenLetter',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'tokenNumber',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'statusName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'statusCode',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'statusAcronym',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isOnWait',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'isOnQueue',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'isRecall',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'isCompleted',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'reset',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'createdDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'assignedDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'modifiedDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'queueWindowId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'queueServiceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'profileUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'token_issued_fk_0',
          columns: ['queueWindowId'],
          referenceTable: 'queue_window',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'token_issued_fk_1',
          columns: ['queueServiceId'],
          referenceTable: 'queue_service',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'token_issued_fk_2',
          columns: ['profileUserId'],
          referenceTable: 'profile_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'token_issued_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    ..._i2.Protocol.targetTableDefinitions,
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i3.CountToken) {
      return _i3.CountToken.fromJson(data) as T;
    }
    if (t == _i4.LogLogin) {
      return _i4.LogLogin.fromJson(data) as T;
    }
    if (t == _i5.Membership) {
      return _i5.Membership.fromJson(data) as T;
    }
    if (t == _i6.ProfileUser) {
      return _i6.ProfileUser.fromJson(data) as T;
    }
    if (t == _i7.QueueService) {
      return _i7.QueueService.fromJson(data) as T;
    }
    if (t == _i8.QueueWindow) {
      return _i8.QueueWindow.fromJson(data) as T;
    }
    if (t == _i9.RunningTokens) {
      return _i9.RunningTokens.fromJson(data) as T;
    }
    if (t == _i10.TokenIssued) {
      return _i10.TokenIssued.fromJson(data) as T;
    }
    if (t == _i1.getType<_i3.CountToken?>()) {
      return (data != null ? _i3.CountToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.LogLogin?>()) {
      return (data != null ? _i4.LogLogin.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Membership?>()) {
      return (data != null ? _i5.Membership.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ProfileUser?>()) {
      return (data != null ? _i6.ProfileUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.QueueService?>()) {
      return (data != null ? _i7.QueueService.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.QueueWindow?>()) {
      return (data != null ? _i8.QueueWindow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.RunningTokens?>()) {
      return (data != null ? _i9.RunningTokens.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.TokenIssued?>()) {
      return (data != null ? _i10.TokenIssued.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i11.TokenIssued>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i11.TokenIssued>(e)).toList()
          : null) as dynamic;
    }
    if (t == List<_i12.LogLogin>) {
      return (data as List).map((e) => deserialize<_i12.LogLogin>(e)).toList()
          as dynamic;
    }
    if (t == List<_i13.QueueService>) {
      return (data as List)
          .map((e) => deserialize<_i13.QueueService>(e))
          .toList() as dynamic;
    }
    if (t == List<_i14.QueueWindow>) {
      return (data as List)
          .map((e) => deserialize<_i14.QueueWindow>(e))
          .toList() as dynamic;
    }
    if (t == List<_i15.TokenIssued>) {
      return (data as List)
          .map((e) => deserialize<_i15.TokenIssued>(e))
          .toList() as dynamic;
    }
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i3.CountToken) {
      return 'CountToken';
    }
    if (data is _i4.LogLogin) {
      return 'LogLogin';
    }
    if (data is _i5.Membership) {
      return 'Membership';
    }
    if (data is _i6.ProfileUser) {
      return 'ProfileUser';
    }
    if (data is _i7.QueueService) {
      return 'QueueService';
    }
    if (data is _i8.QueueWindow) {
      return 'QueueWindow';
    }
    if (data is _i9.RunningTokens) {
      return 'RunningTokens';
    }
    if (data is _i10.TokenIssued) {
      return 'TokenIssued';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'] == 'CountToken') {
      return deserialize<_i3.CountToken>(data['data']);
    }
    if (data['className'] == 'LogLogin') {
      return deserialize<_i4.LogLogin>(data['data']);
    }
    if (data['className'] == 'Membership') {
      return deserialize<_i5.Membership>(data['data']);
    }
    if (data['className'] == 'ProfileUser') {
      return deserialize<_i6.ProfileUser>(data['data']);
    }
    if (data['className'] == 'QueueService') {
      return deserialize<_i7.QueueService>(data['data']);
    }
    if (data['className'] == 'QueueWindow') {
      return deserialize<_i8.QueueWindow>(data['data']);
    }
    if (data['className'] == 'RunningTokens') {
      return deserialize<_i9.RunningTokens>(data['data']);
    }
    if (data['className'] == 'TokenIssued') {
      return deserialize<_i10.TokenIssued>(data['data']);
    }
    if (data['className'].startsWith('serverpod.')) {
      data['className'] = data['className'].substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i4.LogLogin:
        return _i4.LogLogin.t;
      case _i6.ProfileUser:
        return _i6.ProfileUser.t;
      case _i7.QueueService:
        return _i7.QueueService.t;
      case _i8.QueueWindow:
        return _i8.QueueWindow.t;
      case _i10.TokenIssued:
        return _i10.TokenIssued.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'mobileqmspro';
}
