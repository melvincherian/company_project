import 'package:company_project/models/poster_model.dart';
import 'package:company_project/services/api/poster_service.dart';
import 'package:flutter/material.dart';

class PosterProvider extends ChangeNotifier {
  final PosterService _service = PosterService();

  // Add these state variables
  List<TemplateModel> _posters = [];
  bool _isLoading = false;
  String? _error;

  // Add these getters
  List<TemplateModel> get posters => _posters;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchPosters() async {
    print('PosterProvider: Starting fetchPosters');
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      print('PosterProvider: Calling service.fetchTemplates()');
      _posters = await _service.fetchTemplates();
      print('PosterProvider: Fetched ${_posters.length} posters');
      
      // Debug: Print first poster if available
      if (_posters.isNotEmpty) {
        print('First poster: ${_posters[0].name}, Category: ${_posters[0].categoryName}');
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