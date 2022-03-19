import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String SharedPreferencesUserLoggedInKey = "ISLOGGEDIN";
  static String SharedPreferencesUserNameKey = "USERNAMEKEY";
  static String SharedPreferencesUserEmailKey = "USEREMAILKEY";

  static Future<bool> saveuserLoggedInSharedPreferences(
      bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(
        SharedPreferencesUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreferences(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(SharedPreferencesUserNameKey, userName);
  }

  static Future<bool> saveUserEmailSharedPreferences(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(SharedPreferencesUserEmailKey, userEmail);
  }

  static Future<bool?> getuserLoggedInSharedPrefernces() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferencesUserLoggedInKey);
  }

  static Future<String?> getuserNameSharedPrefernces() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferencesUserNameKey);
  }

  static Future<String?> getuserEmailSharedPrefernces() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferencesUserEmailKey);
  }
}
