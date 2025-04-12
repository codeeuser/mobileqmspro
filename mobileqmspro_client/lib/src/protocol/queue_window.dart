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
import 'profile_user.dart' as _i2;

abstract class QueueWindow implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  bool selected;

  int orderNum;

  DateTime createdDate;

  DateTime? modifiedDate;

  int profileUserId;

  _i2.ProfileUser? profileUser;

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
