import 'dart:convert';

import 'package:company_project/models/ugadi_model.dart';
import 'package:http/http.dart' as http;

class UgadiService {
  final String baseUrl='https://posterbnaobackend.onrender.com';

  Future<List<UgadiModel>>fetchUgadies()async{
    final response=await http.get(Uri.parse('https://posterbnaobackend.onrender.com/api/poster/ugadiposter'));
    if(response.statusCode==200){
      final List data=jsonDecode(response.body);

      return data.map((json)=>UgadiModel.fromJson(json)).toList();

    }else{
      throw Exception();
    }
  }
}