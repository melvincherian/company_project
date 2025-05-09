class InvoiceItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final int quantity;

  InvoiceItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
  });

  double get total => price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
    };
  }

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
    );
  }
}