import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String? email;
  final String? name;
  final String? uid;
  final String? profilePic;

  final DateTime? createdAt;

  const AppUser({
    this.email,
    this.name,
    this.uid,
    this.profilePic,
    this.createdAt,
  });

  AppUser copyWith({
    String? email,
    String? name,
    String? uid,
    String? profilePic,
    DateTime? createdAt,
  }) {
    return AppUser(
      email: email ?? this.email,
      name: name ?? this.name,
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      email: map['email'],
      name: map['name'],
      uid: map['uid'],
      profilePic: map['profilePic'],
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  static const empty = AppUser(
    email: '',
    name: '',
    uid: '',
    profilePic: '',
    createdAt: null,
  );

  factory AppUser.fromDocument(DocumentSnapshot? doc) {
    // if (doc == null) return null;
    final data = doc?.data() as Map?;
    print('App users ---- $data');
    return AppUser(
      email: data?['email'],
      name: data?['name'],
      uid: data?['uid'],
      profilePic: data?['profilePic'],
      createdAt: data?['createdAt'] != null
          ? (data?['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  static const emptyUser = AppUser(
    uid: '',
    name: '',
    profilePic: '',
    email: '',
    createdAt: null,
  );

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppUser(email: $email, name: $name, uid: $uid, profilePic: $profilePic, createdAt: $createdAt)';
  }

  @override
  List<Object?> get props => [
        email,
        name,
        uid,
        profilePic,
        createdAt,
      ];
}
