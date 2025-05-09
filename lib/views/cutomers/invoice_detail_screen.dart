import 'dart:io';
import 'dart:typed_data';
import 'package:company_project/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'dart:ui' as ui;

class InvoiceDetailScreen extends StatefulWidget {
  final Invoice invoice;

  const InvoiceDetailScreen({
    super.key,
    required this.invoice,
  });

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
  final GlobalKey _printableKey = GlobalKey();
  bool _isGeneratingPdf = false;

  String _formatDate(DateTime date) {
    return DateFormat('MM/dd/yyyy').format(date);
  }

  String _generateInvoiceNumber(String id) {
    return "#${id.substring(0, 7).toUpperCase()}";
  }

  @override
  Widget build(BuildContext context) {
    final invoice = widget.invoice;
    final totalAmount = invoice.products.fold<double>(
      0, (total, product) => total + (product.price * product.quantity)
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Invoice ${_generateInvoiceNumber(invoice.id)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          if (_isGeneratingPdf)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else
            Row(
              children: [
                IconButton(
                  onPressed: _sharePdf,
                  icon: const Icon(Icons.share),
                  tooltip: 'Share Invoice',
                ),
                IconButton(
                  onPressed: _downloadPdf,
                  icon: const Icon(Icons.download),
                  tooltip: 'Download Invoice',
                ),
              ],
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: RepaintBoundary(
            key: _printableKey,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'INVOICE',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1DA1F2),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _generateInvoiceNumber(invoice.id),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Company Name',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            '123 Business Street',
                            style: TextStyle(fontSize: 14),
                          ),
                          const Text(
                            'City, State ZIP',
                            style: TextStyle(fontSize: 14),
                          ),
                          const Text(
                            'Phone: (123) 456-7890',
                            style: TextStyle(fontSize: 14),
                          ),
                          const Text(
                            'Email: info@company.com',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Invoice info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bill To
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     const Text(
                      //       'BILL TO',
                      //       style: TextStyle(
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.grey,
                      //       ),
                      //     ),
                      //     const SizedBox(height: 8),
                      //     const Text(
                      //       'Customer Name',
                      //       style: TextStyle(
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     const Text(
                      //       'Customer Address',
                      //       style: TextStyle(fontSize: 14),
                      //     ),
                      //     const Text(
                      //       'City, State ZIP',
                      //       style: TextStyle(fontSize: 14),
                      //     ),
                      //     const Text(
                      //       'customer@email.com',
                      //       style: TextStyle(fontSize: 14),
                      //     ),
                      //   ],
                      // ),
                      
                      // Invoice Details
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Invoice Date: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                _formatDate(invoice.createdAt),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Text(
                                'Due Date: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                _formatDate(invoice.createdAt.add(const Duration(days: 30))),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Product table header
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1DA1F2).withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            'ITEM',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'QTY',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'UNIT',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'PRICE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'AMOUNT',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Product list
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: invoice.products.length,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey.shade300,
                        height: 1,
                      ),
                      itemBuilder: (context, index) {
                        final product = invoice.products[index];
                        final amount = product.price * product.quantity;
                        
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  product.productName,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  product.quantity.toString(),
                                  style: const TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  product.unit,
                                  style: const TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 14),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '\$${amount.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 14),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Summary
                  Row(
                    children: [
                      const Spacer(flex: 6),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Subtotal:',
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  '\$${totalAmount.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Tax (0%):',
                                  style: TextStyle(fontSize: 14),
                                ),
                                const Text(
                                  '\$0.00',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Divider(color: Colors.grey.shade400),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\$${totalAmount.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1DA1F2),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 40),
                  
           
                  
                  const SizedBox(height: 20),
                  
                  
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _sharePdf,
                icon: const Icon(Icons.share, color: Colors.white),
                label: const Text(
                  'Share',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _downloadPdf,
                icon: const Icon(Icons.download, color: Colors.white),
                label: const Text(
                  'Download',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1DA1F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> _captureWidget() async {
    try {
      // Find the repaint boundary
      RenderRepaintBoundary boundary = _printableKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      
      // Capture the image with a higher pixel ratio for better quality
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      
      return byteData!.buffer.asUint8List();
    } catch (e) {
      debugPrint('Error capturing widget: $e');
      rethrow;
    }
  }

  Future<Uint8List> _generatePdf() async {
    setState(() {
      _isGeneratingPdf = true;
    });

    try {
      final Uint8List imageBytes = await _captureWidget();
      
      // Create PDF document
      final pdf = pw.Document();
      
      // Get image dimensions
      final ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      final ui.Image image = frameInfo.image;
      
      // Calculate aspect ratio
      final double aspectRatio = image.width / image.height;
      
      // Create PDF page with proper scaling
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(
                pw.MemoryImage(imageBytes),
                width: PdfPageFormat.a4.width,
                height: PdfPageFormat.a4.width / aspectRatio,
                fit: pw.BoxFit.contain,
              ),
            );
          },
          pageFormat: PdfPageFormat.a4,
        ),
      );
      
      // Generate PDF bytes
      final bytes = await pdf.save();

      setState(() {
        _isGeneratingPdf = false;
      });
      
      return bytes;
    } catch (e) {
      setState(() {
        _isGeneratingPdf = false;
      });
      debugPrint('Error generating PDF: $e');
      rethrow;
    }
  }

  Future<void> _downloadPdf() async {
    try {
      final pdfBytes = await _generatePdf();
      
      // Get application directory
      final directory = await getApplicationDocumentsDirectory();
      final invoiceId = _generateInvoiceNumber(widget.invoice.id);
      final filePath = '${directory.path}/invoice_$invoiceId.pdf';
      
      // Write to file
      final file = File(filePath);
      await file.writeAsBytes(pdfBytes);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invoice saved: $filePath'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving PDF: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _sharePdf() async {
    try {
      final pdfBytes = await _generatePdf();
      
      // Get temporary directory
      final directory = await getTemporaryDirectory();
      final invoiceId = _generateInvoiceNumber(widget.invoice.id);
      final filePath = '${directory.path}/invoice_$invoiceId.pdf';
      
      // Write to file
      final file = File(filePath);
      await file.writeAsBytes(pdfBytes);
      
      // Share the file
      await Share.shareXFiles(
        [XFile(filePath)],
        subject: 'Invoice $invoiceId',
        text: 'Please find attached invoice $invoiceId',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sharing PDF: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}