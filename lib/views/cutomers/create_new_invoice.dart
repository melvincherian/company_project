// lib/views/create_new_invoice.dart
import 'package:company_project/views/cutomers/get_invoice.dart';
import 'package:company_project/views/presentation/widgets/invoice_item_widget.dart';
import 'package:company_project/views/presentation/widgets/invoice_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:provider/provider.dart';
import 'package:company_project/providers/invoice_provider.dart';

class CreateNewInvoice extends StatefulWidget {
  const CreateNewInvoice({super.key});

  @override
  State<CreateNewInvoice> createState() => _CreateNewInvoiceState();
}

class _CreateNewInvoiceState extends State<CreateNewInvoice> {
  DateTime invoiceDate = DateTime.now();
  DateTime dueDate = DateTime.now();

  bool _isListening = false;
  String _searchText = '';
  final TextEditingController _searchController = TextEditingController();

  late stt.SpeechToText _speech;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initializeSpeech();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('invoice_name');
    final savedInvoiceDate = prefs.getString('invoice_date');
    final savedDueDate = prefs.getString('due_date');

    setState(() {
      if (savedName != null) nameController.text = savedName;
      if (savedInvoiceDate != null) {
        invoiceDate = DateTime.tryParse(savedInvoiceDate) ?? invoiceDate;
      }
      if (savedDueDate != null) {
        dueDate = DateTime.tryParse(savedDueDate) ?? dueDate;
      }
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('invoice_name', nameController.text);
    await prefs.setString('invoice_date', invoiceDate.toIso8601String());
    await prefs.setString('due_date', dueDate.toIso8601String());
  }

  Future<void> _pickDates() async {
    final pickedInvoiceDate = await showDatePicker(
      context: context,
      initialDate: invoiceDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedInvoiceDate != null) {
      final pickedDueDate = await showDatePicker(
        context: context,
        initialDate: dueDate,
        firstDate: pickedInvoiceDate,
        lastDate: DateTime(2100),
      );
      if (pickedDueDate != null) {
        setState(() {
          invoiceDate = pickedInvoiceDate;
          dueDate = pickedDueDate;
        });
      }
    }
  }

  Future<void> _initializeSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) => debugPrint('Speech status: $status'),
      onError: (error) => debugPrint('Speech error: $error'),
    );
    if (!available) {
      debugPrint('Speech recognition not available');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _speech.stop();
    super.dispose();
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => debugPrint('Speech status: $status'),
        onError: (error) => debugPrint('Speech error: $error'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _searchText = result.recognizedWords;
              _searchController.text = _searchText;
            });
          },
        );
      } else {
        debugPrint('The user has denied the use of speech recognition.');
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final invoiceProvider = Provider.of<InvoiceProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Invoice', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                suffixIcon: GestureDetector(
                  onTap: _startListening,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _isListening ? Colors.red : const Color.fromARGB(255, 97, 74, 160),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
                labelText: 'Search here....!'
              ),
            ),
            const SizedBox(height: 20),

            const Text('Invoice Details', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Invoice Number', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        SizedBox(height: 4),
                        Text('#1234565', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Invoice Date', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        const SizedBox(height: 4),
                        Text(formatDate(invoiceDate), style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Due Date', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        const SizedBox(height: 4),
                        Text(formatDate(dueDate), style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, size: 18, color: Colors.blue),
                    onPressed: _pickDates,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('Name/Business Name', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Product Details', style: TextStyle(fontWeight: FontWeight.bold)),
                TextButton.icon(
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const PosterGridView()));
                  },
                  icon: const Icon(Icons.add_circle, color: Colors.blue, size: 18),
                  label: const Text(
                    'Add Item',
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Display selected products
            if (invoiceProvider.items.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'No products added yet',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: invoiceProvider.items.length,
                itemBuilder: (context, index) {
                  final item = invoiceProvider.items[index];
                  return InvoiceItemWidget(item: item);
                },
              ),
              
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Items'),
                      Text('${invoiceProvider.itemCount}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Sub Total'),
                      Text('₹${invoiceProvider.subTotal.toStringAsFixed(2)}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Discount'),
                      Row(
                        children: [
                          Text('₹${invoiceProvider.discount.toStringAsFixed(2)}'),
                          IconButton(
                            icon: const Icon(Icons.edit, size: 14),
                            onPressed: () => _showDiscountDialog(context, invoiceProvider),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tax'),
                      Text('₹${invoiceProvider.taxAmount.toStringAsFixed(2)}'),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        '₹${invoiceProvider.total.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  await _saveData();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const GetInvoice()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1DA1F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Save', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Dialog to edit discount
  void _showDiscountDialog(BuildContext context, InvoiceProvider provider) {
    final discountController = TextEditingController(text: provider.discount.toString());
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Discount'),
        content: TextField(
          controller: discountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Discount Amount',
            prefixText: '₹',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newDiscount = double.tryParse(discountController.text) ?? 0;
              provider.setDiscount(newDiscount);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}