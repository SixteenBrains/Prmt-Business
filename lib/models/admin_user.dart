import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AdminUser extends Equatable {
  final String? email;
  final String? name;
  final String? uid;
  final DateTime? createdAt;
  final String? businessName;
  final String? businessType;

  const AdminUser({
    this.email,
    this.name,
    this.uid,
    this.businessName,
    this.createdAt,
    this.businessType,
  });

  AdminUser copyWith({
    String? email,
    String? name,
    String? uid,
    String? businessName,
    DateTime? createdAt,
    String? businessType,
  }) {
    return AdminUser(
      email: email ?? this.email,
      name: name ?? this.name,
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
      businessName: businessName ?? this.businessName,
      businessType: businessType ?? this.businessType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'businessName': businessName,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'businessType': businessType,
    };
  }

  factory AdminUser.fromMap(Map<String, dynamic> map) {
    return AdminUser(
      email: map['email'],
      name: map['name'],
      uid: map['uid'],
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      businessType: map['businessType'],
    );
  }

  static const empty = AdminUser(
    email: '',
    name: '',
    uid: '',
    createdAt: null,
    businessType: '',
  );

  factory AdminUser.fromDocument(DocumentSnapshot? doc) {
    // if (doc == null) return null;
    final data = doc?.data() as Map?;
    print('App users ---- $data');
    return AdminUser(
      email: data?['email'],
      name: data?['name'],
      uid: doc?.id,
      createdAt: data?['createdAt'] != null
          ? (data?['createdAt'] as Timestamp).toDate()
          : null,
      businessType: data?['businessType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminUser.fromJson(String source) =>
      AdminUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppUser(email: $email, name: $name, uid: $uid, createdAt: $createdAt, businessType: $businessType)';
  }

  @override
  List<Object?> get props => [
        email,
        name,
        uid,
        createdAt,
        businessName,
        businessType,
      ];
}
