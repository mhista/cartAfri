import 'package:cartafri/features/auth/repository/authRepository.dart';
import 'package:cartafri/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cartafri/core/utils/snackBar.dart';

// PROVIDER FOR STORING USER INFO
final userProvider = StateProvider<UserModel?>((ref) => null);

// A POVIDER THAT NOTIFIES THE AUTH CONTROLLER OF ANY CHANGE IN THE AUTH REPOSITORY
final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(
        authRepository: ref.watch(authRepositoryProvider), ref: ref));

// A STREAM PROVIDER THAT STORES THE CURRENT AUTHENTICATION STATE
final authStateChangeProvider = StreamProvider.autoDispose((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserProvider = StreamProvider.family.autoDispose((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

//  USED TO KNOW IF THE USER IS AUTHENTICATED OR NOT, THROUGH A FIREBASE CALL. THIS IS TO KNOW WHICH SCREEN TO DISPLAY TO THE USER
  Stream<User?> get authStateChange => _authRepository.authStateChange;

  // FETCHES THE USER DATA FROM FIEBASE AND STORES IT IN A PROVIDER
  Stream<UserModel> getUserData(String uid) => _authRepository.getUserData(uid);

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;
    user.fold(
        (l) => showSnackbar2(context, l.message),
        (userModel) =>
            _ref.read(userProvider.notifier).update((state) => userModel));
  }
}
