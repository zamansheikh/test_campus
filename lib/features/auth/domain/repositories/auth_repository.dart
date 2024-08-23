import 'package:campus_saga/core/error/failure.dart';
import 'package:campus_saga/features/auth/domain/entities/my_user.dart';
import 'package:dartz/dartz.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, MyUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, MyUser>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, MyUser>> getCurrentUser();
}
