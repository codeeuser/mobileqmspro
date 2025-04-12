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

abstract class LogLogin implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
