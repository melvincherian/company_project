// lib/views/widgets/invoice_item_widget.dart
import 'package:company_project/models/invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:company_project/providers/invoice_provider.dart';

class InvoiceItemWidget extends StatelessWidget {
  final InvoiceItem item;
  
  const InvoiceItemWidget({
    Key? key, 
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final invoiceProvider = Provider.of<InvoiceProvider>(context, listen: false);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (item.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.imageUrl!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 50),
              ),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  "${item.categoryName ?? 'No category'} | ₹${item.price.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, size: 20),
                onPressed: item.quantity > 1
                    ? () => invoiceProvider.updateQuantity(item.id, item.quantity - 1)
                    : () => invoiceProvider.removeItem(item.id),
              ),
              Text(
                '${item.quantity}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, size: 20),
                onPressed: () => invoiceProvider.updateQuantity(item.id, item.quantity + 1),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "₹${item.total.toStringAsFixed(2)}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                onPressed: () => invoiceProvider.removeItem(item.id),
              ),
            ],
          ),
        ],
      ),
    );
  }
}