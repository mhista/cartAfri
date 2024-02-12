import 'package:cartafri/core/utils/commons/isLoading.dart';
import 'package:cartafri/core/utils/commons/reusables.dart';
import 'package:cartafri/core/utils/commons/shared_textfield.dart';
import 'package:cartafri/core/utils/constants/constants.dart';
import 'package:cartafri/features/auth_methods.dart';
import 'package:cartafri/controllers/authController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void loginUser() {
    FireBaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body: isLoading
          ? const Loader()
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AuthIcons(authIcon: Icons.local_dining_outlined),
                    kSizedBox,
                    const Text('WELCOME BACK', style: kTextStyleSpacing),
                    kSizedBox,
                    InputTextWidget(
                      hintText: 'Email Address',
                      iconData: Icons.mail_outline,
                      textInputType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    kSizedBox,
                    InputTextWidget(
                      hintText: 'Password',
                      iconData: Icons.lock_outline,
                      textInputType: TextInputType.visiblePassword,
                      controller: passwordController,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text('Forgot Password',
                              style: kForgetPaswwordStyle),
                        ),
                      ),
                    ),
                    kSizedBox,
                    ExpandedButton(
                      onpress: loginUser,
                      text: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          'LOGIN',
                          style: kTextStyleSpacing,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        onPressed: () {},
                        child:
                            const Text('I have no account', style: kSmallFont)),
                    const SocialAccountButoons(
                      text: Text(
                        'Continue With Google',
                        style: kWTextStyleSpacing,
                      ),
                      socialIcon: FontAwesomeIcons.google,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    const SocialAccountButoons(
                      text: Text(
                        'Continue With Phone',
                        style: kWTextStyleSpacing,
                      ),
                      socialIcon: FontAwesomeIcons.phone,
                    )
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
