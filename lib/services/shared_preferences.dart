import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<void> saveToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", value);
  }

  static Future<void> saveRole(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("role", value);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  static Future<String?> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("role");
  }

  static Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }

  static Future<void> clearRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("role");
  }
}
