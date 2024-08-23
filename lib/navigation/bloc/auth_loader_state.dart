part of 'auth_loader_bloc.dart';

sealed class AuthLoaderState extends Equatable {
  const AuthLoaderState();
  
  @override
  List<Object> get props => [];
}

final class AuthLoaderInitial extends AuthLoaderState {}
final class AuthLoaderLoading extends AuthLoaderState {}
final class AuthLoaderLoaded extends AuthLoaderState {
  final MyUser user;
  const AuthLoaderLoaded({required this.user});
  
  @override
  List<Object> get props => [user];
}
