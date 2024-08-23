import 'package:campus_saga/core/error/exception.dart';
import 'package:campus_saga/features/auth/data/model/my_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDataSource {
  Future<MyUserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<MyUserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<MyUserModel> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  AuthRemoteDataSourceImpl({required this.firebaseAuth});

  @override
  Future<MyUserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        final userModel = MyUserModel.fromFirebaseUser(userCredential.user!);
        return userModel;
      } else {
        throw ServerException("User not found");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<MyUserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user == null) {
        throw ServerException("User not found");
      } else {
        return MyUserModel.fromFirebaseUser(userCredential.user!);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<MyUserModel> getCurrentUser() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        return MyUserModel.fromFirebaseUser(user);
      } else {
        throw ServerException("User not found");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
