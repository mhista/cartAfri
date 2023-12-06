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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AuthIcons(authIcon: Icons.local_dining_outlined),
            const Text(
              'CREATE ACCOUNT',
              style: kMediumFont,
            ),
            const InputTextWidget(
              hintText: 'Email Address',
              iconData: Icons.mail_outline,
            ),
            ExpandedButton(
              onpress: () {},
              text: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Sign Up'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
