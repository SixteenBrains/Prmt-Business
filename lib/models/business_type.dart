import 'dart:convert';

import 'package:equatable/equatable.dart';

class BusinessType extends Equatable {
  final String? type;

  const BusinessType({
    this.type,
  });

  BusinessType copyWith({
    String? type,
  }) {
    return BusinessType(
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
    };
  }

  factory BusinessType.fromMap(Map<String, dynamic> map) {
    return BusinessType(
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusinessType.fromJson(String source) =>
      BusinessType.fromMap(json.decode(source));

  @override
  String toString() => 'BusinessType(type: $type)';

  @override
  List<Object?> get props => [type];
}
