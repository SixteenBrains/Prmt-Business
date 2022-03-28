import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String? email;
  final String? name;
  final String? uid;
  final DateTime? createdAt;
  final String? businessName;

  const AppUser({
    this.email,
    this.name,
    this.uid,
    this.businessName,
    this.createdAt,
  });

  AppUser copyWith({
    String? email,
    String? name,
    String? uid,
    String? businessName,
    DateTime? createdAt,
  }) {
    return AppUser(
      email: email ?? this.email,
      name: name ?? this.name,
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
      businessName: businessName ?? this.businessName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'businessName': businessName,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      email: map['email'],
      name: map['name'],
      uid: map['uid'],
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  static const empty = AppUser(
    email: '',
    name: '',
    uid: '',
    createdAt: null,
  );

  factory AppUser.fromDocument(DocumentSnapshot? doc) {
    // if (doc == null) return null;
    final data = doc?.data() as Map?;
    print('App users ---- $data');
    return AppUser(
      email: data?['email'],
      name: data?['name'],
      uid: doc?.id,
      createdAt: data?['createdAt'] != null
          ? (data?['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppUser(email: $email, name: $name, uid: $uid, createdAt: $createdAt)';
  }

  @override
  List<Object?> get props => [
        email,
        name,
        uid,
        createdAt,
        businessName,
      ];
}
