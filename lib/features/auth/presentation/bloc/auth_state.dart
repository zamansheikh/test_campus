part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoaded extends AuthState {
  final MyUser user;

  const AuthLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

final class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}

final class AuthGetUserError extends AuthState {}
