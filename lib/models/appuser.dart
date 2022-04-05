import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String? email;
  final String? profileImg;
  final String? name;
  final String? uid;
  final DateTime? createdAt;
  final String? businessName;
  final String? businessType;
  final bool firstAdCreated;

  const AppUser({
    this.profileImg,
    this.email,
    this.name,
    this.uid,
    this.businessName,
    this.createdAt,
    this.businessType,
    this.firstAdCreated = false,
  });

  AppUser copyWith({
    String? profileImg,
    String? email,
    String? name,
    String? uid,
    String? businessName,
    DateTime? createdAt,
    String? businessType,
    bool? firstAdCreated,
  }) {
    return AppUser(
      profileImg: profileImg ?? this.profileImg,
      email: email ?? this.email,
      name: name ?? this.name,
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
      businessName: businessName ?? this.businessName,
      businessType: businessType ?? this.businessType,
      firstAdCreated: firstAdCreated ?? this.firstAdCreated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profileImg': profileImg,
      'email': email,
      'name': name,
      'businessName': businessName,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'businessType': businessType,
      'firstAdCreated': firstAdCreated,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      profileImg: map['profileImg'],
      email: map['email'],
      name: map['name'],
      uid: map['uid'],
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      businessType: map['businessType'],
      firstAdCreated: map['firstAdCreated'] ?? false,
    );
  }

  static const empty = AppUser(
    email: '',
    name: '',
    uid: '',
    createdAt: null,
    businessType: '',
  );

  factory AppUser.fromDocument(DocumentSnapshot? doc) {
    // if (doc == null) return null;
    final data = doc?.data() as Map?;
    print('App users ---- $data');
    return AppUser(
      profileImg: data?['profileImg'],
      email: data?['email'],
      name: data?['name'],
      uid: doc?.id,
      createdAt: data?['createdAt'] != null
          ? (data?['createdAt'] as Timestamp).toDate()
          : null,
      businessType: data?['businessType'],
      firstAdCreated: data?['firstAdCreated'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppUser(email: $email, name: $name, uid: $uid, createdAt: $createdAt, businessType: $businessType, firstAdCreated: $firstAdCreated, profileImg: $profileImg)';
  }

  @override
  List<Object?> get props => [
        email,
        name,
        uid,
        createdAt,
        businessName,
        businessType,
        profileImg,
      ];
}
