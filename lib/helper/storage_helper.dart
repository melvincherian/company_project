import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:company_project/models/user_model.dart';

class AuthPreferences {
  // Key constants
  static const String userKey = 'user_data';
  static const String tokenKey = 'auth_token';
  static const String isLoggedInKey = 'is_logged_in';
  static const String isVerifiedKey = 'is_verified';  // New key for verification status

  // Save user data to SharedPreferences
  static Future<bool> saveUserData(LoginResponse userData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Save the complete user object as JSON string
      await prefs.setString(userKey, jsonEncode(userData.toJson()));
      
      // Save token separately for easy access
      await prefs.setString(tokenKey, userData.token);
      
      // Set logged in status
      await prefs.setBool(isLoggedInKey, true);
      
      return true;
    } catch (e) {
      print('Error saving user data: $e');
      return false;
    }
  }

  // Get saved user data
  static Future<LoginResponse?> getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      final userDataString = prefs.getString(userKey);
      if (userDataString == null) return null;
      
      final Map<String, dynamic> userDataMap = jsonDecode(userDataString);
      return LoginResponse.fromJson(userDataMap);
    } catch (e) {
      print('Error retrieving user data: $e');
      return null;
    }
  }

  // Get token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }
  
  // Set user as verified (call this after OTP verification)
  static Future<bool> setUserVerified() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(isVerifiedKey, true);
      return true;
    } catch (e) {
      print('Error setting user verified: $e');
      return false;
    }
  }
  
  // Check if user is verified
  static Future<bool> isUserVerified() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isVerifiedKey) ?? false;
  }

  // Clear user data (for logout)
  static Future<bool> clearUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(userKey);
      await prefs.remove(tokenKey);
      await prefs.setBool(isLoggedInKey, false);
      await prefs.setBool(isVerifiedKey, false);
      return true;
    } catch (e) {
      print('Error clearing user data: $e');
      return false;
    }
  }
}