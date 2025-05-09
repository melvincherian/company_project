// lib/models/invoice_model.dart

class ProductItem {
  final String invoiceNumber;
  final String productName;
  final double quantity;
  final DateTime invoiceDate;
  final String unit;
  final double price;
  final double offerPrice;

  ProductItem({
    required this.productName,
    required this.quantity,
    required this.unit,
    required this.price,
    required this.offerPrice,
    required this.invoiceNumber,
    required this.invoiceDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'quantity': quantity,
      'unit': unit,
      'price': price,
      'offerPrice': offerPrice,
      'invoiceNumber': invoiceNumber,
      'invoiceDate': invoiceDate.toIso8601String(),
    };
  }

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      productName: json['productName'],
      quantity: json['quantity'] is double
          ? json['quantity']
          : double.parse(json['quantity'].toString()),
      unit: json['unit'],
      invoiceDate: DateTime.parse(json['invoiceDate']),
      invoiceNumber: json['invoiceNumber'],
      price: json['price'] is double
          ? json['price']
          : double.parse(json['price'].toString()),
      offerPrice: json['offerPrice'] is double
          ? json['offerPrice']
          : double.parse(json['offerPrice'].toString()),
    );
  }
}

class Invoice {
  final String id;
  final List<ProductItem> products;
  final DateTime createdAt;
  final String userId;

  Invoice({
    required this.id,
    required this.products,
    required this.createdAt,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'products': products.map((product) => product.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'userId': userId,
    };
  }

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      products: (json['products'] as List)
          .map((item) => ProductItem.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      userId: json['userId'],
    );
  }
}
