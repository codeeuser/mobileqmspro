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

abstract class CountToken implements _i1.SerializableModel {
  CountToken._({
    required this.countIsQueue,
    required this.countWait,
  });

  factory CountToken({
    required int countIsQueue,
    required int countWait,
  }) = _CountTokenImpl;

  factory CountToken.fromJson(Map<String, dynamic> jsonSerialization) {
    return CountToken(
      countIsQueue: jsonSerialization['countIsQueue'] as int,
      countWait: jsonSerialization['countWait'] as int,
    );
  }

  int countIsQueue;

  int countWait;

  CountToken copyWith({
    int? countIsQueue,
    int? countWait,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'countIsQueue': countIsQueue,
      'countWait': countWait,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CountTokenImpl extends CountToken {
  _CountTokenImpl({
    required int countIsQueue,
    required int countWait,
  }) : super._(
          countIsQueue: countIsQueue,
          countWait: countWait,
        );

  @override
  CountToken copyWith({
    int? countIsQueue,
    int? countWait,
  }) {
    return CountToken(
      countIsQueue: countIsQueue ?? this.countIsQueue,
      countWait: countWait ?? this.countWait,
    );
  }
}
