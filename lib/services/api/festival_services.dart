import 'dart:convert';
import 'package:company_project/models/festival_model.dart';
import 'package:http/http.dart' as http;


class FestivalServices {
  static const String _baseUrl = 'https://posterbnaobackend.onrender.com/api/poster/festival';

  static Future<List<FestivalModel>> fetchFestivalTemplates(DateTime festivalDate) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'festivalDate': festivalDate.toIso8601String().split('T').first,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data is List) {
          return data.map((e) => FestivalModel.fromJson(e)).toList();
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Failed to load festival templates. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching festival templates: $e');
    }
  }
}
