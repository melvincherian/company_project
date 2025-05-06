import 'dart:convert';

import 'package:company_project/models/get_profile_model.dart';
import 'package:http/http.dart' as http;

class UserProfileServices {
  final String _baseUrl =
      'https://posterbnaobackend.onrender.com/api/users/get-profile';

  Future<UserModel> fetchUserProfile(String userId) async {
    final url = Uri.parse('$_baseUrl/$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return UserModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load user profile:${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching user profile:$e');
    }
  }
}
