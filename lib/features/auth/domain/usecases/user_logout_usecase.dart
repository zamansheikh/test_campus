import 'package:campus_saga/core/error/failure.dart';
import 'package:campus_saga/core/usecase/usecase.dart';
import 'package:campus_saga/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class UserLogOutUsecase implements UseCase<void, NoParams> {
  final AuthRepository repository;
  const UserLogOutUsecase({required this.repository});
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.signOut();
  }
}

class NoParams {
  NoParams();
}
