// import 'dart:convert';

// import 'package:company_project/models/chemical_model.dart';
// import 'package:http/http.dart' as http;

// class ChemicalServices {
//   final String baseUrl='https://posterbnaobackend.onrender.com';

//   Future<List<ChemicalModel>>fetchChemicals()async{
//     final response=await http.get(Uri.parse('https://posterbnaobackend.onrender.com/api/poster/chemicalposter'));
//     if(response.statusCode==200){
//       final List data=jsonDecode(response.body);

//       return data.map((json)=>ChemicalModel.fromjson(json)).toList();

//     }else{
//       throw Exception();
//     }
//   }
// }