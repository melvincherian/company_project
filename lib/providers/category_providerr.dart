import 'package:flutter/material.dart';
import 'package:company_project/models/category_modell.dart';
import 'package:company_project/services/api/category_servicee.dart';

class CategoryProviderr extends ChangeNotifier {
  final CategoryService _service = CategoryService();
  
  // Store items for each category
  final Map<String, List<CategoryModel>> _categoriesData = {};
  
  // Loading states for each category
  final Map<String, bool> _isLoading = {};
  
  // Error states for each category
  final Map<String, String?> _errors = {};

  // Get items for a specific category
  List<CategoryModel> getItemsByCategory(String category) {
    return _categoriesData[category.toLowerCase()] ?? [];
  }

  // Check if a category is loading
  bool isLoadingCategory(String category) {
    return _isLoading[category.toLowerCase()] ?? false;
  }

  // Get error for a category if any
  String? getErrorForCategory(String category) {
    return _errors[category.toLowerCase()];
  }

  // Fetch items for a specific category
  Future<void> fetchCategoryItems(String category) async {
    final lowerCategory = category.toLowerCase();
    
    // Set loading state
    _isLoading[lowerCategory] = true;
    _errors[lowerCategory] = null;
    notifyListeners();

    try {
      // Fetch data from service
      final items = await _service.fetchCategoryItems(lowerCategory);
      _categoriesData[lowerCategory] = items;
    } catch (e) {
      _errors[lowerCategory] = e.toString();
    } finally {
      _isLoading[lowerCategory] = false;
      notifyListeners();
    }
  }

  // Fetch multiple categories at once
  Future<void> fetchMultipleCategories(List<String> categories) async {
    final futures = categories.map((category) => fetchCategoryItems(category));
    await Future.wait(futures);
  }
}