import 'package:bloc/bloc.dart';
import 'package:campus_saga/features/auth/domain/entities/my_user.dart';
import 'package:campus_saga/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_loader_event.dart';
part 'auth_loader_state.dart';

class AuthLoaderBloc extends Bloc<AuthLoaderEvent, AuthLoaderState> {
  final AuthRepository authRepository;
  AuthLoaderBloc({required this.authRepository}) : super(AuthLoaderInitial()) {
    on<AuthLoaderGetUserEvent>((event, emit) {
      emit(AuthLoaderLoading());
      authRepository.getCurrentUser().then((user) {
        user.fold(
          (failure) => emit(AuthLoaderInitial()),
          (user) => emit(AuthLoaderLoaded(user: user)),
        );
      });
    });
  }
}
