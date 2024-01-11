// ignore_for_file: use_build_context_synchronously
import 'package:cartafri/core/utils/showOTPdialog.dart';
import 'package:cartafri/core/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    if (kIsWeb) {
      ConfirmationResult result =
          await _auth.signInWithPhoneNumber(phoneNumber);
      showOTPDialog(
        context: context,
        codeController: codeController,
        onPressed: () async {
          PhoneAuthCredential phoneAuthCredential =
              PhoneAuthProvider.credential(
            verificationId: result.verificationId,
            smsCode: codeController.text.trim(),
          );
          await _auth.signInWithCredential(phoneAuthCredential);
          Navigator.of(context).pop();
        },
      );
    } else {
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

  // GOOGLE SIGNIN
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      // await _auth.signInWithProvider(_googleAuthProvider);
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // print(googleAuth?.accessToken);
      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
            idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        showSnackbar(context, 'signed in');
        if (userCredential.user != null) {
          // checks if the user is already signed up
          if (userCredential.additionalUserInfo!.isNewUser) {}
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message!);
    }
  }

  // ANONYMOUS SIGN IN
  Future<void> signInUserAnonimously(BuildContext context) async {
    try {
      await _auth.signInAnonymously();
      showSnackbar(context, 'User Signed in');
    } on FirebaseAuthException catch (e) {}
  }
}
// keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android 
