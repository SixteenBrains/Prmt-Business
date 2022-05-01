import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PaymentDetails extends Equatable {
  final String? productTitle;
  final String paymentId;
  final int amount;
  final DateTime? createdAt;

  const PaymentDetails({
    required this.paymentId,
    required this.amount,
    this.createdAt,
    this.productTitle,
  });

  PaymentDetails copyWith({
    String? paymentId,
    int? amount,
    DateTime? createdAt,
    String? productTitle,
  }) {
    return PaymentDetails(
      paymentId: paymentId ?? this.paymentId,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
      productTitle: productTitle ?? this.productTitle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'paymentId': paymentId,
      'amount': amount,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'productTitle': productTitle,
    };
  }

  factory PaymentDetails.fromMap(Map<String, dynamic> map) {
    return PaymentDetails(
      paymentId: map['adId'] ?? '',
      amount: map['amount']?.toInt() ?? 0,
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      productTitle: map['productTitle'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentDetails.fromJson(String source) =>
      PaymentDetails.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaymentDetails(paymentId: $paymentId, amount: $amount, createdAt: $createdAt, productTitle: $productTitle)';

  @override
  List<Object?> get props => [paymentId, amount, createdAt, productTitle];
}
