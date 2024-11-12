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
import 'protocol.dart' as _i2;

abstract class ProfileUser implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
