// import 'package:company_project/services/api/add_customer_api.dart';
// import 'package:flutter/material.dart';

// class CreateCustomerProvider extends ChangeNotifier {
//   final CustomerApiServices _apiServices = CustomerApiServices();

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   List<Map<String, dynamic>> _customers = [];
//   List<Map<String, dynamic>> get customers => _customers;

//   Map<String, dynamic>? _user;
//   Map<String, dynamic>? get user => _user;

//   void _setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   /// Add a new customer
//   Future<void> addCustomer({
//     required String userId,
//     required String name,
//     required String email,
//     required String mobile,
//     required String dob,
//     required String address,
//     required String gender,
//     required String anniversaryDate,
//   }) async {
//     _setLoading(true);
//     final success = await _apiServices.addCustomer(
//       userId: userId,
//       name: name,
//       email: email,
//       mobile: mobile,
//       dob: dob,
//       address: address,
//       gender: gender,
//       anniversaryDate: anniversaryDate,
//     );
//     if (success) {
//       await fetchUser(userId);
//     }
//     _setLoading(false);
//   }

//   /// Fetch user and customers
//   Future<void> fetchUser(String userId) async {
//     _setLoading(true);
//     final response = await _apiServices.fetchUser(userId);
//     if (response != null) {
//       _user = response['user'];
//       _customers = List<Map<String, dynamic>>.from(_user?['customers'] ?? []);
//     }
//     _setLoading(false);
//   }

//   /// Delete customer
//   Future<void> deleteCustomer({
//     required String userId,
//     required String customerId,
//   }) async {
//     _setLoading(true);
//     final success = await _apiServices.deleteCustomer(
//       userId: userId,
//       customerId: customerId,
//     );
//     if (success) {
//       await fetchUser(userId);
//     }
//     _setLoading(false);
//   }

//   /// Update customer
//   Future<void> updateCustomer({
//     required String userId,
//     required String customerId,
//     required String name,
//     required String email,
//     required String mobile,
//     required String dob,
//     required String address,
//     required String gender,
//     required String anniversaryDate,
//   }) async {
//     _setLoading(true);
//     final success = await _apiServices.updateCustomer(
//       userId: userId,
//       customerId: customerId,
//       name: name,
//       email: email,
//       mobile: mobile,
//       dob: dob,
//       address: address,
//       gender: gender,
//       anniversaryDate: anniversaryDate,
//     );
//     if (success) {
//       await fetchUser(userId);
//     }
//     _setLoading(false);
//   }
// }



