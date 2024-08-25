import 'package:campus_saga/core/common/my_user/my_user_cubit.dart';
import 'package:campus_saga/core/theme/theme.dart';
import 'package:campus_saga/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:campus_saga/features/auth/presentation/pages/login_page.dart';
import 'package:campus_saga/features/auth/presentation/pages/signup_page.dart';
import 'package:campus_saga/features/promotions/presentation/pages/promotions_page.dart';
import 'package:campus_saga/firebase_options.dart';
import 'package:campus_saga/navigation/cubit/bottom_nav_cubit.dart';
import 'package:campus_saga/navigation/pages/auth_loader.dart';
import 'package:campus_saga/navigation/pages/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/post_issue/presentation/pages/post_issue_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'features/student_issues/presentation/pages/student_issue_page.dart';
import 'features/university_ranking/presentation/pages/university_ranking_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize the dependency injection container
  await di.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => di.sl<MyUserCubit>()),
      BlocProvider(create: (_) => di.sl<BottomNavCubit>()),
      BlocProvider(create: (_) => di.sl<AuthBloc>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(LoggedInOrNotAuthEvent());
    // context.read<AuthBloc>().state;
    // print('AuthBloc state: ${context.read<AuthBloc>().state}');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Campus Saga',
            theme: AppTheme.darkThemeMode,
            initialRoute: '/',
            routes: {
              '/': (context) => const AuthLoaderPage(),
              '/login': (context) => const LoginPage(),
              '/signup': (context) => const SignupPage(),
              '/home': (context) => const MainScreen(),
              '/student_issues': (context) => const StudentIssuesPage(),
              '/university_ranking': (context) => const UniversityRankingPage(),
              '/profile': (context) => const ProfilePage(),
              '/promotions': (context) => const PromotionsPage(),
              '/post_issue': (context) => const PostIssuePage(),
            },
          );
        });
  }
}
