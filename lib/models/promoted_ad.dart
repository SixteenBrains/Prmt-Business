import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PromotedAd extends Equatable {
  final String? affiliateUrl;
  final int? clickCount;
  final int? conversion;
  final String? authorId;
  final List<String?> clicks;

  final List<String?> promoters;

  const PromotedAd({
    this.affiliateUrl,
    this.clickCount,
    this.conversion,
    this.authorId,
    this.promoters = const [],
    this.clicks = const [],
  });

  PromotedAd copyWith({
    String? affiliateUrl,
    int? clickCount,
    int? conversion,
    String? authorId,
    List<String?>? promoters,
    List<String?>? clicks,
  }) {
    return PromotedAd(
      affiliateUrl: affiliateUrl ?? this.affiliateUrl,
      clickCount: clickCount ?? this.clickCount,
      conversion: conversion ?? this.conversion,
      authorId: authorId ?? this.authorId,
      promoters: promoters ?? this.promoters,
      clicks: clicks ?? this.clicks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'affiliateUrl': affiliateUrl,
      'clickCount': clickCount,
      'conversion': conversion,
      'authorId': authorId,
      'promoters': promoters,
      'clicks': clicks,
    };
  }

  static PromotedAd fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map?;

    return PromotedAd(
      affiliateUrl: data?['affiliateUrl'],
      clickCount: data?['clickCount']?.toInt(),
      conversion: data?['conversion']?.toInt(),
      authorId: data?['authorId'],
      promoters:
          data?['promoters'] != null ? List.from(data?['promoters']) : [],
      clicks: data?['clicks'] != null ? List.from(data?['clicks']) : [],
    );
  }

  @override
  String toString() {
    return 'PromotedAd( adUrl: $affiliateUrl, clickCount: $clickCount, conversion: $conversion, authorId: $authorId, clicks: $clicks)';
  }

  @override
  List<Object?> get props {
    return [
      affiliateUrl,
      clickCount,
      conversion,
      authorId,
      promoters,
      clicks,
    ];
  }
}
