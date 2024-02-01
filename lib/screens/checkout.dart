import 'package:cartafri/core/constants/constants.dart';
import 'package:cartafri/core/utils/reusables.dart';
import 'package:cartafri/core/utils/shared_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _deliveryController = TextEditingController();
  String _selectedValue = 'PayStack';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Checkout',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          children: [
            const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saved Address',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      CheckoutChip(
                        text: 'Home',
                      ),
                      CheckoutChip(
                        text: 'Office',
                      ),
                      CheckoutChip(
                        text: 'Other',
                      ),
                    ],
                  )
                ]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Address',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                kSizedBox,
                CheckoutInputTextWidget(
                    hintText: 'Address',
                    iconData: Icons.location_on_outlined,
                    controller: _addressController),
                kSizedBox,
                CheckoutInputTextWidget(
                    hintText: 'Delivery Note',
                    iconData: Icons.add_circle_outline_sharp,
                    controller: _deliveryController)
              ],
            ),
            kSizedBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payment Method',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                paymentRadioTile(valueText: 'Paystack'),
                paymentRadioTile(valueText: 'Paypal'),
                paymentRadioTile(valueText: 'Credit card'),
                paymentRadioTile(valueText: 'Cash on Delivery'),
              ],
            ),
            kSizedBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Order amount : \$39.00 ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ),
                kSizedBox,
                Center(
                    child:
                        CustomFilledButton(text: 'PLACE ORDER', onPress: () {}))
              ],
            )
          ],
        ),
      ),
    );
  }

  RadioListTile<String> paymentRadioTile({required String valueText}) {
    return RadioListTile.adaptive(
        visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
        value: valueText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
        groupValue: _selectedValue,
        title: Text(
          valueText,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        onChanged: (value) {
          setState(() {
            _selectedValue = value!;
          });
        });
  }
}

class CheckoutChip extends StatelessWidget {
  const CheckoutChip({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chip(
        label: Text(
          text,
          style: const TextStyle(color: kFormColor2),
        ),
        side: kChipBorder,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
