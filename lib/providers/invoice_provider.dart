// lib/providers/invoice_provider.dart
import 'package:company_project/models/invoice_model.dart';
import 'package:flutter/foundation.dart';

class InvoiceProvider extends ChangeNotifier {
  final List<InvoiceItem> _items = [];
  double _discountAmount = 10.0; // Default discount
  double _taxRate = 10.0; // Default tax rate (percent)

  // Getters
  List<InvoiceItem> get items => _items;
  int get itemCount => _items.length;
  double get subTotal => _items.fold(0, (sum, item) => sum + item.total);
  double get discount => _discountAmount;
  double get taxAmount => (subTotal - _discountAmount) * (_taxRate / 100);
  double get total => subTotal - _discountAmount + taxAmount;

  // Add item to invoice
  void addItem(InvoiceItem item) {
    final existingItemIndex = _items.indexWhere((i) => i.id == item.id);
    
    if (existingItemIndex >= 0) {
      // Item already exists, update quantity
      final existingItem = _items[existingItemIndex];
      _items[existingItemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + 1
      );
    } else {
      // Add new item
      _items.add(item);
    }
    
    notifyListeners();
  }

  // Remove item from invoice
  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  // Update item quantity
  void updateQuantity(String itemId, int quantity) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index] = _items[index].copyWith(quantity: quantity);
      }
      notifyListeners();
    }
  }

  // Set discount amount
  void setDiscount(double amount) {
    _discountAmount = amount;
    notifyListeners();
  }

  // Set tax rate
  void setTaxRate(double rate) {
    _taxRate = rate;
    notifyListeners();
  }

  // Clear all items
  void clear() {
    _items.clear();
    notifyListeners();
  }
}