import 'dart:convert';

import 'package:company_project/models/category_model.dart';
import 'package:http/http.dart' as http;


class CategoryServices {
  final String  baseUrl='https://posterbnaobackend.onrender.com';

Future<List<CategoryModel>> fetchCategory() async {
  final response = await http.get(
    Uri.parse('https://posterbnaobackend.onrender.com/api/category/getall-cateogry'),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final List<dynamic> categoriesJson = responseData['categories'];

    return categoriesJson
        .map((json) => CategoryModel.fromjson(json))
        .toList();
  } else {
    throw Exception('Failed to load categories');
  }
}




}