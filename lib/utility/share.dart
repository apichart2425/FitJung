import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {

  static void saveLastLogin(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_login', email);
  }

  static Future<String> loadLastLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('last_login'));
  }

}