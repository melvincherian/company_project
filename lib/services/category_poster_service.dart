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

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:company_project/models/category_modell.dart';

// class CategoryPosterService {
//   // Base URL for API
//   final String baseUrl = 'https://posterbnaobackend.onrender.com/api';
  
//   Future<List<CategoryModel>> fetchPostersByCategory(String category) async {
//     print('Fetching posters for category: $category');
//     try {
//       // Make API request with POST method
//       final response = await http.post(
//         Uri.parse('$baseUrl/poster/getposterbycategory'),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         // Include the category name in the request body
//         body: json.encode({
//           "categoryName": category
//         }),
//       );
//       print('meeeeeeeeeeeldvvvdvdfvdfv${response.statusCode}');

//       if (response.statusCode == 200) {
//         try {
//           print('API Response: ${response.body}');
//           // Parse the JSON response - directly as a List since the API returns an array
//           final List responseData = json.decode(response.body);
          
//           // Convert each item to CategoryModel
//           return List.from(
//             responseData.map((item) => CategoryModel.fromJson(item))
//           );
//         } catch (parseError) {
//           print('JSON Parse Error: $parseError');
//           throw Exception('Failed to parse response: $parseError');
//         }
//       } else {
//         print('HTTP Error: ${response.statusCode}');
//         print('Response body: ${response.body}');
//         throw Exception('Failed to load posters: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Network Error: $e');
//       throw Exception('Error fetching posters: $e');
//     }
//   }
// }





// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:company_project/models/category_modell.dart';

// class CategoryPosterService {
//   // Base URL for API
//   final String baseUrl = 'https://posterbnaobackend.onrender.com/api';
  
//   Future<List<CategoryModel>> fetchPostersByCategory(String category) async {
//     print('Fetching posters for category: $category');
//     try {
//       // Build the URL with category as a query parameter
//       final url = Uri.parse('$baseUrl/poster/getposterbycategory?categoryName=$category');
      
//       // Make GET request
//       final response = await http.get(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       print('meeeeeeeeeeeldvvvdvdfvdfv${response.statusCode}');

//       if (response.statusCode == 200) {
//         try {
//           print('API Response: ${response.body}');
//           // Parse the JSON response - directly as a List since the API returns an array
//           final List responseData = json.decode(response.body);
          
//           // Convert each item to CategoryModel
//           return List.from(
//             responseData.map((item) => CategoryModel.fromJson(item))
//           );
//         } catch (parseError) {
//           print('JSON Parse Error: $parseError');
//           throw Exception('Failed to parse response: $parseError');
//         }
//       } else {
//         print('HTTP Error: ${response.statusCode}');
//         print('Response body: ${response.body}');
//         throw Exception('Failed to load posters: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Network Error: $e');
//       throw Exception('Error fetching posters: $e');
//     }
//   }
// }






import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:company_project/models/category_modell.dart';

class CategoryPosterService {
  // Base URL for API
  final String baseUrl = 'https://posterbnaobackend.onrender.com/api';

  Future<List<CategoryModel>> fetchPostersByCategory(String category) async {
    print('Fetching posters for category: $category');
    try {
      // Make GET request using http.Request to send body
      final request = http.Request('GET', Uri.parse('$baseUrl/poster/getposterbycategory'))
        ..headers.addAll({
          'Content-Type': 'application/json',
        })
        ..body = json.encode({
          "categoryName": category,
        });

      final response = await request.send();
      
      final responseString = await response.stream.bytesToString();
      print('Response Status: ${response.statusCode}');
      print('Response Body: $responseString');

      if (response.statusCode == 200) {
        try {
          // Parse the JSON response - directly as a List since the API returns an array
          final List responseData = json.decode(responseString);
          
          // Convert each item to CategoryModel
          return List.from(
            responseData.map((item) => CategoryModel.fromJson(item))
          );
        } catch (parseError) {
          print('JSON Parse Error: $parseError');
          throw Exception('Failed to parse response: $parseError');
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
        print('Response body: $responseString');
        throw Exception('Failed to load posters: ${response.statusCode}');
      }
    } catch (e) {
      print('Network Error: $e');
      throw Exception('Error fetching posters: $e');
    }
  }
}
