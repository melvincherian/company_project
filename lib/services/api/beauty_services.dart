// import 'dart:convert';

// import 'package:company_project/models/beauty_model.dart';
// import 'package:http/http.dart' as http;

// class BeautyServices {
//   final String baseUrl = 'https://posterbnaobackend.onrender.com';

//   Future<List<BeautyModel>> fetchBeauty() async {
//     final response = await http.get(Uri.parse(
//         'https://posterbnaobackend.onrender.com/api/poster/beautyposter'));
//     if (response.statusCode == 200) {
//       final List data = jsonDecode(response.body);

//       return data.map((json) => BeautyModel.fromjson(json)).toList();
//     } else {
//       throw Exception();
//     }
//   }
// }
