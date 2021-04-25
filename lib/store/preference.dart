import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static String username = "username";
  static String address = "address";
  static String password = "password";

  static void saveAuthentication(String uid, String pw) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString(username, username);
    await preferences.setString(password, pw);
  }

  static void saveAccountAddress(String addr) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(address, addr);
  }

  static Future<String> getAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(address);
  }
}
