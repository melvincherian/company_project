import 'package:company_project/models/category_modell.dart';

class InvoiceItem {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String? imageUrl;
  final String? categoryName;

  InvoiceItem({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
    this.imageUrl,
    this.categoryName,
  });

  // Create from Poster model
  factory InvoiceItem.fromPoster(CategoryModel  poster) {
    return InvoiceItem(
      id: poster.id,
      name: poster.name,
      price: poster.price.toDouble(),
      imageUrl: poster.images.isNotEmpty ? poster.images.first : null,
      categoryName: poster.categoryName,
    );
  }

  // Total price calculation
  double get total => price * quantity;

  // Create a copy with updated quantity
  InvoiceItem copyWith({int? quantity}) {
    return InvoiceItem(
      id: id,
      name: name,
      price: price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl,
      categoryName: categoryName,
    );
  }
}
