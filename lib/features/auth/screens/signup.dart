import 'package:cartafri/core/utils/isLoading.dart';
import 'package:cartafri/core/utils/reusables.dart';
import 'package:cartafri/core/utils/shared_textfield.dart';
import "package:cartafri/core/constants/constants.dart";
import 'package:cartafri/features/auth/auth_methods.dart';
import 'package:cartafri/features/auth/controller/authController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final TextEditingController passwordController2 = TextEditingController();
  void signUpUser() async {
    print(emailController.text);
    FireBaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: isLoading
            ? const Loader()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AuthIcons(authIcon: Icons.local_dining_outlined),
                  kSizedBox,
                  const Text('CREATE ACCOUNT', style: kTextStyleSpacing),
                  kSizedBox,
                  // InputTextWidget(
                  //   hintText: 'Name',
                  //   iconData: Icons.person,
                  //   controller: nameController,
                  // ),
                  // kSizedBox,
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
                  kSizedBox,
                  ExpandedButton(
                    onpress: signUpUser,
                    text: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        'REGISTER',
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
                      child: const Text('I have an account already',
                          style: kSmallFont)),
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
                  const PhoneSigning(
                    text: Text(
                      'Continue With Phone',
                      style: kWTextStyleSpacing,
                    ),
                    socialIcon: FontAwesomeIcons.phone,
                  )
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }
}
