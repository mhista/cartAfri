import 'package:cartafri/core/utils/constants/color_constants.dart';
import 'package:cartafri/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  final String hintText;
  final IconData iconData;
  final TextInputType? textInputType;
  final TextEditingController controller;
  const InputTextWidget(
      {super.key,
      this.textInputType,
      required this.hintText,
      required this.iconData,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Colors.black,
      ),
      keyboardType: textInputType,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          hintText: hintText,
          hintStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: ColorConstants.kButtonColor,
              borderRadius: BorderRadius.circular(8.0),
              child: Icon(
                iconData,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
          focusedBorder: kOutlineInputBorder,
          enabledBorder: kOutlineInputBorder),
    );
  }
}

// CHECKOUT TEXTFIELD
class CheckoutInputTextWidget extends StatelessWidget {
  final String hintText;
  final IconData iconData;
  final TextInputType? textInputType;
  final TextEditingController controller;
  const CheckoutInputTextWidget(
      {super.key,
      this.textInputType,
      required this.hintText,
      required this.iconData,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Colors.black,
      ),
      keyboardType: textInputType,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          hintText: hintText,
          hintStyle: const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 15, color: kFormColor2),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              iconData,
              size: 20,
            ),
          ),
          filled: true,
          fillColor: ColorConstants.kCardColor,
          focusedBorder: kOutlineInputBorder2,
          enabledBorder: kOutlineInputBorder2),
    );
  }
}
