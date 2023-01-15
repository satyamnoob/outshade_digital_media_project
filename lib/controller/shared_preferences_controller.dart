import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController {
  static Future<bool> checkingIfIdCredentialsAdded(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) {
      prefs.setBool(key, false);
      return Future.value(false);
    }
    final result = prefs.getBool(key);
    return Future.value(result);
  }

  static updatingCredentialsCheck(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, true);
  }
}
