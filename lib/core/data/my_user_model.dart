// MyUserModel (data layer model) extends MyUser
import 'package:firebase_auth/firebase_auth.dart';

import '../common/entities/my_user.dart';

class MyUserModel extends MyUser {
  // Keep the optional fields in MyUserModel
  const MyUserModel({
    required super.id,
    required super.email,
    required super.name,
    super.role,
    super.universityId,
    super.isProfileVerified,
  });

  // Factory constructor to create MyUserModel from FirebaseUser
  factory MyUserModel.fromFirebaseUser(User firebaseUser) {
    return MyUserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email!,
      name: firebaseUser.displayName ?? 'No Name',
    );
  }

  // 1. JSON Serialization (to JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.toString().split('.').last,
      'universityId': universityId,
      'isProfileVerified': isProfileVerified,
    };
  }

  // 2. JSON Deserialization (from JSON)
  factory MyUserModel.fromJson(Map<String, dynamic> json) {
    return MyUserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: UserRole.values
          .firstWhere((e) => e.toString().split('.').last == json['role']),
      universityId: json['universityId'],
      isProfileVerified: json['isProfileVerified'],
    );
  }

  // 3. copyWith
  MyUserModel copyWith({
    String? id,
    String? name,
    String? email,
    UserRole? role,
    String? universityId,
    bool? isProfileVerified,
  }) {
    return MyUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      universityId: universityId ?? this.universityId,
      isProfileVerified: isProfileVerified ?? this.isProfileVerified,
    );
  }
}
