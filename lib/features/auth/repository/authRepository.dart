// import 'dart:html';

import 'package:cartafri/core/constants/firestore_constants.dart';
import 'package:cartafri/core/failure.dart';
import 'package:cartafri/core/functionality/firebase_provider.dart';
import 'package:cartafri/core/type_defs.dart';
import 'package:cartafri/features/auth/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  Stream<User?> get authStateChange => _auth.authStateChanges();
// SIGNIN IN WTH GOOGLE
  FutureEither<UserModel> signInWithGoogle() async {
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
      } else {
        userModel = await getUserData(user.uid).first;
      }
      return right(userModel);

      // showSnackbar(BuildContext context, text).
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  void signout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
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
