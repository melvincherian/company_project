import 'package:company_project/views/cutomers/create_new_invoice.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetInvoice extends StatefulWidget {
  const GetInvoice({super.key});

  @override
  State<GetInvoice> createState() => _GetInvoiceState();
}

class _GetInvoiceState extends State<GetInvoice> {
  String invoiceDate = '';
  String invoiceNumber = '';

  @override
  void initState() {
    super.initState();
    _loadInvoiceData();
  }

  Future<void> _loadInvoiceData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedInvoiceDate = prefs.getString('invoice_date') ?? '';
    final savedInvoiceNumber = prefs.getString('invoice_number') ?? '';

    setState(() {
      invoiceDate = savedInvoiceDate.isNotEmpty ? savedInvoiceDate : 'N/A';
      invoiceNumber = savedInvoiceNumber.isNotEmpty ? savedInvoiceNumber : 'N/A';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get invoice', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateNewInvoice()));
            },
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Invoice', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('Date: $invoiceDate', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Invoice: $invoiceNumber', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Table(
                    border: TableBorder.symmetric(
                      inside: BorderSide(color: Colors.grey.shade300),
                    ),
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1.2),
                    },
                    children: [
                      const TableRow(
                        decoration: BoxDecoration(color: Colors.transparent),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('DESCRIPTION', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('QTY', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('SUBTOTAL', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      for (var i = 0; i < 2; i++)
                        const TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Poster'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('01'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('₹250'),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 4),
                  _buildSummaryRow('Total Items', '02'),
                  _buildSummaryRow('Sub Total', '₹225.00'),
                  _buildSummaryRow('Discount', '₹10.00'),
                  _buildSummaryRow('Tax', '₹22.00'),
                  const Divider(height: 24),
                  _buildSummaryRow('Total', '₹247.00', isBold: true, isBlue: true),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download, color: Colors.white),
                  label: const Text('Download', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1DA1F2),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share, color: Color(0xFF1DA1F2)),
                  label: const Text('Share', style: TextStyle(color: Color(0xFF1DA1F2))),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF1DA1F2)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool isBold = false, bool isBlue = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBlue ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
