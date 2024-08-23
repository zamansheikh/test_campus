import 'package:campus_saga/core/error/failure.dart';
import 'package:campus_saga/core/usecase/usecase.dart';
import 'package:campus_saga/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/my_user.dart';

class UserLoginUsecase implements UseCase<MyUser, UserLoginParams> {
  final AuthRepository repository;
  const UserLoginUsecase({required this.repository});
  @override
  Future<Either<Failure, MyUser>> call(UserLoginParams params) async {
    return await repository.signInWithEmailAndPassword(
        email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
