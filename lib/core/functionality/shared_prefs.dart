import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isAppPreviouslyLoaded() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getBool('isAppreviouslyLoaded') ?? false;
}

Future<bool> setAppPreviouslyLoaded() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.setBool('isAppreviouslyLoaded', true);
}
