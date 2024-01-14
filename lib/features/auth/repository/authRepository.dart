// import 'dart:html';

import 'package:cartafri/core/constants/firestore_constants.dart';
import 'package:cartafri/core/functionality/firebase_provider.dart';
import 'package:cartafri/core/utils/showOTPdialog.dart';
import 'package:cartafri/core/utils/snackbar.dart';
import 'package:cartafri/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider),
    fireStore: ref.read(fireStoreProvider)));

class AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;
  AuthRepository({
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
    required FirebaseFirestore fireStore,
  })  : _auth = auth,
        _googleSignIn = googleSignIn,
        _firestore = fireStore;
  // GET THE USERS COLLETION
  CollectionReference get _users =>
      _firestore.collection(FireStoreConstants.userCollections);
// SIGNIN IN WTH GOOGLE
  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final user = userCredential.user!;
      UserModel userModel;
      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
            name: user.displayName ?? '',
            profilePic: user.photoURL ?? '',
            uid: user.uid,
            isAuthenticated: true,
            phoneNumber: user.phoneNumber ?? '');
        await _users.doc(user.uid).set(userModel.toMap());
        _googleSignIn.signOut();
      }

      // showSnackbar(BuildContext context, text).
    } catch (e) {}
  }

  // void signInWithPhone(String phoneNumber) async {
  //   await _auth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       verificationCompleted: (phoneAuthCredential) async {
  //         await _auth.signInWithCredential(phoneAuthCredential);
  //         print('verification completed');
  //       },
  //       verificationFailed: (e) {
  //         //
  //       },
  //       codeSent: (verificationId, forceResendingToken) {
  //         showOTPDialog(
  //           context: context,
  //           codeController: codeController,
  //           onPressed: () async {
  //             PhoneAuthCredential phoneAuthCredential =
  //                 PhoneAuthProvider.credential(
  //               verificationId: verificationId,
  //               smsCode: codeController.text.trim(),
  //             );
  //             await _auth.signInWithCredential(phoneAuthCredential);
  //             Navigator.of(context).pop();
  //           },
  //         );
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {});
  // }
}
