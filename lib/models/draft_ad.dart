import 'dart:convert';

import 'package:equatable/equatable.dart';

class DraftAd extends Equatable {
  final String? productName;
  final String? remainingTime;
  final bool isNegative;
  final String? imageUrl;
  const DraftAd({
    this.productName,
    this.remainingTime,
    this.isNegative = false,
    this.imageUrl,
  });

  DraftAd copyWith({
    String? productName,
    String? remainingTime,
    bool? isNegative,
    String? imageUrl,
  }) {
    return DraftAd(
      productName: productName ?? this.productName,
      remainingTime: remainingTime ?? this.remainingTime,
      isNegative: isNegative ?? this.isNegative,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'remainingTime': remainingTime,
      'isNegative': isNegative,
      'imageUrl': imageUrl,
    };
  }

  factory DraftAd.fromMap(Map<String, dynamic> map) {
    return DraftAd(
      productName: map['productName'],
      remainingTime: map['remainingTime'],
      isNegative: map['isNegative'] ?? false,
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DraftAd.fromJson(String source) =>
      DraftAd.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DraftAd(productName: $productName, remainingTime: $remainingTime, isNegative: $isNegative, imageUrl: $imageUrl)';
  }

  @override
  List<Object?> get props => [productName, remainingTime, isNegative, imageUrl];
}
