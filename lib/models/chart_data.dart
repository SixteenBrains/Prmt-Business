import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ChartData extends Equatable {
  final double count;
  final Color color;
  const ChartData({
    required this.count,
    required this.color,
  });

  ChartData copyWith({
    double? count,
    Color? color,
  }) {
    return ChartData(
      count: count ?? this.count,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'color': color.value,
    };
  }

  factory ChartData.fromMap(Map<String, dynamic> map) {
    return ChartData(
      count: map['count']?.toDouble() ?? 0.0,
      color: Color(map['color']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChartData.fromJson(String source) =>
      ChartData.fromMap(json.decode(source));

  @override
  String toString() => 'ChartData(count: $count, color: $color)';

  @override
  List<Object> get props => [count, color];
}
