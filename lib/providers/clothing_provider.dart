// import 'package:company_project/models/clothing_model.dart';
// import 'package:company_project/services/api/clothing_services.dart';
// import 'package:flutter/material.dart';

// class ClothingProvider extends ChangeNotifier {
//   final ClothingServices _services = ClothingServices();

//   List<ClothingModel> _clothing = [];
//   bool _isLoading = false;
//   String? _error;

//   List<ClothingModel> get clothing => _clothing;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   Future<void> fetchClothing() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       _clothing = await _services.fetchClothing(); 
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
