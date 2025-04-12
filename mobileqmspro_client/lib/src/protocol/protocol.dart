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
import 'count_token.dart' as _i2;
import 'log_login.dart' as _i3;
import 'membership_enum.dart' as _i4;
import 'profile_user.dart' as _i5;
import 'queue_service.dart' as _i6;
import 'queue_window.dart' as _i7;
import 'running_tokens.dart' as _i8;
import 'token_issued.dart' as _i9;
import 'package:mobileqmspro_client/src/protocol/log_login.dart' as _i10;
import 'package:mobileqmspro_client/src/protocol/queue_service.dart' as _i11;
import 'package:mobileqmspro_client/src/protocol/queue_window.dart' as _i12;
import 'package:mobileqmspro_client/src/protocol/token_issued.dart' as _i13;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i14;
export 'count_token.dart';
export 'log_login.dart';
export 'membership_enum.dart';
export 'profile_user.dart';
export 'queue_service.dart';
export 'queue_window.dart';
export 'running_tokens.dart';
export 'token_issued.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.CountToken) {
      return _i2.CountToken.fromJson(data) as T;
    }
    if (t == _i3.LogLogin) {
      return _i3.LogLogin.fromJson(data) as T;
    }
    if (t == _i4.Membership) {
      return _i4.Membership.fromJson(data) as T;
    }
    if (t == _i5.ProfileUser) {
      return _i5.ProfileUser.fromJson(data) as T;
    }
    if (t == _i6.QueueService) {
      return _i6.QueueService.fromJson(data) as T;
    }
    if (t == _i7.QueueWindow) {
      return _i7.QueueWindow.fromJson(data) as T;
    }
    if (t == _i8.RunningTokens) {
      return _i8.RunningTokens.fromJson(data) as T;
    }
    if (t == _i9.TokenIssued) {
      return _i9.TokenIssued.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.CountToken?>()) {
      return (data != null ? _i2.CountToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.LogLogin?>()) {
      return (data != null ? _i3.LogLogin.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Membership?>()) {
      return (data != null ? _i4.Membership.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.ProfileUser?>()) {
      return (data != null ? _i5.ProfileUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.QueueService?>()) {
      return (data != null ? _i6.QueueService.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.QueueWindow?>()) {
      return (data != null ? _i7.QueueWindow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.RunningTokens?>()) {
      return (data != null ? _i8.RunningTokens.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.TokenIssued?>()) {
      return (data != null ? _i9.TokenIssued.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i9.TokenIssued>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i9.TokenIssued>(e)).toList()
          : null) as T;
    }
    if (t == List<_i10.LogLogin>) {
      return (data as List).map((e) => deserialize<_i10.LogLogin>(e)).toList()
          as T;
    }
    if (t == List<_i11.QueueService>) {
      return (data as List)
          .map((e) => deserialize<_i11.QueueService>(e))
          .toList() as T;
    }
    if (t == List<_i12.QueueWindow>) {
      return (data as List)
          .map((e) => deserialize<_i12.QueueWindow>(e))
          .toList() as T;
    }
    if (t == List<_i13.TokenIssued>) {
      return (data as List)
          .map((e) => deserialize<_i13.TokenIssued>(e))
          .toList() as T;
    }
    try {
      return _i14.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.CountToken) {
      return 'CountToken';
    }
    if (data is _i3.LogLogin) {
      return 'LogLogin';
    }
    if (data is _i4.Membership) {
      return 'Membership';
    }
    if (data is _i5.ProfileUser) {
      return 'ProfileUser';
    }
    if (data is _i6.QueueService) {
      return 'QueueService';
    }
    if (data is _i7.QueueWindow) {
      return 'QueueWindow';
    }
    if (data is _i8.RunningTokens) {
      return 'RunningTokens';
    }
    if (data is _i9.TokenIssued) {
      return 'TokenIssued';
    }
    className = _i14.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'CountToken') {
      return deserialize<_i2.CountToken>(data['data']);
    }
    if (dataClassName == 'LogLogin') {
      return deserialize<_i3.LogLogin>(data['data']);
    }
    if (dataClassName == 'Membership') {
      return deserialize<_i4.Membership>(data['data']);
    }
    if (dataClassName == 'ProfileUser') {
      return deserialize<_i5.ProfileUser>(data['data']);
    }
    if (dataClassName == 'QueueService') {
      return deserialize<_i6.QueueService>(data['data']);
    }
    if (dataClassName == 'QueueWindow') {
      return deserialize<_i7.QueueWindow>(data['data']);
    }
    if (dataClassName == 'RunningTokens') {
      return deserialize<_i8.RunningTokens>(data['data']);
    }
    if (dataClassName == 'TokenIssued') {
      return deserialize<_i9.TokenIssued>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i14.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
