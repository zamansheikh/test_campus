import 'package:campus_saga/core/common/my_user/my_user_cubit.dart';
import 'package:campus_saga/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:campus_saga/features/auth/domain/repositories/auth_repository.dart';
import 'package:campus_saga/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:campus_saga/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:campus_saga/features/post_issue/presentation/cubit/post_issue_cubit.dart';
import 'package:campus_saga/features/student_issues/domain/usecases/get_student_issue.dart';
import 'package:campus_saga/features/student_issues/domain/usecases/post_student_issue.dart';
import 'package:campus_saga/features/student_issues/domain/usecases/resolve_student_issue.dart';
import 'package:campus_saga/navigation/cubit/bottom_nav_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'features/auth/data/data_sources/auth_remote_data_source.dart';
import 'features/auth/domain/usecases/user_login_usecase.dart';
import 'features/auth/domain/usecases/user_logout_usecase.dart';
import 'features/auth/domain/usecases/user_signup_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  sl.registerFactory(() => BottomNavCubit());
  sl.registerLazySingleton(() => MyUserCubit());
  sl.registerLazySingleton(() => PostIssueCubit());

  //! Student Issues
  // Use cases
  sl.registerLazySingleton(() => GetStudentIssues(sl()));
  sl.registerLazySingleton(() => PostStudentIssue(sl()));
  sl.registerLazySingleton(() => ResolveStudentIssue(sl()));

  // Repository
  // sl.registerLazySingleton<StudentIssueRepository>( () => StudentIssueRepositoryImpl());

  //! External
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());

  // External
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(() =>
      AuthRemoteDataSourceImpl(firebaseAuth: sl(), firebaseFirestore: sl()));

  //! Auth
  //Bloc
  sl.registerFactory(
    () => AuthBloc(
      myUserCubit: sl(),
      getCurrentUserUsecase: sl(),
      userLoginUsecase: sl(),
      userSignUpUsecase: sl(),
      userLogOutUsecase: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => UserLoginUsecase(repository: sl()));
  sl.registerLazySingleton(() => UserSignUpUsecase(repository: sl()));
  sl.registerLazySingleton(() => UserLogOutUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentUserUsecase(repository: sl()));
}
