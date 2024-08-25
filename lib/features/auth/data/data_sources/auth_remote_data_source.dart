import 'package:campus_saga/core/error/exception.dart';
import 'package:campus_saga/core/data/my_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<MyUserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  AuthRemoteDataSourceImpl(
      {required this.firebaseFirestore, required this.firebaseAuth});

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
        MyUserModel userModel = MyUserModel.fromFirebaseUser(user).copyWith(
          name: name,
        );
        await firebaseFirestore.collection('users').doc(userModel.id).set(
              userModel.toJson(),
            );
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
      final user = userCredential.user;
      if (user != null) {
        //get user info from clouldfirestore
        DocumentSnapshot<Map<String, dynamic>> userDoc =
            await firebaseFirestore.collection('users').doc(user.uid).get();
        if (!userDoc.exists) {
          throw ServerException("User not found");
        }
        return MyUserModel.fromJson(userDoc.data()!);
      } else {
        throw ServerException("User not found");
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
  Future<MyUserModel?> getCurrentUser() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        //get user info from clouldfirestore
        DocumentSnapshot<Map<String, dynamic>> userDoc =
            await firebaseFirestore.collection('users').doc(user.uid).get();
        if (!userDoc.exists) {
          throw ServerException("User not found");
        }
        return MyUserModel.fromJson(userDoc.data()!);
      } else {
        return null;
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
