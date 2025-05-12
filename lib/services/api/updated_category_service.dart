import 'dart:convert';
import 'package:http/http.dart' as http;

class UpdatedCategoryService {
  static const String _baseUrl = 'https://posterbnaobackend.onrender.com/api/poster';

  /// Fetch posters by category
  static Future<List<dynamic>> getPostersByCategory(String category) async {
    final url = Uri.parse('$_baseUrl/getposterbycategory');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'category': category}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Assuming the response has a list under a key like 'data' or is directly a list
        return data is List ? data : data['data'];
      } else {
        throw Exception('Failed to load posters: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching posters by category: $e');
      rethrow;
    }
  }
}
