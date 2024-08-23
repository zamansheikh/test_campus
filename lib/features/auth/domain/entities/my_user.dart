import 'package:equatable/equatable.dart';
enum UserRole { student, universityAdmin, appAdmin }

// MyUser entity (core domain entity)
class MyUser extends Equatable {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String universityId;
  final bool isProfileVerified;

  const MyUser({
    required this.id,
    required this.name,
    required this.email,
     this.role =UserRole.student,
     this.universityId = '',
     this.isProfileVerified = false,
  });

  @override
  List<Object> get props => [id, name, email, role, universityId, isProfileVerified];
}