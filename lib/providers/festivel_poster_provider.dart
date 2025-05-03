import 'package:company_project/models/festivel_poster_model.dart';
import 'package:company_project/services/api/festivel_poster_service.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

class FestivalPosterProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  // Store posters categorized by their category
  Map<String, List<FestivalPoster>> _categorizedPosters = {};
  UnmodifiableMapView<String, List<FestivalPoster>> get categorizedPosters => 
      UnmodifiableMapView(_categorizedPosters);
  
  // Current selected date for fetching posters
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  
  // Selected poster for viewing details
  FestivalPoster? _selectedPoster;
  FestivalPoster? get selectedPoster => _selectedPoster;
  
  // List of favorite poster IDs
  List<String> _favoritePosters = [];
  UnmodifiableListView<String> get favoritePosters => 
      UnmodifiableListView(_favoritePosters);
  
  // Search results
  List<FestivalPoster> _searchResults = [];
  UnmodifiableListView<FestivalPoster> get searchResults => 
      UnmodifiableListView(_searchResults);
  
  // Error message
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Fetch posters for a specific date
  Future<void> fetchPostersByDate(DateTime date) async {
    _selectedDate = date;
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
    
    try {
      final result = await FestivalPosterService.fetchFestivalPostersByDate(date);
      
      _categorizedPosters = {};
      
      result.forEach((category, posters) {
        _categorizedPosters[category] = posters
            .map((poster) => FestivalPoster.fromJson(poster))
            .toList();
      });
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load festival posters: $e';
      notifyListeners();
    }
  }
  
  // Select a poster to view details
  Future<void> selectPoster(String posterId) async {
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
    
    try {
      final posterDetails = await FestivalPosterService.fetchPosterDetails(posterId);
      _selectedPoster = FestivalPoster.fromJson(posterDetails);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load poster details: $e';
      notifyListeners();
    }
  }
  
  // Clear selected poster
  void clearSelectedPoster() {
    _selectedPoster = null;
    notifyListeners();
  }
  
  // Search posters
  Future<void> searchPosters(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }
    
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
    
    try {
      final results = await FestivalPosterService.searchPosters(query);
      _searchResults = results.map((result) => FestivalPoster.fromJson(result)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Search failed: $e';
      notifyListeners();
    }
  }
  
  // Load user's favorite posters
  Future<void> loadFavoritePosters(String userId) async {
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
    
    try {
      final favorites = await FestivalPosterService.getFavoritePosters(userId);
      _favoritePosters = favorites.map((fav) => fav['_id'] as String).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load favorites: $e';
      notifyListeners();
    }
  }
  
  // Toggle poster as favorite
  Future<void> toggleFavoritePoster(String userId, String posterId) async {
    try {
      final success = await FestivalPosterService.toggleFavoritePoster(userId, posterId);
      
      if (success) {
        if (_favoritePosters.contains(posterId)) {
          _favoritePosters.remove(posterId);
        } else {
          _favoritePosters.add(posterId);
        }
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Failed to update favorite: $e';
      notifyListeners();
    }
  }
  
  // Check if a poster is favorite
  bool isPosterFavorite(String posterId) {
    return _favoritePosters.contains(posterId);
  }
  
  // Submit a new poster
  Future<bool> submitPoster(Map<String, dynamic> posterData) async {
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
    
    try {
      await FestivalPosterService.submitPoster(posterData);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to submit poster: $e';
      notifyListeners();
      return false;
    }
  }
  
  // Reset error message
  void resetError() {
    _errorMessage = null;
    notifyListeners();
  }
}