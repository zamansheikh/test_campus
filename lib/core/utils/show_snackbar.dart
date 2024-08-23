import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

void testFirebaseAuth() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
    print("Signed in with user ID: ${userCredential.user?.uid}");
  } catch (e) {
    print("Firebase authentication error: $e");
  }
}
