import 'package:company_project/models/category_main_model.dart';
import 'package:company_project/services/api/category_main_service.dart';
import 'package:flutter/material.dart';
 // Replace with your service file path

class CategoryMainProvider with ChangeNotifier {
final CategoryMainService _service = CategoryMainService();

  List<MainCategoryModel> _categories = [];
  bool _isLoading = false;
  String? _error;
 
  List<MainCategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void>fetchCategories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
       print('gggggggggg$_categories');
      _categories = await _service.fetchAllCategories();
      print(_categories);
      // This calls your service function
    } 
    
    catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
