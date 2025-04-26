import 'dart:convert';

import 'package:company_project/models/clothing_model.dart';
import 'package:http/http.dart' as http;

class ClothingServices {
  final String baseUrl='https://posterbnaobackend.onrender.com';

  Future<List<ClothingModel>>fetchClothing()async{
    final response=await http.get(Uri.parse('https://posterbnaobackend.onrender.com/api/poster/clothingposter'));
    if(response.statusCode==200){
      final List data=jsonDecode(response.body);

      return data.map((json)=>ClothingModel.fromjson(json)).toList();

    }else{
      throw Exception();
    }
  }
}