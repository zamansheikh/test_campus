import 'package:campus_saga/core/utils/show_snackbar.dart';
import 'package:campus_saga/core/widgets/loader.dart';
import 'package:campus_saga/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_pallete.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                showSnackBar(context, state.message);
                context.read<AuthBloc>().add(SignOutEvent());
              }
              if (state is AuthLoaded) {
                Navigator.of(context).pushNamed('/home');
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Loader();
              }
              if (state is AuthLoaded) {
                //Navigate to home page
                return const Text('User Logged In');
              }
              if (state is AuthError) {
                return Text('login Page: ${state.message}');
              }
              if (state is AuthInitial) {
                return Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login.',
                        style: TextStyle(
                            fontSize: 50.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30.sp),
                      AuthField(
                        hintText: "Email",
                        controller: emailController,
                      ),
                      SizedBox(height: 15.sp),
                      AuthField(
                        hintText: "Password",
                        controller: passwordController,
                        obscureText: true,
                      ),
                      SizedBox(height: 20.sp),
                      AuthGradientButton(
                        text: "Login",
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  SignInEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          }
                        },
                      ),
                      SizedBox(height: 20.sp),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/signup');
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text: "Signup",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: AppPallete.gradient2,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    ));
  }
}
