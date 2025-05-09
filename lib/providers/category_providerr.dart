// import 'package:flutter/material.dart';
// import 'package:company_project/models/category_modell.dart';
// import 'package:company_project/services/api/category_servicee.dart';

// class CategoryProviderr extends ChangeNotifier {
//   final CategoryService _service = CategoryService();

//   // Store items for each category
//   final Map<String, List<CategoryModel>> _categoriesData = {};

//   // Loading states for each category
//   final Map<String, bool> _isLoading = {};

//   // Error states for each category
//   final Map<String, String?> _errors = {};

//   // Get items for a specific category
//   List<CategoryModel> getItemsByCategory(String category) {
//     return _categoriesData[category.toLowerCase()] ?? [];
//   }

//   // Check if a category is loading
//   bool isLoadingCategory(String category) {
//     return _isLoading[category.toLowerCase()] ?? false;
//   }

//   // Get error for a category if any
//   String? getErrorForCategory(String category) {
//     return _errors[category.toLowerCase()];
//   }

//   // Fetch items for a specific category
//   Future<void> fetchCategoryItems(String category) async {
//     final lowerCategory = category.toLowerCase();

//     // Set loading state
//     _isLoading[lowerCategory] = true;
//     _errors[lowerCategory] = null;
//     notifyListeners();

//     try {
//       // Fetch data from service
//       final items = await _service.fetchCategoryItems(lowerCategory);
//       _categoriesData[lowerCategory] = items;
//     } catch (e) {
//       _errors[lowerCategory] = e.toString();
//     } finally {
//       _isLoading[lowerCategory] = false;
//       notifyListeners();
//     }
//   }

//   // Fetch multiple categories at once
//   Future<void> fetchMultipleCategories(List<String> categories) async {
//     final futures = categories.map((category) => fetchCategoryItems(category));
//     await Future.wait(futures);
//   }
// }

import 'package:company_project/models/category_main_model.dart';
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


  //  Future<void> fetchCategories() async {
  //   _isLoading = true;
  //   _error = null;
  //   notifyListeners();

  //   try {
  //     _categories = await fetchAllCategories(); // This calls your service function
  //   } catch (e) {
  //     _error = e.toString();
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Fetch multiple categories at once
  Future<void> fetchMultipleCategories(List<String> categories) async {
    final futures = categories.map((category) => fetchCategoryItems(category));
    await Future.wait(futures);
  }
  

  // Search items across all categories
  List<CategoryModel> searchItems(String query) {

    print('hello$query');
    final lowerQuery = query.toLowerCase();

    // Combine all items from all categories into one list
    final allItems = _categoriesData.values.expand((list) => list).toList();

    // Filter items based on query match with name, title, or description
    return allItems.where((item) {
      return item.name.toLowerCase().contains(lowerQuery) ||
          item.categoryName.toLowerCase().contains(lowerQuery) ||
          item.description.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
