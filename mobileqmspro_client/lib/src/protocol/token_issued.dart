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
import 'queue_service.dart' as _i3;
import 'profile_user.dart' as _i4;

abstract class TokenIssued implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
