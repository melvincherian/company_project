import 'dart:convert';
import 'package:http/http.dart' as http;

class CustomerApiServices {
  final String baseUrl = 'https://posterbnaobackend.onrender.com/api/users'; 

  /// Add Customer
  Future<bool> addCustomer({
    required String userId,
    required String name,
    required String email,
    required String mobile,
    required String dob,
    required String address,
    required String gender,
    required String anniversaryDate,
  }) async {
    final Uri url = Uri.parse('$baseUrl/addcustomer?userId=$userId');

    final Map<String, dynamic> body = {
      'name': name,
      'email': email,
      'mobile': mobile,
      'dob': dob,
      'address': address,
      'gender': gender,
      'anniversaryDate': anniversaryDate,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        print(jsonDecode(response.body)['message']);
        return true;
      } else {
        print('Failed to add customer: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error adding customer: $e');
      return false;
    }
  }

  /// Fetch User (with customer list)
  Future<Map<String, dynamic>?> fetchUser(String userId) async {
    final Uri url = Uri.parse('$baseUrl/allcustomers?userId=$userId');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to fetch user: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }


//   Future<Map<String, dynamic>?> fetchUser(String userId) async {
//     var userId='680634a4bb1d44fb0c93aae2';
//     final Uri url = Uri.parse('https://posterbnaobackend.onrender.com/api/users/allcustomers/$userId');

//     try {
//       final response = await http.get(url);

//       print('sfbhjasbfjbsjfjjhhjhjhf${response.statusCode}');
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         print('Failed to fetch user: ${response.statusCode}');
//         return null;
//       }
//     } catch (e) {
//       print('Error fetching user: $e');
//       return null;
//     }
//   }

  /// Delete Customer by customer ID
  Future<bool> deleteCustomer({
    required String userId,
    required String customerId,
  }) async {
    final Uri url = Uri.parse('$baseUrl/delete-customers?userId=$userId&customerId=$customerId');

    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        print(jsonDecode(response.body)['message']);
        return true;
      } else {
        print('Failed to delete customer: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error deleting customer: $e');
      return false;
    }
  }

  /// Update Customer by customer ID
  Future<bool> updateCustomer({
    required String userId,
    required String customerId,
    required String name,
    required String email,
    required String mobile,
    required String dob,
    required String address,
    required String gender,
    required String anniversaryDate,
  }) async {
    final Uri url = Uri.parse('$baseUrl/update-customers?userId=$userId&customerId=$customerId');

    final Map<String, dynamic> body = {
      'name': name,
      'email': email,
      'mobile': mobile,
      'dob': dob,
      'address': address,
      'gender': gender,
      'anniversaryDate': anniversaryDate,
    };

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        print(jsonDecode(response.body)['message']);
        return true;
      } else {
        print('Failed to update customer: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error updating customer: $e');
      return false;
    }
  }
}
