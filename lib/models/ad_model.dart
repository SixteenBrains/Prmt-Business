import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import '/enums/enums.dart';
import '/config/paths.dart';
import '/models/appuser.dart';

class AdModel extends Equatable {
  final String? name;
  final String? adId;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? budget;
  final String? state;
  final List<String?> cities;
  final String? targetLink;
  final File? mediaFile;
  final MediaType? adType;
  final AppUser? author;
  final String? mediaUrl;

  const AdModel({
    this.name,
    this.adId,
    this.description,
    this.startDate,
    this.endDate,
    this.budget,
    this.state,
    this.cities = const [],
    this.targetLink,
    this.mediaFile,
    required this.adType,
    this.author,
    this.mediaUrl,
  });

  AdModel copyWith({
    String? name,
    String? adId,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? budget,
    String? state,
    List<String?>? cities,
    String? targetLink,
    File? mediaFile,
    MediaType? adType,
    AppUser? author,
    String? mediaUrl,
  }) {
    return AdModel(
      name: name ?? this.name,
      adId: adId ?? this.adId,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      budget: budget ?? this.budget,
      state: state ?? this.state,
      cities: cities ?? this.cities,
      targetLink: targetLink ?? this.targetLink,
      mediaFile: mediaFile ?? this.mediaFile,
      adType: adType ?? this.adType,
      author: author ?? this.author,
      mediaUrl: mediaUrl ?? this.mediaUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      // 'adId': adId,
      'description': description,
      'startDate': startDate != null ? Timestamp.fromDate(startDate!) : null,
      'endDate': endDate != null ? Timestamp.fromDate(endDate!) : null,
      'budget': budget,
      'state': state,
      'cities': cities,
      'targetLink': targetLink,
      //'mediaFile': mediaFile?.toMap(),
      'adType': EnumToString.convertToString(adType),
      'author':
          FirebaseFirestore.instance.collection(Paths.users).doc(author?.uid),
      'mediaUrl': mediaUrl,
    };
  }

  static Future<AdModel?> fromDocument(DocumentSnapshot? doc) async {
    final data = doc?.data() as Map?;
    print('Ad data $data');
    if (data != null) {
      final userRef = data['author'] as DocumentReference?;
      final userSnap = await userRef?.get();

      return AdModel(
        adId: doc?.id,
        description: data['description'],
        // ageGroup:
        //     data['ageGroup'] != null ? List<String>.from(data['ageGroup']) : [],
        // incomeRange: data['incomeRange'] != null
        //     ? List<String>.from(data['incomeRange'])
        //     : [],
        // interests: data['interests'] != null
        //     ? List<String>.from(data['interests'])
        //     : [],
        state: data['state'],
        cities: data['cities'] != null ? List<String>.from(data['cities']) : [],
        startDate: data['startDate'] != null
            ? (data['startDate'] as Timestamp).toDate()
            : null,
        endDate: data['endDate'] != null
            ? (data['endDate'] as Timestamp).toDate()
            : null,
        targetLink: data['targetLink'],
        author: userSnap != null ? AppUser.fromDocument(userSnap) : null,
        mediaUrl: data['mediaUrl'],
        adType: EnumToString.fromString(
          MediaType.values,
          data['adType'],
        ),
      );
    }
    return null;
  }

  @override
  String toString() {
    return 'AdMo(name: $name, adId: $adId, description: $description, startDate: $startDate, endDate: $endDate, budget: $budget, state: $state, city: $cities, targetLink: $targetLink, mediaFile: $mediaFile, adType: $adType, author: $author, mediaUrl: $mediaUrl)';
  }

  @override
  List<Object?> get props {
    return [
      name,
      adId,
      description,
      startDate,
      endDate,
      budget,
      state,
      cities,
      targetLink,
      mediaFile,
      adType,
      author,
      mediaUrl,
    ];
  }
}
