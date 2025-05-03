// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class CategoryPosterService {
//   // Replace with your actual API base URL
//   final String baseUrl = 'https://posterbnaobackend.onrender.com/api/category/getall-cateogry';
  
// Future<List<dynamic>> fetchPostersByCategory(String category) async {
//   print('Fetching posters for category: $category');
//   try {
 
//     final response = await http.get(
//       Uri.parse('https://posterbnaobackend.onrender.com/api/category/getall-cateogry'),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       try {
//         print('API Response: ${response.body}');
//         final List<dynamic> data = json.decode(response.body);
//         return data;
//       } catch (parseError) {
//         print('JSON Parse Error: $parseError');
//         throw Exception('Failed to parse response: $parseError');
//       }
//     } else {
//       print('HTTP Error: ${response.statusCode}');
//       print('Response body: ${response.body}');
//       throw Exception('Failed to load posters: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Network Error: $e');
//     throw Exception('Error fetching posters: $e');
//   }
// }
// }




import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryPosterService {
  // Base URL for API
  final String baseUrl = 'https://posterbnaobackend.onrender.com/api';
  
  Future<List<dynamic>> fetchPostersByCategory(String category) async {
    print('Fetching posters for category: $category');
    try {
      // Make API request
      final response = await http.get(
        Uri.parse('$baseUrl/category/getall-cateogry'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        try {
          print('API Response: ${response.body}');
          // Parse the JSON response - it's an object, not a list
          final Map<String, dynamic> responseData = json.decode(response.body);
          
          // Check if the response contains categories array
          if (responseData.containsKey('categories') && responseData['categories'] is List) {
            // Return the categories list
            return responseData['categories'];
          } else {
            print('No categories found in response');
            return [];
          }
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