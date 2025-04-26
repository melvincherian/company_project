class ClothingModel {
  final String id;
  final String name;
  final String categoryName;
  final int price;
  final List<String> images;
  final String description;
  final String size;
  final String? festivalDate;
  final bool inStock;
  final List<dynamic> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  ClothingModel({
    required this.id,
    required this.name,
    required this.categoryName,
    required this.price,
    required this.images,
    required this.description,
    required this.size,
    required this.festivalDate,
    required this.inStock,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ClothingModel.fromjson(Map<String, dynamic> json) {
    return ClothingModel(
      id: json['_id'],
      name: json['name'],
      categoryName: json['categoryName'],
      price: json['price'],
      images: List<String>.from(json['images']),
      description: json['description'],
      size: json['size'],
      festivalDate: json['festivalDate'],
      inStock: json['inStock'],
      tags: json['tags'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'categoryName': categoryName,
      'price': price,
      'images': images,
      'description': description,
      'size': size,
      'festivalDate': festivalDate,
      'inStock': inStock,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
