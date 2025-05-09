import 'dart:convert';
import 'package:company_project/models/category_main_model.dart';
import 'package:company_project/models/category_modell.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  final String baseUrl = 'https://posterbnaobackend.onrender.com';

  // Map of category names to their API endpoints
  final Map<String, String> _endpoints = {
    'ugadi': '/api/poster/ugadiposter',
    'chemical': '/api/poster/chemicalposter',
    'beauty': '/api/poster/beautyposter',
    'clothing': '/api/poster/clothingposter',
    // Add more categories and their endpoints as needed
  };

  Future<List<CategoryModel>> fetchCategoryItems(String category) async {
    if (!_endpoints.containsKey(category.toLowerCase())) {
      throw Exception('Unknown category: $category');
    }

    final endpoint = _endpoints[category.toLowerCase()];
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      
      // Use the factory constructor instead of a static method
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load $category data: ${response.statusCode}');
    }
  }



   Future<List<MainCategoryModel>> fetchAllCategories() async {
  
    // final endpoint = _endpoints[category.toLowerCase()];
    final response = await http.get(Uri.parse('$baseUrl/category/getall-categry'));
      
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      
      // Use the factory constructor instead of a static method
      return data.map((json) => MainCategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load  data: ${response.statusCode}');
    }
  }


    Future<List<CategoryModel>> fetchPostersByCategory(String category) async {
    print('Fetching posters for category: $category');
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/poster/$category'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        try {
          print('API Response successful');
          // Parse the JSON response - it's a direct list based on the sample data
          final List<dynamic> data = json.decode(response.body);
          return data.map((item) => CategoryModel.fromJson(item)).toList();
        } catch (parseError) {
          print('JSON Parse Error: $parseError');
          throw Exception('Failed to parse response: $parseError');
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load $category: ${response.statusCode}');
      }
    } catch (e) {
      print('Network Error: $e');
      throw Exception('Error fetching $category: $e');
    }
  }

}