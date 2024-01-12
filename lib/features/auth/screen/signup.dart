import 'package:cartafri/core/utils/reusables.dart';
import 'package:cartafri/core/utils/shared_textfield.dart';
import "package:cartafri/core/constants/constants.dart";
import 'package:cartafri/services/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
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
              child:
                  const Text('I have an account already', style: kSmallFont)),
          SocialAccountButoons(
            onpress: () {
              FireBaseAuthMethods(FirebaseAuth.instance)
                  .signInWithGoogle(context);
            },
            text: const Text(
              'Continue With Google',
              style: kWTextStyleSpacing,
            ),
            socialIcon: FontAwesomeIcons.google,
          ),
          const SizedBox(
            height: 12.0,
          ),
          SocialAccountButoons(
            onpress: () {},
            text: const Text(
              'Continue With Phone',
              style: kWTextStyleSpacing,
            ),
            socialIcon: FontAwesomeIcons.phone,
          )
        ],
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
