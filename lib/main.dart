import 'package:cartafri/core/constants/constants.dart';
import 'package:cartafri/core/utils/error_test.dart';
import 'package:cartafri/core/utils/isLoading.dart';
import 'package:cartafri/features/auth/controller/authController.dart';
import 'package:cartafri/firebase_options.dart';
import 'package:cartafri/features/products/product_model.dart';
import 'package:cartafri/features/auth/models/user_model.dart';
import 'package:cartafri/router.dart';
import 'package:cartafri/screens/AppScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
// import

// final cartProvider =
//     StateNotifierProvider<CartProvider, Cart>((ref) => CartProvider());

void main() async {
  // var theming = Themeing();
  // Initialisez the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: CartAfri()));
}

class CartAfri extends ConsumerStatefulWidget {
  const CartAfri({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartAfriState();
}

class _CartAfriState extends ConsumerState<CartAfri> {
  UserModel? userModel;
  // gets the user data
  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (data) => MaterialApp.router(
            routerDelegate: RoutemasterDelegate(
              routesBuilder: (context) {
                if (data != null) {
                  getData(ref, data);
                  if (userModel != null) {
                    return loggedInRoute;
                  }
                }
                return loggedOutRoute;
              },
            ),
            routeInformationParser: const RoutemasterParser(),
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                scrolledUnderElevation: 0.0,
                elevation: 0.0,
              ),
            ),
            // ThemeData.dark(
            //   useMaterial3: true,
            // ),
            debugShowCheckedModeBanner: false,
          ),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
    ;
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
