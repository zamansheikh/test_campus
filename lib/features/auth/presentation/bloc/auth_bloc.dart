import 'package:bloc/bloc.dart';
import 'package:campus_saga/core/common/my_user/my_user_cubit.dart';
import 'package:campus_saga/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:campus_saga/features/auth/domain/usecases/user_login_usecase.dart';
import 'package:campus_saga/features/auth/domain/usecases/user_logout_usecase.dart';
import 'package:campus_saga/features/auth/domain/usecases/user_signup_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/common/entities/my_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLoginUsecase userLoginUsecase;
  final UserSignUpUsecase userSignUpUsecase;
  final UserLogOutUsecase userLogOutUsecase;
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final MyUserCubit myUserCubit;
  AuthBloc({
    required this.myUserCubit,
    required this.userLoginUsecase,
    required this.userSignUpUsecase,
    required this.userLogOutUsecase,
    required this.getCurrentUserUsecase,
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoading()));
    on<LoggedInOrNotAuthEvent>((event, emit) async {
      final result = await getCurrentUserUsecase.call(NoParams());
      result.fold(
        (failure) async {
          emit(AuthError(message: failure.toString()));
          myUserCubit.updateUser(null);
          // print("Called - ${failure.toString()}");
        },
        (user) {
          // print("Called LoggedInOrNotAuthEvent");

          emitAuthLoaded(user, emit);
        },
      );
    });
    on<SignUpEvent>((event, emit) async {
      final result = await userSignUpUsecase.call(UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ));
      result.fold(
        (failure) async => emit(AuthError(message: failure.toString())),
        (user) async => emitAuthLoaded(user, emit),
      );
    });
    on<SignInEvent>((event, emit) async {
      final result = await userLoginUsecase.call(UserLoginParams(
        email: event.email,
        password: event.password,
      ));
      result.fold(
        (failure) => emit(AuthError(message: failure.toString())),
        (user) => emitAuthLoaded(user, emit),
      );
    });
    on<SignOutEvent>((event, emit) async {
      final result = await userLogOutUsecase.call(NoParams());
      result.fold(
        (failure) => emit(AuthError(message: failure.toString())),
        (user) {
          myUserCubit.updateUser(null);
          emit(AuthInitial());
        },
      );
    });
  }
  void emitAuthLoaded(MyUser user, Emitter<AuthState> emit) {
    myUserCubit.updateUser(user);
    emit(AuthLoaded(user: user));
  }
}
