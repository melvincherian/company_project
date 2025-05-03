import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrandInfoProvider extends ChangeNotifier {
  String _email = '';
  String _siteName = '';
  String _phoneNumber = '';

  String get email => _email;
  String get siteName => _siteName;
  String get phoneNumber => _phoneNumber;

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('user_email') ?? '';
    _siteName = prefs.getString('user_site_name') ?? '';
    _phoneNumber = prefs.getString('user_phone') ?? '';
    notifyListeners();
  }

  Future<void> saveUserData({
    required String email,
    required String siteName,
    required String phone,
  }) async {
    _email = email;
    _siteName = siteName;
    _phoneNumber = phone;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
    await prefs.setString('user_site_name', siteName);
    await prefs.setString('user_phone', phone);

    notifyListeners();
  }
}
