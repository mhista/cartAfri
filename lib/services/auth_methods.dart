import 'package:cartafri/core/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireBaseAuthMethods {
  final FirebaseAuth _auth;
  FireBaseAuthMethods(this._auth);
  // SIGNUP WITH EMAIL
  Future<void> signUpWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message!);
    }
  }
}
