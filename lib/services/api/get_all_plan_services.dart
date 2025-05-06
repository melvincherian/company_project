import 'dart:convert';
import 'package:company_project/models/get_all_plan_model.dart';
import 'package:http/http.dart' as http;


class GetAllPlanServices {
  static const String _baseUrl = 'https://posterbnaobackend.onrender.com/api/plans/getallplan';

  Future<List<GetAllPlanModel>> fetchAllPlans() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        return jsonData
            .map((planJson) => GetAllPlanModel.fromJson(planJson))
            .toList();
      } else {
        throw Exception('Failed to load plans: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching plans: $e');
    }
  }
}
