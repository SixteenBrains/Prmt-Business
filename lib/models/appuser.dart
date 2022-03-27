import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String? uid;

  final String? email;

  const AppUser({
    this.uid,
    this.email,
  });

  AppUser copyWith({
    String? uid,
    String? email,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
    );
  }

  static const empty = AppUser(
    uid: '',
    email: '',
  );

  Map<String, dynamic> toMap() {
    //final type = EnumToString.convertToString(userType);
    return {
      'uid': uid,
      'email': email,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    // final type = EnumToString.fromString(UserType.values, map['userType']);
    return AppUser(
      uid: map['uid'],
      email: map['email'],
    );
  }

  factory AppUser.fromDocument(DocumentSnapshot? doc) {
    final data = doc?.data() as Map?;

    print('App users ---- $data');
    return AppUser(
      uid: data?['uid'],

      email: data?['email'],
      // skills: List<String?>.from(data?['skills']),
      // interests: List<String?>.from(data?['interests']),
      // userType: type ?? UserType.unknown,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppUser(uid: $uid, email: $email,)';
  }

  @override
  List<Object?> get props {
    return [
      uid,
      email,
    ];
  }
}
