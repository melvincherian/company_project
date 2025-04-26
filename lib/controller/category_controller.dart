// import 'package:company_project/models/category_model.dart';
// import 'package:company_project/services/api/category_services.dart';

// class CategoryController {
//   final CategoryServices _services=CategoryServices();

//   List<CategoryModel>_categories=[];

//   List<CategoryModel>get categories=>_categories;

//   Future<void>loadCategories()async{
//     try{
//       _categories=await _services.fetchCategory();

//     }catch(e){
//       print('Error loading categories $e');
//       rethrow;
//     }
//   }


// }