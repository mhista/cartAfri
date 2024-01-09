import "package:cartafri/core/commons/reusables.dart";
import "package:cartafri/core/commons/shared_textfield.dart";
import "package:cartafri/core/constants/constants.dart";
import "package:flutter/material.dart";

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
              const Text('CREATE ACCOUNT', style: kTextStyleSpacing),
              kSizedBox,
              InputTextWidget(
                hintText: 'Name',
                iconData: Icons.person,
                controller: nameController,
              ),
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
              kSizedBox,
              ExpandedButton(
                onpress: () {},
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
            ],
          ),
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
