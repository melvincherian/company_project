import 'package:company_project/models/category_model.dart';
import 'package:company_project/services/api/category_services.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryServices _services = CategoryServices();

  List<CategoryModel> _categories = [];

  bool _isLoading = false;
  String? _error;

  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;

  String? get error => _error;

Future<void> fetchCategories() async {
  _isLoading = true;
  _error = null;
  notifyListeners();

  try {
    _categories = await _services.fetchCategory();
    print("Fetched categories: $_categories");
  } catch (e) {
    _error = e.toString();
    print("Error fetching categories: $_error");
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}

}
