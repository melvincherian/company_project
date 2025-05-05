import 'dart:convert';

import 'package:company_project/models/business_poster_model.dart';
import 'package:http/http.dart' as http;

class BusinessPosterServices {
  static const String baseUrl =
      'https://posterbnaobackend.onrender.com/api/business/businessposters';

  Future<List<BusinessPosterModel>> fetchBusinessPosters() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => BusinessPosterModel.fromjson(json)).toList();
      } else {
        throw Exception(
            'Failed to load posters.Status code :${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching business posters: $e');
    }
  }
}
