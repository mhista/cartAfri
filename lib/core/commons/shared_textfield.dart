import 'package:cartafri/core/constants/constants.dart';
import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  final String hintText;
  final IconData iconData;

  const InputTextWidget(
      {super.key, required this.hintText, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: Colors.black,
      ),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 11),
          hintText: hintText,
          hintStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: kButtonColor,
              borderRadius: BorderRadius.circular(8.0),
              child: Icon(
                iconData,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
          filled: true,
          fillColor: kFormColor,
          focusedBorder: kOutlineInputBorder,
          enabledBorder: kOutlineInputBorder),
    );
  }
}
