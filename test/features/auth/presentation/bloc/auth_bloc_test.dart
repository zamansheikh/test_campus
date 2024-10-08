import 'package:campus_saga/core/common/my_user/my_user_cubit.dart';
import 'package:campus_saga/core/error/failure.dart';
import 'package:campus_saga/core/common/entities/my_user.dart';
import 'package:campus_saga/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:campus_saga/features/auth/domain/usecases/user_login_usecase.dart';
import 'package:campus_saga/features/auth/domain/usecases/user_logout_usecase.dart';
import 'package:campus_saga/features/auth/domain/usecases/user_signup_usecase.dart';
import 'package:campus_saga/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserLoginUsecase extends Mock implements UserLoginUsecase {}

class MockUserSignUpUsecase extends Mock implements UserSignUpUsecase {}

class MockUserLogOutUsecase extends Mock implements UserLogOutUsecase {}
class MocGetCurrentUserUsecase extends Mock implements GetCurrentUserUsecase {}
class MockMyUserCubit extends Mock implements MyUserCubit {}

void main() {
  late MockUserLoginUsecase mockUserLoginUsecase;
  late MockUserSignUpUsecase mockUserSignUpUsecase;
  late MockUserLogOutUsecase mockUserLogOutUsecase;
  late MocGetCurrentUserUsecase  mockGetCurrentUserUsecase;
  late MockMyUserCubit mockMyUserCubit;
  late AuthBloc authBloc;
  setUp(
    () {
      mockUserLoginUsecase = MockUserLoginUsecase();
      mockUserSignUpUsecase = MockUserSignUpUsecase();
      mockUserLogOutUsecase = MockUserLogOutUsecase();
      mockGetCurrentUserUsecase = MocGetCurrentUserUsecase();
      mockMyUserCubit = MockMyUserCubit();
      authBloc = AuthBloc(
        myUserCubit: mockMyUserCubit,
        userLoginUsecase: mockUserLoginUsecase,
        userSignUpUsecase: mockUserSignUpUsecase,
        userLogOutUsecase: mockUserLogOutUsecase,
        getCurrentUserUsecase: mockGetCurrentUserUsecase,
      );
    },
  );
  setUpAll(() {
    registerFallbackValue(UserSignUpParams(
        name: 'Zaman',
        email: 'zaman@gmail.com',
        password: '123456')); // Create a dummy Params instance
    registerFallbackValue(NoParams()); // Create a dummy NoParams instance
  });

  test(
    "initialState should be AuthInitial",
    () async {
      // assert
      expect(authBloc.state, equals(AuthInitial()));
    },
  );

  const tUser = MyUser(id: "124", name: "Zaman", email: "zaman@gmail.com");

  test(
    "should emit [AuthLoading, AuthLoaded] when SignUpEvent is added",
    () async {
      //Arrnage
      when(() => mockUserSignUpUsecase.call(any())).thenAnswer(
        (_) async => const Right(
            MyUser(id: "124", name: "Zaman", email: "zaman@gmail.com")),
      );

      //assert later

      final expectedResult = [AuthLoading(), const AuthLoaded(user: tUser)];
      expectLater(authBloc.stream, emitsInOrder(expectedResult));

      //act
      authBloc.add(const SignUpEvent(
          name: 'Zaman', email: "zaman@gmail.com", password: "123456"));
      await untilCalled(() => mockUserSignUpUsecase.call(any()));

      //assert
      verify(() => mockUserSignUpUsecase.call(any())).called(1);
    },
  );

  test("should emit [AuthLoading, AuthError] when SignUpEvent is added",
      () async {
    //Arrnage
    when(() => mockUserSignUpUsecase.call(any())).thenAnswer(
      (_) async => Left(ServerFailure(message: 'SERVER_FAILURE_MESSAGE')),
    );
    //assert later

    final expectedResult = [AuthLoading(),const AuthError(message: 'SERVER_FAILURE_MESSAGE')];
    expectLater(authBloc.stream, emitsInOrder(expectedResult));

    //act
    authBloc.add(const SignUpEvent(
        name: 'Zaman', email: "zaman@gmail.com", password: "123456"));
    await untilCalled(() => mockUserSignUpUsecase.call(any()));

    //assert
    verify(() => mockUserSignUpUsecase.call(any())).called(1);
  });
}
