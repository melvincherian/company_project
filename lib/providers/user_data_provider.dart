import 'package:company_project/models/get_profile_model.dart';
import 'package:company_project/services/api/user_profile_services.dart';
import 'package:flutter/material.dart';



class UserDataProvider extends ChangeNotifier {
  final UserProfileServices _userService = UserProfileServices();

  UserModel? _user;
  bool _isLoading = false;
  String? _error;
  

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUserData(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _user = await _userService.fetchUserProfile(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
