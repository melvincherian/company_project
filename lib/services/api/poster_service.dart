import 'dart:convert';

import 'package:company_project/models/poster_model.dart';
import 'package:http/http.dart' as http;


class PosterService {
  final String baseUrl='https://posterbnaobackend.onrender.com';


Future <List<TemplateModel>> fetchTemplates() async {
  print('Starting API request to fetch templates');
  
  try {
    final response = await http.get(Uri.parse('$baseUrl/api/poster/getallposter'));
    print('API Response Status Code: ${response.statusCode}');
    print('API Response Headers: ${response.headers}');
    print('API Response Body (first 200 chars): ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}...');
    
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      print('Parsed JSON data count: ${data.length}');
      
      if (data.isEmpty) {
        print('Warning: API returned empty list');
        return [];
      }
      
      print('Sample first item: ${data.isNotEmpty ? data[0] : "No items"}');
      return data.map((json) => TemplateModel.fromJson(json)).toList();
    } else {
      print('API Error: Status ${response.statusCode}, Body: ${response.body}');
      throw Exception('Failed to load posters: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception in fetchTemplates: $e');
    rethrow; // rethrow to be handled by the provider
  }
}
}