/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'queue_window.dart' as _i2;
import 'profile_user.dart' as _i3;

abstract class QueueService implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
