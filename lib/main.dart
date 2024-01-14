import 'package:cartafri/core/constants/constants.dart';
import 'package:cartafri/firebase_options.dart';
import 'package:cartafri/models/product_model.dart';
import 'package:cartafri/screens/AppScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import

final cartProvider =
    StateNotifierProvider<CartProvider, Cart>((ref) => CartProvider());

void main() async {
  // var theming = Themeing();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: CartAfri(theme: theming)));
}

class CartAfri extends StatelessWidget {
  const CartAfri({Key? key, required this.theme}) : super(key: key);
  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff4065f4),
        ),
        cardTheme: const CardTheme(
          shadowColor: kCardColor,
          surfaceTintColor: kCardColor,
          color: kCardColor,
          elevation: 2.0,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: kCardColor,
          indicatorColor: kButtonColorOpaque,
          surfaceTintColor: kCardColor,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: kCardColor,
            splashColor: kCardColor,
            foregroundColor: kCardColor),
        appBarTheme: AppBarTheme(
          surfaceTintColor: null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          scrolledUnderElevation: 0.0,
          elevation: 0.0,
        ),
      ),
      // ThemeData.dark(
      //   useMaterial3: true,
      // ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Themeing {
  ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xff4065f4),
      ),
      cardTheme: const CardTheme(
        shadowColor: kCardColor,
        surfaceTintColor: kCardColor,
        color: kCardColor,
        elevation: 2.0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: kCardColor,
        indicatorColor: kButtonColorOpaque,
        surfaceTintColor: kCardColor,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: kCardColor,
          splashColor: kCardColor,
          foregroundColor: kCardColor),
      appBarTheme: AppBarTheme(
        surfaceTintColor: null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
      ),
    );
  }
}

ThemeData theming = Themeing().lightTheme();
