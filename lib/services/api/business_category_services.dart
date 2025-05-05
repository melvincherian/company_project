import 'dart:convert';

import 'package:company_project/models/business_category_model.dart';
import 'package:http/http.dart' as http;

class BusinessCategoryServices {
  final String _baseUrl =
      'https://posterbnaobackend.onrender.com/api/business/getallbusiness-category';

  Future<List<BusinessCategoryModel>> fetchBusinessCategories() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          final List categoriesJson = data['categories'];
          return categoriesJson
              .map((json) => BusinessCategoryModel.fromJson(json))
              .toList();
        } else {
          throw Exception('Failed to load categories:${data['message']}');
        }
      } else {
        throw Exception('Sever error :${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }
}
