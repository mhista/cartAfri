import "package:cartafri/core/commons/reusables.dart";
import "package:cartafri/core/constants/constants.dart";
import "package:flutter/material.dart";

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthIcons(authIcon: Icons.local_dining_outlined),
            Text(
              'CREATE ACCOUNT',
              style: kMediumFont,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Email Address',
                  prefixIcon: Icon(Icons.mail_outline),
                  filled: true,
                  fillColor: Colors.grey,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  )),
            ),
            ExpandedButton(onpress: () {}, title: 'Sign Up')
          ],
        ),
      ),
    );
  }
}
