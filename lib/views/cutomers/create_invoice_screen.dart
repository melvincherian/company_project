import 'package:company_project/models/product_model.dart';
import 'package:company_project/providers/invoice_provider.dart';
import 'package:company_project/providers/product_invoice_provider.dart';
import 'package:company_project/views/cutomers/add_invoice_screen.dart';
import 'package:company_project/views/cutomers/add_user_data.dart';
import 'package:company_project/views/cutomers/invoice_detail_screen.dart'; // Import the new screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:company_project/models/invoice_model.dart';

class CreateInvoiceScreen extends StatefulWidget {
  const CreateInvoiceScreen({super.key});

  @override
  State<CreateInvoiceScreen> createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadInvoices();
  }
  
  Future<void> _loadInvoices() async {
    final provider = Provider.of<ProductInvoiceProvider>(context, listen: false);
    await provider.loadInvoices();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('MM/dd/yyyy').format(date);
  }

  String _generateInvoiceNumber(String id) {
    // Create invoice number format based on invoice ID
    // Taking first 7 characters of the UUID
    return "#${id.substring(0, 7).toUpperCase()}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Get Invoice',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const AddUserData())
              );
            }, 
            icon: const Icon(Icons.person)
          )
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Consumer<ProductInvoiceProvider>(
              builder: (context, invoiceProvider, _) {
                final invoices = invoiceProvider.invoices;
                
                if (invoices.isEmpty) {
                  return const Center(
                    child: Text(
                      'No invoices yet. Create your first invoice!',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }
                
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                    itemCount: invoices.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final invoice = invoices[index];
                      final invoiceDate = _formatDate(invoice.createdAt);
                      // Due date set to 30 days after creation (example)
                      final dueDate = _formatDate(
                        invoice.createdAt.add(const Duration(days: 30))
                      );
                      
                      return InkWell(
                        onTap: () {
                          // Navigate to the PDF detail screen when tapping anywhere on the invoice
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InvoiceDetailScreen(invoice: invoice)
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Invoice Number',
                                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                    ),
                                    Text(
                                      _generateInvoiceNumber(invoice.id),
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Invoice Date',
                                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                    ),
                                    Text(
                                      invoiceDate,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Due Date',
                                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                    ),
                                    Text(
                                      dueDate,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios, size: 16)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const AddInvoiceScreen())
              ).then((_) {
                // Refresh invoices when returning from Add Invoice Screen
                _loadInvoices();
              });
            },
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Create New Invoice',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1DA1F2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}