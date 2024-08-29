// MyUserModel (data layer model) extends MyUser
import 'package:firebase_auth/firebase_auth.dart';

import '../entities/my_user.dart';

extension EnumToString on Enum {
  String toShortString() {
    switch (this) {
      case UserRole.student:
        return 'student';
      case UserRole.universityAdmin:
        return 'universityAdmin';
      case UserRole.appAdmin:
        return 'appAdmin';
      default:
        return 'student';
    }
  }
}

extension StringToEnum on String {
  UserRole toEnum() {
    switch (this) {
      case 'student':
        return UserRole.student;
      case 'universityAdmin':
        return UserRole.universityAdmin;
      case 'appAdmin':
        return UserRole.appAdmin;
      default:
        return UserRole.student;
    }
  }
}

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
      'role': role.toShortString(),
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
      role: (json['role'] as String).toEnum(),
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
