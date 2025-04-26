// ignore_for_file: body_might_complete_normally_nullable

import 'dart:convert';

import 'package:company_project/models/user_model.dart';
import 'package:http/http.dart' as http;

class Authservice {
  final String baseUrl='https://posterbnaobackend.onrender.com/';
  
  Future<LoginResponse?> login(String mobile) async {
  try {
    print('Mobile number: $mobile');
    final response = await http.post(
      Uri.parse('${baseUrl}api/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'mobile': mobile}),
    );

    print('${response.statusCode}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Successsssss$data');
      return LoginResponse.fromJson(data);
    } else {
      throw Exception('Login Failed');
    }
  } catch (e) {
    print('Errrrrrrrrrr $e');
    return null;
  }
}

}