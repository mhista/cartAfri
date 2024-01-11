import 'package:cartafri/core/utils/reusables.dart';
import 'package:cartafri/core/utils/shared_textfield.dart';
import "package:cartafri/core/constants/constants.dart";
import 'package:cartafri/services/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
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
                  child: const Text('I have no account', style: kSmallFont)),
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
