import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';

import '/enums/card_brand.dart';

class SaveCard extends Equatable {
  final String? cardId;
  final String? cardNo;
  final String? expMon;
  final String? expYear;
  final String? cvv;
  final CardBrand? cardBrand;

  const SaveCard({
    this.cardId,
    this.cardNo,
    this.expMon,
    this.expYear,
    this.cvv,
    this.cardBrand,
  });

  SaveCard copyWith({
    String? cardId,
    String? cardNo,
    String? expMon,
    String? expYear,
    String? cvv,
    CardBrand? cardBrand,
  }) {
    return SaveCard(
      cardId: cardId ?? this.cardId,
      cardNo: cardNo ?? this.cardNo,
      expMon: expMon ?? this.expMon,
      expYear: expYear ?? this.expYear,
      cvv: cvv ?? this.cvv,
      cardBrand: cardBrand ?? this.cardBrand,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cardNo': cardNo,
      'expMon': expMon,
      'expYear': expYear,
      'cvv': cvv,
      'cardBrand': EnumToString.convertToString(cardBrand),
    };
  }

  factory SaveCard.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map?;
    return SaveCard(
      cardId: doc.id,
      cardNo: data?['cardNo'],
      expMon: data?['expMon'],
      expYear: data?['expYear'],
      cvv: data?['cvv'],
      cardBrand: data?['cardBrand'] != null
          ? EnumToString.fromString(CardBrand.values, data?['cardBrand'])
          : CardBrand.unknown,
    );
  }

  // factory SaveCard.fromMap(Map<String, dynamic> map) {
  //   return SaveCard(
  //     cardNo: map['cardNo'],
  //     expMon: map['expMon'],
  //     expYear: map['expYear'],
  //     cvv: map['cvv'],
  //     cardBrand: map['cardBrand'] != null
  //         ? EnumToString.fromString(CardBrand.values, map['cardBrand'])
  //         : CardBrand.unknown,
  //   );
  // }

  @override
  String toString() {
    return 'SaveCard(cardId: $cardId, cardNo: $cardNo, expMon: $expMon, expYear: $expYear, cvv: $cvv, cardBrand: $cardBrand)';
  }

  @override
  List<Object?> get props {
    return [
      cardId,
      cardNo,
      expMon,
      expYear,
      cvv,
      cardBrand,
    ];
  }
}
