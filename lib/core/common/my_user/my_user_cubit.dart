import 'package:bloc/bloc.dart';
import 'package:campus_saga/core/common/entities/my_user.dart';
import 'package:equatable/equatable.dart';

part 'my_user_state.dart';

class MyUserCubit extends Cubit<MyUserState> {
  MyUserCubit() : super(MyUserInitial());
  void updateUser(MyUser? user) {
    if (user == null) {
      emit(MyUserInitial());
    } else {
      emit(MyUserLoggedIn(user: user));
    }
  }
}
