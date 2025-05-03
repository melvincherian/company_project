import 'dart:convert';
import 'package:http/http.dart' as http;

class FestivalPosterService {
  static const String _baseUrl = 'https://posterbnaobackend.onrender.com/api';
  
  // Format date for API request
  static String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
  
  // Fetch festival posters by date
  static Future<Map<String, List<Map<String, dynamic>>>> fetchFestivalPostersByDate(DateTime date) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/poster/festival'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'festivalDate': _formatDate(date)}),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> posters = jsonDecode(response.body);
        
        // Group posters by category
        final Map<String, List<Map<String, dynamic>>> categorizedPosters = {};
        
        for (var poster in posters) {
          final Map<String, dynamic> posterData = Map<String, dynamic>.from(poster);
          final String category = posterData['category'] ?? 'Uncategorized';
          
          if (!categorizedPosters.containsKey(category)) {
            categorizedPosters[category] = [];
          }
          
          categorizedPosters[category]!.add(posterData);
        }
        
        return categorizedPosters;
      } else {
        throw Exception('Failed to load festival posters: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching festival posters: $e');
    }
  }
  
  // Fetch festival poster details by ID
  static Future<Map<String, dynamic>> fetchPosterDetails(String posterId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/poster/$posterId'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load poster details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching poster details: $e');
    }
  }
  
  // Search festival posters
  static Future<List<Map<String, dynamic>>> searchPosters(String query) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/poster/search'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'query': query}),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> results = jsonDecode(response.body);
        return results.map((result) => Map<String, dynamic>.from(result)).toList();
      } else {
        throw Exception('Failed to search posters: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching posters: $e');
    }
  }
  
  // Save or update favorite poster
  static Future<bool> toggleFavoritePoster(String userId, String posterId) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/user/favorite'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'posterId': posterId,
        }),
      );
      
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error toggling favorite poster: $e');
    }
  }
  
  // Get user's favorite posters
  static Future<List<Map<String, dynamic>>> getFavoritePosters(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/user/$userId/favorites'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> favorites = jsonDecode(response.body);
        return favorites.map((fav) => Map<String, dynamic>.from(fav)).toList();
      } else {
        throw Exception('Failed to load favorite posters: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching favorite posters: $e');
    }
  }
  
  // Submit a new festival poster
  static Future<Map<String, dynamic>> submitPoster(Map<String, dynamic> posterData) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/poster/submit'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(posterData),
      );
      
      if (response.statusCode == 201) {
        return Map<String, dynamic>.from(jsonDecode(response.body));
      } else {
        throw Exception('Failed to submit poster: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error submitting poster: $e');
    }
  }
}