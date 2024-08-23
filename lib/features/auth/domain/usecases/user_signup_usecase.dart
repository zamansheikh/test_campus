import 'package:campus_saga/core/error/failure.dart';
import 'package:campus_saga/core/usecase/usecase.dart';
import 'package:campus_saga/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/my_user.dart';

class UserSignUpUsecase implements UseCase<MyUser, UserSignUpParams> {
  final AuthRepository repository;
  const UserSignUpUsecase({required this.repository});
  @override
  Future<Either<Failure, MyUser>> call(UserSignUpParams params) async {
    return await repository.signUpWithEmailAndPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
