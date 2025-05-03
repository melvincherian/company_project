import 'dart:convert';
import 'package:company_project/models/signup_model.dart';
import 'package:http/http.dart' as http;

class SignupServices {
  static const String baseUrl = 'https://posterbnaobackend.onrender.com/api/users/register';

  Future<bool> registerUser(SignupModel signupModel) async {
    try {
      final response = await http.post(
      
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': signupModel.name,
          'email': signupModel.email,
          'mobile': signupModel.mobile,
          'dob': signupModel.dob,
          'marriageAnniversaryDate': signupModel.marriageAnniversary, 
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('User registered successfully!');
        return true;
      } else {
        print('Failed to register user: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during registration: $e');
      return false;
    }
  }
}
