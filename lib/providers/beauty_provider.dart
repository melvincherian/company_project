// import 'package:company_project/models/beauty_model.dart';

// import 'package:company_project/services/api/beauty_services.dart';

// import 'package:flutter/material.dart';

// class BeautyProvider extends ChangeNotifier {
//   final BeautyServices _services = BeautyServices();

//   List<BeautyModel> _beauty = [];
//   bool _isLoading = false;
//   String? _error;

//   List<BeautyModel> get beauty => _beauty;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   Future<void> fetchBeauty() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       _beauty = await _services.fetchBeauty();
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
