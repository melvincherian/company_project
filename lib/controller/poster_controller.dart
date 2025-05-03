import 'package:company_project/models/category_modell.dart';
import 'package:company_project/services/api/poster_service.dart';

class PosterController {
  final PosterService _service=PosterService();

  Future<List<CategoryModel>>loadPosters()async{
    try{
      return await _service.fetchTemplates();
    }catch(e){
      throw Exception('Unable to load posters$e');
    }
  }
}