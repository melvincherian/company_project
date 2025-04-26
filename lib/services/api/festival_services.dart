import 'dart:convert';

import 'package:http/http.dart' as http;

class FestivalApiServices {

String baseUrl='https://posterbnaobackend.onrender.com/api/poster/festival';

Future<http.Response>postFestivalData(Map<String,dynamic>data)async{
  try{
    final response=await http.post(Uri.parse(baseUrl),
    headers: {
      'content-Type':'application/json'
    },
    body: jsonEncode(data)
    );

    if(response.statusCode==200 || response.statusCode==201){
      return response;
    }else{
      throw Exception('Failed to post data.status code:${response.statusCode}');
    }
  }
  catch(e){
    throw Exception('Error posting data$e');
  }
}

}