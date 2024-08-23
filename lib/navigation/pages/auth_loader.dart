import 'package:campus_saga/navigation/bloc/auth_loader_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthLoader extends StatelessWidget {
  const AuthLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthLoaderBloc, AuthLoaderState>(
      listener: (context, state) {
        if (state is AuthLoaderLoaded) {
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (state is AuthLoaderInitial) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      builder: (BuildContext context, AuthLoaderState state) { 
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
       },
    );
  }
}
