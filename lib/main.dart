import 'package:cartafri/screens/AppScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CartAfri());
}

class CartAfri extends StatelessWidget {
  const CartAfri({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
