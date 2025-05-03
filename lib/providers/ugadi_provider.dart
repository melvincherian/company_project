// import 'package:company_project/models/ugadi_model.dart';
// import 'package:company_project/services/api/ugadi_service.dart';

// import 'package:flutter/material.dart';

// class UgadiProvider extends ChangeNotifier {
//   final UgadiService _services = UgadiService();

//   List<UgadiModel> _ugadi = [];
//   bool _isLoading = false;
//   String? _error;

//   List<UgadiModel> get ugadi => _ugadi;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   Future<void> fetchUgadi() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       _ugadi = await _services.fetchUgadies();
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
