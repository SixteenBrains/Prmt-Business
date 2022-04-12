import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PaymentDetails extends Equatable {
  final String? adId;
  final DateTime? createdAt;
  final int? amount;

  const PaymentDetails({
    this.adId,
    this.createdAt,
    this.amount,
  });

  PaymentDetails copyWith({
    String? adId,
    DateTime? createdAt,
    int? amount,
  }) {
    return PaymentDetails(
      adId: adId ?? this.adId,
      createdAt: createdAt ?? this.createdAt,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'adId': adId,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'amount': amount,
    };
  }

  factory PaymentDetails.fromMap(Map<String, dynamic> map) {
    return PaymentDetails(
      adId: map['adId'],
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      amount: map['amount']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentDetails.fromJson(String source) =>
      PaymentDetails.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaymentDetals(adId: $adId, createdAt: $createdAt, amount: $amount)';

  @override
  List<Object?> get props => [adId, createdAt, amount];
}







// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';

// import '/models/appuser.dart';

// class PaymentDetails extends Equatable {
//   final AppUser? author;
//   final int? amount;
//   final DateTime? createdAt;

//   const PaymentDetails({
//     this.author,
//     this.amount,
//     this.createdAt,
//   });

//   PaymentDetails copyWith({
//     AppUser? author,
//     int? amount,
//     DateTime? createdAt,
//   }) {
//     return PaymentDetails(
//       author: author ?? this.author,
//       amount: amount ?? this.amount,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'author': author?.toMap(),
//       'amount': amount,
//       'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
//     };
//   }

//   factory PaymentDetails.fromMap(Map<String, dynamic> map) {
//     return PaymentDetails(
//       author: map['author'] != null ? AppUser.fromMap(map['author']) : null,
//       amount: map['amount']?.toInt(),
//       createdAt: map['createdAt'] != null
//           ? (map['createdAt'] as Timestamp).toDate()
//           : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory PaymentDetails.fromJson(String source) =>
//       PaymentDetails.fromMap(json.decode(source));

//   @override
//   String toString() =>
//       'PaymentDetails(author: $author, amount: $amount, createdAt: $createdAt)';

//   @override
//   List<Object?> get props => [author, amount, createdAt];
// }
