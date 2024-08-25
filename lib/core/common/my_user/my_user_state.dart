part of 'my_user_cubit.dart';

sealed class MyUserState extends Equatable {
  const MyUserState();

  @override
  List<Object> get props => [];
}

final class MyUserInitial extends MyUserState {}
final class MyUserLoading extends MyUserState {}
final class MyUserLoggedIn extends MyUserState {
  final MyUser user;

  const MyUserLoggedIn({required this.user});

  @override
  List<Object> get props => [user];
}
