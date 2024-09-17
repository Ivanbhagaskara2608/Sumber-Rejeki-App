import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class SharedPreferencesHelper {
  // Save token
  static Future<void> saveToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", value);
    // Save the current date and time when token is saved
    await saveTokenExpiryDate();
  }

  // Save role
  static Future<void> saveRole(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("role", value);
  }

  // Get token
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  // Get role
  static Future<String?> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("role");
  }

  // Clear token
  static Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await deleteTokenExpiryDate();
  }

  // Clear role
  static Future<void> clearRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("role");
  }

  static Future<void> saveTokenExpiryDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime expiryTime = DateTime.now().add(const Duration(minutes: 1));
    String formattedExpiryTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(expiryTime);
    await prefs.setString("token_expiry_date", formattedExpiryTime);
  }

  // Get token expiry date
  static Future<String?> getTokenExpiryDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token_expiry_date");
  }

  // Delete token expiry date
  static Future<void> deleteTokenExpiryDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token_expiry_date");
  }
}
