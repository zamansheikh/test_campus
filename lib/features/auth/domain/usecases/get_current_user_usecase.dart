import 'package:campus_saga/core/error/failure.dart';
import 'package:campus_saga/core/usecase/usecase.dart';
import 'package:campus_saga/features/auth/domain/entities/my_user.dart';
import 'package:campus_saga/features/auth/domain/repositories/auth_repository.dart';
import 'package:campus_saga/features/auth/domain/usecases/user_logout_usecase.dart';
import 'package:dartz/dartz.dart';

class GetCurrentUserUsecase implements UseCase<MyUser, NoParams> {
  final AuthRepository repository;
  const GetCurrentUserUsecase({required this.repository});
  @override
  Future<Either<Failure, MyUser>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
