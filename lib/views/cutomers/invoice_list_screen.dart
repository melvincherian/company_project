import 'package:company_project/models/product_model.dart';
import 'package:company_project/providers/product_invoice_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'add_invoice_screen.dart';

class InvoiceListScreen extends StatefulWidget {
  const InvoiceListScreen({super.key});

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInvoices();
  }

  Future<void> _loadInvoices() async {
    setState(() {
      _isLoading = true;
    });

    await Provider.of<ProductInvoiceProvider>(context, listen: false).loadInvoices();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Invoices',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildInvoiceList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddInvoiceScreen()),
          );
          _loadInvoices(); // Refresh list after returning from add screen
        },
        backgroundColor: theme.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildInvoiceList() {
    final invoiceProvider = Provider.of<ProductInvoiceProvider>(context);
    final invoices = invoiceProvider.invoices;

    if (invoices.isEmpty) {
      return const Center(
        child: Text(
          'No invoices yet. Create your first invoice!',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadInvoices,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: invoices.length,
        itemBuilder: (context, index) {
          final invoice = invoices[index];
          return _buildInvoiceCard(invoice);
        },
      ),
    );
  }

  Widget _buildInvoiceCard(Invoice invoice) {
    // Calculate total invoice amount
    double totalAmount = 0;
    for (var product in invoice.products) {
      totalAmount += product.offerPrice * product.quantity;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Invoice #${invoice.id.substring(0, 8)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteInvoice(invoice.id),
                ),
              ],
            ),
            const Divider(),
            Text(
              'Date: ${DateFormat('MMM dd, yyyy').format(invoice.createdAt)}',
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 8),
            Text(
              'Products: ${invoice.products.length}',
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 8),
            Text(
              'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            ExpansionTile(
              title: const Text('View Products'),
              tilePadding: EdgeInsets.zero,
              children: invoice.products.map((product) {
                return ListTile(
                  dense: true,
                  title: Text(product.productName),
                  subtitle: Text(
                      '${product.quantity} ${product.unit} at \$${product.offerPrice}'),
                  trailing: Text(
                    '\$${(product.quantity * product.offerPrice).toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteInvoice(String invoiceId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Invoice'),
        content: const Text('Are you sure you want to delete this invoice?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await Provider.of<ProductInvoiceProvider>(context, listen: false)
          .deleteInvoice(invoiceId);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invoice deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }
}