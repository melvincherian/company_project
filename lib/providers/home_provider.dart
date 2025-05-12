import 'package:company_project/models/category_modell.dart';
import 'package:company_project/models/poster_model.dart';
import 'package:company_project/services/api/poster_service.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final PosterService _service = PosterService();

  // Add these state variables
  List<CategoryModel> _homeposters = [];
  bool _isLoading = false;
  String? _error;

  // Add these getters
  List<CategoryModel> get homeposters => _homeposters;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchPosters() async {
    print('PosterProvider: Starting fetchPosters');
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      print('PosterProvider: Calling service.fetchTemplates()');
      _homeposters = await _service.fetchTemplates();
      print('PosterProvider: Fetched ${_homeposters.length} posters');
      
      // Debug: Print first poster if available
      if (_homeposters.isNotEmpty) {
        print('First poster: ${_homeposters[0].name}, Category: ${_homeposters[0].categoryName}');
      } else {
        print('No posters fetched from service');
      }
      
    } catch (e) {
      print('PosterProvider Error: $e');
      _error = 'Failed to load posters: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}