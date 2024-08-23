import 'package:bloc/bloc.dart';
import 'package:campus_saga/features/auth/domain/usecases/user_login_usecase.dart';
import 'package:campus_saga/features/auth/domain/usecases/user_logout_usecase.dart';
import 'package:campus_saga/features/auth/domain/usecases/user_signup_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/my_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLoginUsecase userLoginUsecase;
  final UserSignUpUsecase userSignUpUsecase;
  final UserLogOutUsecase userLogOutUsecase;
  AuthBloc({
    required this.userLoginUsecase,
    required this.userSignUpUsecase,
    required this.userLogOutUsecase,
  }) : super(AuthInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await userSignUpUsecase.call(UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ));
      result.fold(
        (failure) async {
          emit(AuthError(message: failure.toString()));
        },
        (user) async {
          emit(AuthLoaded(user: user));
        },
      );
    });
    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await userLoginUsecase.call(UserLoginParams(
        email: event.email,
        password: event.password,
      ));
      result.fold(
        (failure) => emit(AuthError(message: failure.toString())),
        (user) => emit(AuthLoaded(user: user)),
      );
    });
    on<SignOutEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await userLogOutUsecase.call(NoParams());
      result.fold(
        (failure) => emit(AuthError(message: failure.toString())),
        (user) => emit(AuthInitial()),
      );
    });
  }
}
