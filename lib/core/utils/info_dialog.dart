import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

void showInfoDialog({
  required BuildContext context,
  required TextEditingController codeController,
  required VoidCallback onPressed,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('congratulations'),
      content: const Column(
        children: [
          Text('your order with order no: 1256, has been confirmed'),
          Text('delivery expected in 3 days')
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Routemaster.of(context).pop();
            },
            child: const Text('Okay'))
      ],
    ),
  );
}
