// import 'package:company_project/models/poster_model.dart';
// import 'package:flutter/material.dart';
// import 'package:company_project/services/category_poster_service.dart';
 
// class CategoryPosterProvider extends ChangeNotifier {
//   final CategoryPosterService _categoryPosterService = CategoryPosterService();
  
//   List<TemplateModel> _categoryPosters = [];
//   bool _isLoading = false;
//   String _error = '';
//   String _currentCategory = '';
  
//   // Getters
//   List<TemplateModel> get categoryPosters => _categoryPosters;
//   bool get isLoading => _isLoading;
//   String get error => _error;
//   String get currentCategory => _currentCategory;
  
//   Future<void> fetchPostersByCategory(String category) async {
//     // If we're already loading the same category, don't duplicate the request
//     if (_isLoading && _currentCategory == category) return;
    
//     _isLoading = true;
//     _error = '';
//     _currentCategory = category;
//     notifyListeners();
    
//     try {
//       final posterData = await _categoryPosterService.fetchPostersByCategory(category);
      
//       // Clear the old posters and add the new ones
//       _categoryPosters = posterData.map((posterJson) => TemplateModel.fromJson(posterJson)).toList();
//       _isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       _isLoading = false;
//       _error = e.toString();
//       notifyListeners();
//     }
//   }
// }



import 'package:company_project/services/category_poster_service.dart';
import 'package:flutter/material.dart';
import 'package:company_project/models/category_modell.dart';

class CategoryPosterProvider extends ChangeNotifier {
  final CategoryPosterService _service = CategoryPosterService();
  List<CategoryModel> _categoryPosters = [];
  bool _isLoading = false;
  String _error = '';

  List<CategoryModel> get categoryPosters => _categoryPosters;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchPostersByCategory(String category) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final posters = await _service.fetchPostersByCategory(category);
      _categoryPosters = posters;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      print('Error in CategoryPosterProvider: $e');
    }
  }
}