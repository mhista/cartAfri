// ignore_for_file: use_build_context_synchronously

// import 'dart:html';
import 'package:cartafri/core/utils/showOTPdialog.dart';
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
      await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message!);
    }
  }

  // LOGIN WITH EMAIL
  Future<void> loginWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (!_auth.currentUser!.emailVerified) {
        showSnackbar(context, 'please verify your email');
        await sendEmailVerification(context);
      }
      showSnackbar(context, 'successfully logged in');
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message!);
    }
  }

  // SEND EMAL VERIFICATION
  Future<void> sendEmailVerification(context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackbar(context, 'Email verification sent');
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message!);
    }
  }

  // PHONE SIGN IN
  Future<void> phoneSignIn(BuildContext context, String phoneNumber) async {
    TextEditingController codeController = TextEditingController();
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        await _auth.signInWithCredential(phoneAuthCredential);
        showSnackbar(context, 'verification completed');
      },
      verificationFailed: (e) {
        showSnackbar(context, e.message!);
      },
      codeSent: (verificationId, forceResendingToken) {
        showOTPDialog(
          context: context,
          codeController: codeController,
          onPressed: () async {
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: codeController.text.trim(),
            );
            await _auth.signInWithCredential(phoneAuthCredential);
            Navigator.of(context).pop();
          },
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {
        // Auto resolution timeout
      },
    );
  }
}
// keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android 
