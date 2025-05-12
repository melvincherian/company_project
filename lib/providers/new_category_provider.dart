import 'package:flutter/material.dart';
import 'package:company_project/services/api/updated_category_service.dart';

class NewCategoryProvider extends ChangeNotifier {
  // A map to store posters by category
  Map<String, List<dynamic>> _postersByCategory = {};
  Map<String, bool> _isLoadingByCategory = {};
  Map<String, String?> _errorByCategory = {};

  Map<String, List<dynamic>> get postersByCategory => _postersByCategory;
  Map<String, bool> get isLoadingByCategory => _isLoadingByCategory;
  Map<String, String?> get errorByCategory => _errorByCategory;

  /// Fetch posters for a specific category
  Future<void> fetchPostersByCategory(String category) async {
    _isLoadingByCategory[category] = true;
    _errorByCategory[category] = null;
    notifyListeners();

    try {
      final response = await UpdatedCategoryService.getPostersByCategory(category);
      _postersByCategory[category] = response;
    } catch (e) {
      _errorByCategory[category] = 'Failed to load posters';
    } finally {
      _isLoadingByCategory[category] = false;
      notifyListeners();
    }
  }

  /// Optional: Clear posters for a specific category
  void clearPosters(String category) {
    _postersByCategory[category] = [];
    notifyListeners();
  }

  // Check if the category has posters
  List<dynamic> getPostersByCategory(String category) {
    return _postersByCategory[category] ?? [];
  }

  bool isLoadingCategory(String category) {
    return _isLoadingByCategory[category] ?? false;
  }

  String? getErrorForCategory(String category) {
    return _errorByCategory[category];
  }
}
