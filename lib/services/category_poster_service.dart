import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryPosterService {
  // Replace with your actual API base URL
  final String baseUrl = 'https://your-api-url.com/api';
  
Future<List<dynamic>> fetchPostersByCategory(String category) async {
  print('Fetching posters for category: $category');
  try {
    final encodedCategory = Uri.encodeComponent(category.toLowerCase());
    final response = await http.get(
      Uri.parse('https://posterbnaobackend.onrender.com/api/poster/$encodedCategory'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        print('API Response: ${response.body}');
        final List<dynamic> data = json.decode(response.body);
        return data;
      } catch (parseError) {
        print('JSON Parse Error: $parseError');
        throw Exception('Failed to parse response: $parseError');
      }
    } else {
      print('HTTP Error: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load posters: ${response.statusCode}');
    }
  } catch (e) {
    print('Network Error: $e');
    throw Exception('Error fetching posters: $e');
  }
}
}