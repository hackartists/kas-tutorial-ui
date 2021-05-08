import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static String username = "username";
  static String address = "address";
  static String password = "password";
  static String timestamp = "timestamp";

  static void saveAuthentication(String uid, String pw) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString(username, uid);
    await preferences.setString(password, pw);
  }

  static void saveAccountAddress(String addr) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(address, addr);
  }

  static void saveTimestamp(int ts) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(timestamp, ts);
  }

  static Future<String> getAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(address);
  }

  static Future<String> getUsername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(username);
  }

  static Future<String> getPassword() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(password);
  }

  static Future<int> getTimestamp() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(timestamp);
  }
}
