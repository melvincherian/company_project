
class CategoryModel {
  final String id;
  final String categoryname;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoryModel({
    required this.id,
    required this.categoryname,
    required this.image,
    required this.createdAt,
    required this.updatedAt
  });

  factory CategoryModel.fromjson(Map<String,dynamic>json){
    return CategoryModel(
    id: json['_id'],
    categoryname: json['categoryName'], 
    image: json['image'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
      );
  }

  Map<String,dynamic>tojson(){
    return{
      '_id':id,
      'categoryname':categoryname,
      'image':image,
      'createdAt':createdAt.toIso8601String(),
      'updatedAt':updatedAt.toIso8601String()
    };
  }
}