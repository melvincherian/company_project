class MainCategoryModel {
  final String id;
  final String categoryName;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  MainCategoryModel({
    required this.id,
    required this.categoryName,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MainCategoryModel.fromJson(Map<String, dynamic> json) {
    return MainCategoryModel(
      id: json['_id'] ?? '',
      categoryName: json['categoryName'] ?? '',
      image: json['image'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'categoryName': categoryName,
      'image': image,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  MainCategoryModel copyWith({
    String? id,
    String? categoryName,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MainCategoryModel(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}