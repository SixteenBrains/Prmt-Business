import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/models/chart_data.dart';

class AdModel extends Equatable {
  final String? adName;
  final String? imageUrl;
  final int? budget;
  final int? availableBalance;
  final String? timeRemaining;

  final List<ChartData> clicksMetrics;
  final List<ChartData> convertsMetrics;
  final List<ChartData> spentsMetrics;
  final bool isNegative;
  const AdModel({
    this.adName,
    this.imageUrl,
    this.budget,
    this.availableBalance,
    this.timeRemaining,
    required this.clicksMetrics,
    required this.convertsMetrics,
    required this.spentsMetrics,
    this.isNegative = false,
  });

  AdModel copyWith({
    String? productName,
    String? imageUrl,
    int? budget,
    int? availableBalance,
    String? timeRemaining,
    List<ChartData>? clicksMetrics,
    List<ChartData>? convertsMetrics,
    List<ChartData>? spentsMetrics,
    bool? isNegative,
  }) {
    return AdModel(
      adName: productName ?? this.adName,
      imageUrl: imageUrl ?? this.imageUrl,
      budget: budget ?? this.budget,
      availableBalance: availableBalance ?? this.availableBalance,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      clicksMetrics: clicksMetrics ?? this.clicksMetrics,
      convertsMetrics: convertsMetrics ?? this.convertsMetrics,
      spentsMetrics: spentsMetrics ?? this.spentsMetrics,
      isNegative: isNegative ?? this.isNegative,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': adName,
      'imageUrl': imageUrl,
      'budget': budget,
      'availableBalance': availableBalance,
      'timeRemaining': timeRemaining,
      'clicksMetrics': clicksMetrics.map((x) => x.toMap()).toList(),
      'convertsMetrics': convertsMetrics.map((x) => x.toMap()).toList(),
      'spentsMetrics': spentsMetrics.map((x) => x.toMap()).toList(),
      'isNegative': isNegative,
    };
  }

  factory AdModel.fromMap(Map<String, dynamic> map) {
    return AdModel(
      adName: map['productName'],
      imageUrl: map['imageUrl'],
      budget: map['budget']?.toInt(),
      availableBalance: map['availableBalance']?.toInt(),
      timeRemaining: map['timeRemaining'],
      clicksMetrics: List<ChartData>.from(
          map['clicksMetrics']?.map((x) => ChartData.fromMap(x))),
      convertsMetrics: List<ChartData>.from(
          map['convertsMetrics']?.map((x) => ChartData.fromMap(x))),
      spentsMetrics: List<ChartData>.from(
          map['spentsMetrics']?.map((x) => ChartData.fromMap(x))),
      isNegative: map['isNegative'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdModel.fromJson(String source) =>
      AdModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Ad(productName: $adName, imageUrl: $imageUrl, budget: $budget, availableBalance: $availableBalance, timeRemaining: $timeRemaining,  clicksMetrics: $clicksMetrics, convertsMetrics: $convertsMetrics, spentsMetrics: $spentsMetrics, isNegative: $isNegative)';
  }

  @override
  List<Object?> get props {
    return [
      adName,
      imageUrl,
      budget,
      availableBalance,
      timeRemaining,
      clicksMetrics,
      convertsMetrics,
      spentsMetrics,
      isNegative,
    ];
  }
}
