import 'package:cartafri/core/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class Pallete {
  // Colors
  static const blackColor = Color.fromRGBO(1, 1, 1, 1); // primary color
  static const greyColor = Color.fromRGBO(26, 39, 45, 1); // secondary color
  static const drawerColor = Color.fromRGBO(18, 18, 18, 1);
  static const whiteColor = Colors.white;
  static var redColor = Colors.red.shade500;
  static var blueColor = Colors.blue.shade300;

  // Themes
  static var darkModeAppTheme = ThemeData.dark().copyWith(
    snackBarTheme: const SnackBarThemeData(
        backgroundColor: ColorConstants.kCardColorD,
        contentTextStyle: TextStyle(color: Colors.white)),
    dialogTheme: const DialogTheme(
        backgroundColor: ColorConstants.kScafffoldBackgroundColorD),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.kCardColorD,
        textStyle: const TextStyle(color: Colors.white),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      textStyle: const TextStyle(color: ColorConstants.kButtonColor),
    )),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
          textStyle: const TextStyle(color: Colors.white),
          backgroundColor: ColorConstants.kButtonColor),
    ),
    buttonTheme: const ButtonThemeData(buttonColor: ColorConstants.kCardColorD),
    inputDecorationTheme: const InputDecorationTheme(
        fillColor: ColorConstants.kCardColorD, filled: true),
    scaffoldBackgroundColor: ColorConstants.kScafffoldBackgroundColorD,
    // dialogBackgroundColor: ColorConstants.kScafffoldBackgroundColorD,
    chipTheme: const ChipThemeData(
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      scrolledUnderElevation: 0.0,
      elevation: 0.0,
    ),
  );

  static var lightModeAppTheme = ThemeData.light().copyWith(
    snackBarTheme: const SnackBarThemeData(
        backgroundColor: ColorConstants.kCardColorD,
        contentTextStyle: TextStyle(color: Colors.white)),
    dialogTheme: const DialogTheme(
        backgroundColor: ColorConstants.kScafffoldBackgroundColorD),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.kCardColor,
        textStyle: const TextStyle(color: Colors.white),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      textStyle: const TextStyle(color: ColorConstants.kButtonColor),
    )),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
          textStyle: const TextStyle(color: Colors.white),
          backgroundColor: ColorConstants.kButtonColor),
    ),
    buttonTheme: const ButtonThemeData(buttonColor: ColorConstants.kCardColor),
    inputDecorationTheme: const InputDecorationTheme(
        fillColor: ColorConstants.kFormColor, filled: true),
    scaffoldBackgroundColor: ColorConstants.kCardColor,
    // dialogBackgroundColor: ColorConstants.kScafffoldBackgroundColorD,
    chipTheme: const ChipThemeData(backgroundColor: ColorConstants.kCardColor),
    cardTheme: const CardTheme(
      shadowColor: ColorConstants.kCardColor,
      surfaceTintColor: ColorConstants.kCardColor,
      color: ColorConstants.kCardColor,
      elevation: 2.0,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      modalBackgroundColor: ColorConstants.kCardColor,
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
      backgroundColor: ColorConstants.kCardColor,
      surfaceTintColor: null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      scrolledUnderElevation: 0.0,
      elevation: 0.0,
    ),
  );
}

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeMode _mode;
  ThemeNotifier({ThemeMode mode = ThemeMode.dark})
      : _mode = mode,
        super(
          Pallete.darkModeAppTheme,
        ) {
    getTheme();
  }

  ThemeMode get mode => _mode;

  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');

    if (theme == 'light') {
      _mode = ThemeMode.light;
      state = Pallete.lightModeAppTheme;
    } else {
      _mode = ThemeMode.dark;
      state = Pallete.darkModeAppTheme;
    }
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
      state = Pallete.lightModeAppTheme;
      prefs.setString('theme', 'light');
    } else {
      _mode = ThemeMode.dark;
      state = Pallete.darkModeAppTheme;
      prefs.setString('theme', 'dark');
    }
  }
}
