import "package:cartafri/core/commons/reusables.dart";
import "package:cartafri/core/commons/shared_textfield.dart";
import "package:cartafri/core/constants/constants.dart";
import "package:flutter/material.dart";

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              const InputTextWidget(
                hintText: 'Email Address',
                iconData: Icons.mail_outline,
                textInputType: TextInputType.emailAddress,
              ),
              kSizedBox,
              const InputTextWidget(
                hintText: 'Password',
                iconData: Icons.lock_outline,
                textInputType: TextInputType.visiblePassword,
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
                onpress: () {},
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
}
