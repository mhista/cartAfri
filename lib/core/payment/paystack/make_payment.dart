import 'dart:io';

import 'package:cartafri/features/payment/paystack/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class MakePayment {
  MakePayment(
      {required this.context, required this.amount, required this.email});
  final BuildContext context;
  final int amount;
  final String email;
  PaystackPlugin paystackPlugin = PaystackPlugin();

  Future initializePlugin() async {
    await paystackPlugin.initialize(publicKey: SecretKey.publicKey);
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard getCardUI() {
    return PaymentCard(number: '', cvc: '', expiryMonth: 0, expiryYear: 0);
  }

  chargeCardAndMakePayment() async {
    initializePlugin().then((_) async {
      if (paystackPlugin.sdkInitialized) {
        Charge charge = Charge()
          ..amount = amount * 100
          ..email = email
          ..reference = _getReference()
          ..card = getCardUI();

        CheckoutResponse response = await paystackPlugin.checkout(context,
            charge: charge,
            method: CheckoutMethod.card,
            logo: const FlutterLogo(
              size: 24,
            ));
      } else {
        chargeCardAndMakePayment();
      }
    });
  }
}
