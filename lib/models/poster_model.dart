class TemplateModel {
  final String id;
  final String name;
  final String categoryName;
  final int price;
  final List<String> images;
  final String description;
  final String size;
  final String? festivalDateString; // Changed to String
  final bool inStock;

  TemplateModel({
    required this.id,
    required this.name,
    required this.categoryName,
    required this.price,
    required this.images,
    required this.description,
    required this.size,
    this.festivalDateString, // Changed from festivalDate
    required this.inStock,
  });

  factory TemplateModel.fromJson(Map<String, dynamic> json) {
    return TemplateModel(
      id: json['_id'],
      name: json['name'],
      categoryName: json['categoryName'],
      price: json['price'],
      images: List<String>.from(json['images']),
      description: json['description'],
      size: json['size'],
      inStock: json['inStock'],
      festivalDateString: json['festivalDate']?.toString(), // Store as string
    );
  }

  // Add getter to convert to DateTime when needed
  DateTime? get festivalDate {
    if (festivalDateString == null) return null;
    try {
      return DateTime.parse(festivalDateString!);
    } catch (_) {
      return null; // Return null if parsing fails
    }
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
      'inStock': inStock,
      'festivalDate': festivalDateString,
    };
  }
}