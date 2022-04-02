import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class AdModel extends Equatable {
  final String? adName;
  final String? adId;
  final String? adContent;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? budget;
  final List<String> ageGroup;
  final List<String> incomeRange;
  final List<String> interests;
  final String? state;
  final String? city;
  final String? adTargetLink;
  final Uint8List? adImage;
  final File? adVideo;

  const AdModel({
    this.adId,
    this.adName,
    required this.adContent,
    this.startDate,
    this.endDate,
    this.budget,
    required this.ageGroup,
    required this.incomeRange,
    required this.interests,
    required this.state,
    required this.city,
    required this.adTargetLink,
    this.adImage,
    this.adVideo,
  });

  AdModel copyWith({
    String? adName,
    String? adContent,
    DateTime? startDate,
    DateTime? endDate,
    String? budget,
    List<String>? ageGroup,
    List<String>? incomeRange,
    List<String>? interests,
    String? state,
    String? city,
    String? adTargetLink,
    Uint8List? adImage,
    File? adVideo,
    String? adId,
  }) {
    return AdModel(
      adId: adId ?? this.adId,
      adName: adName ?? this.adName,
      adContent: adContent ?? this.adContent,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      budget: budget ?? this.budget,
      ageGroup: ageGroup ?? this.ageGroup,
      incomeRange: incomeRange ?? this.incomeRange,
      interests: interests ?? this.interests,
      state: state ?? this.state,
      city: city ?? this.city,
      adTargetLink: adTargetLink ?? this.adTargetLink,
      adImage: adImage ?? this.adImage,
      adVideo: adVideo ?? this.adVideo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'adId': adId,
      'adName': adName,
      'adContent': adContent,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'budget': budget,
      'ageGroup': ageGroup,
      'incomeRange': incomeRange,
      'interests': interests,
      'state': state,
      'city': city,
      'adTargetLink': adTargetLink,
      // 'adImage': adImage?.toMap(),
      // 'adVideo': adVideo?.toMap(),
    };
  }

  factory AdModel.fromMap(Map<String, dynamic> map) {
    return AdModel(
      adId: map['adId'],
      adName: map['adName'],
      adContent: map['adContent'] ?? '',
      startDate: map['startDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startDate'])
          : null,
      endDate: map['endDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endDate'])
          : null,
      budget: map['budget'],
      ageGroup: List<String>.from(map['ageGroup']),
      incomeRange: List<String>.from(map['incomeRange']),
      interests: List<String>.from(map['interests']),
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      adTargetLink: map['adTargetLink'] ?? '',
      // adImage: map['adImage'] != null ? Uint8List.fromMap(map['adImage']) : null,
      // adVideo: map['adVideo'] != null ? File.fromMap(map['adVideo']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdModel.fromJson(String source) =>
      AdModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AdModel(adName: $adName, adContent: $adContent, startDate: $startDate, endDate: $endDate, budget: $budget, ageGroup: $ageGroup, incomeRange: $incomeRange, interests: $interests, state: $state, city: $city, adTargetLink: $adTargetLink, adImage: $adImage, adVideo: $adVideo)';
  }

  @override
  List<Object?> get props {
    return [
      adId,
      adName,
      adContent,
      startDate,
      endDate,
      budget,
      ageGroup,
      incomeRange,
      interests,
      state,
      city,
      adTargetLink,
      adImage,
      adVideo,
    ];
  }
}
