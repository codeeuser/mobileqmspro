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
import 'token_issued.dart' as _i2;

abstract class RunningTokens implements _i1.SerializableModel {
  RunningTokens._({this.tokens});

  factory RunningTokens({List<_i2.TokenIssued>? tokens}) = _RunningTokensImpl;

  factory RunningTokens.fromJson(Map<String, dynamic> jsonSerialization) {
    return RunningTokens(
        tokens: (jsonSerialization['tokens'] as List?)
            ?.map((e) => _i2.TokenIssued.fromJson((e as Map<String, dynamic>)))
            .toList());
  }

  List<_i2.TokenIssued>? tokens;

  /// Returns a shallow copy of this [RunningTokens]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RunningTokens copyWith({List<_i2.TokenIssued>? tokens});
  @override
  Map<String, dynamic> toJson() {
    return {
      if (tokens != null)
        'tokens': tokens?.toJson(valueToJson: (v) => v.toJson())
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RunningTokensImpl extends RunningTokens {
  _RunningTokensImpl({List<_i2.TokenIssued>? tokens}) : super._(tokens: tokens);

  /// Returns a shallow copy of this [RunningTokens]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RunningTokens copyWith({Object? tokens = _Undefined}) {
    return RunningTokens(
        tokens: tokens is List<_i2.TokenIssued>?
            ? tokens
            : this.tokens?.map((e0) => e0.copyWith()).toList());
  }
}
