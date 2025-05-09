import 'package:company_project/helper/invoice_helper.dart';
import 'package:company_project/models/product_model.dart';
import 'package:company_project/providers/invoice_provider.dart'; // Updated import path
import 'package:company_project/providers/product_invoice_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddInvoiceScreen extends StatefulWidget {
  const AddInvoiceScreen({super.key});

  @override
  State<AddInvoiceScreen> createState() => _AddInvoiceScreenState();
}

class _AddInvoiceScreenState extends State<AddInvoiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<ProductEntry> _productEntries = [ProductEntry()];
  bool _isLoading = false;

  final List<String> units = ['kg', 'gram', 'milligram', 'liter'];

  @override
  void initState() {
    super.initState();
    // Initialize the first entry with a default unit
    if (_productEntries.isNotEmpty) {
      _productEntries.first.unit = units.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Invoice',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ..._productEntries.map((entry) => _buildProductEntry(entry)),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          // Initialize new entry with default unit
                          ProductEntry newEntry = ProductEntry();
                          newEntry.unit = units.first;
                          _productEntries.add(newEntry);
                        });
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add More'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _saveInvoice,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Create',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductEntry(ProductEntry entry) {
    return Column(
      children: [
        if (_productEntries.length > 1 && _productEntries.indexOf(entry) > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _productEntries.remove(entry);
                  });
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        _buildTextField(entry.productNameController, 'Product Name'),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(entry.quantityController, 'Quantity',
                  inputType: TextInputType.number),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: entry.unit,
                decoration: InputDecoration(
                  labelText: 'Unit',
                  labelStyle: const TextStyle(fontWeight: FontWeight.w500),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                items: units
                    .map((unit) =>
                        DropdownMenuItem(value: unit, child: Text(unit)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    entry.unit = value ?? units.first; // Provide fallback
                  });
                },
                validator: (value) =>
                    value == null || value.isEmpty ? 'Select Unit' : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField(entry.priceController, 'Price',
            inputType: TextInputType.number),
        const SizedBox(height: 16),
        _buildTextField(entry.offerPriceController, 'Offer Price',
            inputType: TextInputType.number),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType inputType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontWeight: FontWeight.w500),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Enter $label';
        }
        
        // Add specific validation for numeric fields
        if (inputType == TextInputType.number) {
          try {
            double.parse(value);
          } catch (e) {
            return 'Enter a valid number';
          }
        }
        
        return null;
      },
    );
  }

  Future<void> _saveInvoice() async {
    if (!_formKey.currentState!.validate()) return;

    // Extra validation for unit selection
    for (var entry in _productEntries) {
      if (entry.unit == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a unit for all products'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Convert the UI data to ProductItem model objects
      final List<ProductItem> products = _productEntries.map((entry) {
        // Use null safety for better stability
        final invoiceNumberStr = generateInvoiceNumber().toString();
        final productName = entry.productNameController.text.trim();
        final quantity = double.tryParse(entry.quantityController.text) ?? 0.0;
        final unit = entry.unit ?? units.first; // Fallback to first unit
        final price = double.tryParse(entry.priceController.text) ?? 0.0;
        final offerPrice = double.tryParse(entry.offerPriceController.text) ?? 0.0;

        return ProductItem(
         // Update field name if needed in your model
          invoiceNumber: invoiceNumberStr,
          productName: productName,
          quantity: quantity,
          invoiceDate: DateTime.now(),
          unit: unit,
          price: price,
          offerPrice: offerPrice,
        );
      }).toList();

      // Save the invoice using the provider (with correct provider name)
      final success = await Provider.of<ProductInvoiceProvider>(context, listen: false)
          .addInvoice(products);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invoice created successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to create invoice'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

class ProductEntry {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController offerPriceController = TextEditingController();
  String? unit; // This being null was likely causing the error
}