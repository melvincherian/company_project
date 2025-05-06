import 'dart:convert';
import 'package:company_project/models/my_plan_model.dart';
import 'package:http/http.dart' as http;

class MyPlanServices {
  final String _baseUrl = 'https://posterbnaobackend.onrender.com/api/users/myplan';

  Future<SubscribePlanModel?> fetchUserPlan(String userId) async {
    final url = Uri.parse('$_baseUrl/$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return SubscribePlanModel.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        
        return null;
      } else {
        throw Exception('Failed to load user plan: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching user plan: $e');
    }
  }
}
