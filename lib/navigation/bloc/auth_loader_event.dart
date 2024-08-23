part of 'auth_loader_bloc.dart';

sealed class AuthLoaderEvent extends Equatable {
  const AuthLoaderEvent();

  @override
  List<Object> get props => [];
}

final class AuthLoaderGetUserEvent extends AuthLoaderEvent {
  const AuthLoaderGetUserEvent();

  @override
  List<Object> get props => [];
}
