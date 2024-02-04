import 'package:cartafri/core/constants/color_constants.dart';
import 'package:cartafri/core/constants/constants.dart';
import 'package:cartafri/core/utils/error_test.dart';
import 'package:cartafri/core/utils/isLoading.dart';
import 'package:cartafri/features/auth/controller/authController.dart';
import 'package:cartafri/firebase_options.dart';
import 'package:cartafri/features/auth/models/user_model.dart';
import 'package:cartafri/router.dart';
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
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor:
                  ColorConstants.kScafffoldBackgroundColorD,
              dialogBackgroundColor: ColorConstants.kScafffoldBackgroundColorD,
              // colorScheme: ColorScheme.fromSeed(
              //   seedColor: const Color(0xff4065f4),
              // ),
              chipTheme: ChipThemeData(
                  backgroundColor: ColorConstants.kScafffoldBackgroundColorD),
              cardTheme: const CardTheme(
                shadowColor: ColorConstants.kCardColorD,
                surfaceTintColor: ColorConstants.kCardColorD,
                color: ColorConstants.kCardColorD,
                elevation: 2.0,
              ),
              bottomSheetTheme: const BottomSheetThemeData(
                modalBackgroundColor: ColorConstants.kCardColorD,
              ),
              navigationBarTheme: NavigationBarThemeData(
                backgroundColor: ColorConstants.kCardColorD,
                indicatorColor: ColorConstants.kButtonColorOpaque,
                surfaceTintColor: ColorConstants.kCardColorD,
                indicatorShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: ColorConstants.kCardColorD,
                  splashColor: ColorConstants.kCardColorD,
                  foregroundColor: ColorConstants.kCardColorD),
              appBarTheme: AppBarTheme(
                backgroundColor: ColorConstants.kScafffoldBackgroundColorD,
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
        shadowColor: ColorConstants.kCardColor,
        surfaceTintColor: ColorConstants.kCardColor,
        color: ColorConstants.kCardColor,
        elevation: 2.0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: ColorConstants.kCardColor,
        indicatorColor: ColorConstants.kButtonColorOpaque,
        surfaceTintColor: ColorConstants.kCardColor,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ColorConstants.kCardColor,
          splashColor: ColorConstants.kCardColor,
          foregroundColor: ColorConstants.kCardColor),
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