import 'dart:convert';
import 'package:company_project/services/api/add_customer_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateCustomerProvider extends ChangeNotifier {
  final CustomerApiServices _apiServices = CustomerApiServices();
  final String _customersKey = 'customer_list'; // Key for SharedPreferences

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> _customers = [];
  List<Map<String, dynamic>> get customers => _customers;

  Map<String, dynamic>? _user;
  Map<String, dynamic>? get user => _user;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Add a new customer
  Future<void> addCustomer({
    required String userId,
    required String name,
    required String email,
    required String mobile,
    required String dob,
    required String address,
    required String gender,
    required String anniversaryDate,
  }) async {
    _setLoading(true);
    
    try {
      final success = await _apiServices.addCustomer(
        userId: userId,
        name: name,
        email: email,
        mobile: mobile,
        dob: dob,
        address: address,
        gender: gender,
        anniversaryDate: anniversaryDate,
      );
      
      if (success) {
        await fetchUser(userId);
      } else {
        // Add locally if API fails
        final Map<String, dynamic> newCustomer = {
          '_id': DateTime.now().millisecondsSinceEpoch.toString(), // Generate a temporary ID
          'name': name,
          'email': email,
          'mobile': mobile,
          'dob': dob,
          'address': address,
          'gender': gender,
          'anniversaryDate': anniversaryDate,
        };
        
        _customers.add(newCustomer);
        notifyListeners();
      }
    } catch (e) {
      // Add locally if API fails
      final Map<String, dynamic> newCustomer = {
        '_id': DateTime.now().millisecondsSinceEpoch.toString(), // Generate a temporary ID
        'name': name,
        'email': email,
        'mobile': mobile,
        'dob': dob,
        'address': address,
        'gender': gender,
        'anniversaryDate': anniversaryDate,
      };
      
      _customers.add(newCustomer);
      notifyListeners();
    }
    
    _setLoading(false);
  }

  /// Fetch user and customers
  Future<void> fetchUser(String userId) async {
    _setLoading(true);
    
    try {
      final response = await _apiServices.fetchUser(userId);
      if (response != null) {
        _user = response['user'];
        _customers = List<Map<String, dynamic>>.from(_user?['customers'] ?? []);
      }
    } catch (e) {
      print('Error fetching user: $e');
      // If API fails, we keep the existing data
    }
    
    _setLoading(false);
  }

  /// Delete customer
  Future<void> deleteCustomer({
    required String userId,
    required String customerId,
  }) async {
    _setLoading(true);
    
    try {
      final success = await _apiServices.deleteCustomer(
        userId: userId,
        customerId: customerId,
      );
      
      if (success) {
        await fetchUser(userId);
      } else {
        // Remove locally if API fails
        _customers.removeWhere((customer) => customer['_id'] == customerId);
        notifyListeners();
      }
    } catch (e) {
      // Remove locally if API fails
      _customers.removeWhere((customer) => customer['_id'] == customerId);
      notifyListeners();
    }
    
    _setLoading(false);
  }

  /// Update customer
  Future<void> updateCustomer({
    required String userId,
    required String customerId,
    required String name,
    required String email,
    required String mobile,
    required String dob,
    required String address,
    required String gender,
    required String anniversaryDate,
  }) async {
    _setLoading(true);
    
    try {
      final success = await _apiServices.updateCustomer(
        userId: userId,
        customerId: customerId,
        name: name,
        email: email,
        mobile: mobile,
        dob: dob,
        address: address,
        gender: gender,
        anniversaryDate: anniversaryDate,
      );
      
      if (success) {
        await fetchUser(userId);
      } else {
        // Update locally if API fails
        final index = _customers.indexWhere((customer) => customer['_id'] == customerId);
        if (index != -1) {
          _customers[index] = {
            '_id': customerId,
            'name': name,
            'email': email,
            'mobile': mobile,
            'dob': dob,
            'address': address,
            'gender': gender,
            'anniversaryDate': anniversaryDate,
          };
          notifyListeners();
        }
      }
    } catch (e) {
      // Update locally if API fails
      final index = _customers.indexWhere((customer) => customer['_id'] == customerId);
      if (index != -1) {
        _customers[index] = {
          '_id': customerId,
          'name': name,
          'email': email,
          'mobile': mobile,
          'dob': dob,
          'address': address,
          'gender': gender,
          'anniversaryDate': anniversaryDate,
        };
        notifyListeners();
      }
    }
    
    _setLoading(false);
  }
  
  /// Save customers to SharedPreferences
  Future<void> saveCustomersToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String customersJson = jsonEncode(_customers);
      await prefs.setString(_customersKey, customersJson);
    } catch (e) {
      print('Error saving customers to preferences: $e');
    }
  }
  
  /// Load customers from SharedPreferences
  Future<void> loadCustomersFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? customersJson = prefs.getString(_customersKey);
      
      if (customersJson != null && customersJson.isNotEmpty) {
        final List<dynamic> decoded = jsonDecode(customersJson);
        _customers = List<Map<String, dynamic>>.from(decoded);
        notifyListeners();
      }
    } catch (e) {
      print('Error loading customers from preferences: $e');
    }
  }
  
  /// Clear all customers from SharedPreferences
  Future<void> clearCustomersFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_customersKey);
      _customers = [];
      notifyListeners();
    } catch (e) {
      print('Error clearing customers from preferences: $e');
    }
  }
}