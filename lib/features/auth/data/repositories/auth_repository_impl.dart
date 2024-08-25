import 'package:campus_saga/core/error/exception.dart';
import 'package:campus_saga/core/error/failure.dart';
import 'package:campus_saga/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:campus_saga/core/common/entities/my_user.dart';
import 'package:campus_saga/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  const AuthRepositoryImpl({required this.authRemoteDataSource});
  @override
  Future<Either<Failure, MyUser>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await authRemoteDataSource.signInWithEmailAndPassword(
          email: email, password: password);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await authRemoteDataSource.signOut();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, MyUser>> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final user = await authRemoteDataSource.signUpWithEmailAndPassword(
          name: name, email: email, password: password);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, MyUser>> getCurrentUser() async {
    final user = await authRemoteDataSource.getCurrentUser();
    try {
      if (user == null) {
        return Left(ServerFailure(message: "User not found"));
      }
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
