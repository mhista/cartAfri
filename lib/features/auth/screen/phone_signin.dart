import 'package:cartafri/core/utils/reusables.dart';
import 'package:cartafri/core/utils/shared_textfield.dart';
import "package:cartafri/core/constants/constants.dart";
import 'package:cartafri/services/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class PhoneSignIn extends StatefulWidget {
  const PhoneSignIn({super.key});

  @override
  State<PhoneSignIn> createState() => _PhoneSignInState();
}

class _PhoneSignInState extends State<PhoneSignIn> {
  final TextEditingController phoneController = TextEditingController();

  void phoneSignIn() {
    FireBaseAuthMethods(FirebaseAuth.instance)
        .phoneSignIn(context, phoneController.text);
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
              const Text(
                'SIGN IN WITH PHONE',
                style: kTextStyleSpacing,
              ),
              kSizedBox,
              InputTextWidget(
                hintText: 'Phone Number',
                iconData: Icons.mail_outline,
                textInputType: TextInputType.phone,
                controller: phoneController,
              ),
              kSizedBox,
              ExpandedButton(
                onpress: () {
                  FireBaseAuthMethods(FirebaseAuth.instance)
                      .signInWithGoogle(context);
                },
                text: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'SIGN IN',
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
                  onPressed: () {
                    FireBaseAuthMethods(FirebaseAuth.instance)
                        .signInWithGoogle(context);
                  },
                  child: const Text('I have no account', style: kSmallFont)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }
}
