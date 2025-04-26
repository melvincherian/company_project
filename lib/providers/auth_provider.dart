// import 'package:company_project/models/user_model.dart';
// import 'package:company_project/services/api/authservice.dart';
// import 'package:flutter/material.dart';

// class AuthProvider extends ChangeNotifier{
//   final Authservice _authservice=Authservice();

//   LoginResponse?_user;

//   LoginResponse?get user=>_user;

//   Future<bool>login(String mobile)async{
//     try{
//       final userData=await _authservice.login(mobile);
//       _user=userData;
//       notifyListeners();
//       return true;

//     }catch(e){
//       return false;
//     }
//   }

//   void setUser(LoginResponse user)async{
//     _user=user;
    
//   }
// }




import 'package:company_project/helper/storage_helper.dart';
import 'package:company_project/models/user_model.dart';
import 'package:company_project/services/api/authservice.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final Authservice _authservice = Authservice();
  
  LoginResponse? _user;
  
  LoginResponse? get user => _user;
  
  // Initialize method to load saved user on app start
  Future<void> initialize() async {
    _user = await AuthPreferences.getUserData();
    notifyListeners();
  }

  Future<bool> login(String mobile) async {
    try {
      final userData = await _authservice.login(mobile);
      if (userData != null) {
        _user = userData;
        // Save to SharedPreferences
        await AuthPreferences.saveUserData(userData);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  void setUser(LoginResponse user) async {
    _user = user;
    // Save to SharedPreferences
    await AuthPreferences.saveUserData(user);
    notifyListeners();
  }
  
  // Method to handle logout
  Future<bool> logout() async {
    try {
      final result = await AuthPreferences.clearUserData();
      if (result) {
        _user = null;
        notifyListeners();
      }
      return result;
    } catch (e) {
      return false;
    }
  }
  
  // Method to check if user is logged in
  Future<bool> isLoggedIn() async {
    return await AuthPreferences.isLoggedIn();
  }
}