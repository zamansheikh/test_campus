import 'package:campus_saga/core/common/my_user/my_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthLoaderPage extends StatelessWidget {
  const AuthLoaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyUserCubit, MyUserState>(
      listener: (context, state) {
        if (state is MyUserLoggedIn) {
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
