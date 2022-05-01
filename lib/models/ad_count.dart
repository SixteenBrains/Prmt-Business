import 'dart:convert';

import 'package:equatable/equatable.dart';

class AdCount extends Equatable {
  final int? liveAdCount;
  final int? promotedAdCount;
  final int? expiredAdCount;

  const AdCount({
    this.liveAdCount,
    this.promotedAdCount,
    this.expiredAdCount,
  });

  AdCount copyWith({
    int? liveAdCount,
    int? promotedAdCount,
    int? expiredAdCount,
  }) {
    return AdCount(
      liveAdCount: liveAdCount ?? this.liveAdCount,
      promotedAdCount: promotedAdCount ?? this.promotedAdCount,
      expiredAdCount: expiredAdCount ?? this.expiredAdCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'liveAdCount': liveAdCount,
      'promotedAdCount': promotedAdCount,
      'expiredAdCount': expiredAdCount,
    };
  }

  factory AdCount.fromMap(Map<String, dynamic> map) {
    return AdCount(
      liveAdCount: map['liveAdCount']?.toInt(),
      promotedAdCount: map['promotedAdCount']?.toInt(),
      expiredAdCount: map['expiredAdCount']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AdCount.fromJson(String source) =>
      AdCount.fromMap(json.decode(source));

  @override
  String toString() =>
      'AdCount(liveAdCount: $liveAdCount, promotedAdCount: $promotedAdCount, expiredAdCount: $expiredAdCount)';

  @override
  List<Object?> get props => [liveAdCount, promotedAdCount, expiredAdCount];
}
