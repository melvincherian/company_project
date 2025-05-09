import 'dart:convert';
import 'package:company_project/models/category_main_model.dart';
import 'package:http/http.dart' as http;

class CategoryMainService {
  final String baseUrl = 'https://posterbnaobackend.onrender.com';

   Future<List<MainCategoryModel>> fetchAllCategories() async {
  try {
    final response = await http.get(Uri.parse('https://posterbnaobackend.onrender.com/api/category/getall-cateogry'));
    print('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List data = decoded['categories']; // Extract the actual list

      print('melviiiiin$data'); // ✅ This will now print

      return data.map((json) => MainCategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories. Status: ${response.statusCode}');
    }
  } catch (e, stackTrace) {
    print('Exception: $e');
    print('StackTrace: $stackTrace');
    throw Exception('Error fetching categories: $e');
  }
}



}