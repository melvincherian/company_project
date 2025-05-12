// import 'dart:io';
// import 'dart:typed_data';
// import 'package:company_project/models/product_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:share_plus/share_plus.dart';
// import 'dart:ui' as ui;

// class InvoiceDetailScreen extends StatefulWidget {
//   final Invoice invoice;

//   const InvoiceDetailScreen({
//     super.key,
//     required this.invoice,
//   });

//   @override
//   State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
// }

// class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
//   final GlobalKey _printableKey = GlobalKey();
//   bool _isGeneratingPdf = false;

//   String _formatDate(DateTime date) {
//     return DateFormat('MM/dd/yyyy').format(date);
//   }

//   String _generateInvoiceNumber(String id) {
//     return "#${id.substring(0, 7).toUpperCase()}";
//   }

//   @override
//   Widget build(BuildContext context) {
//     final invoice = widget.invoice;
//     final totalAmount = invoice.products.fold<double>(
//       0, (total, product) => total + (product.price * product.quantity)
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Invoice ${_generateInvoiceNumber(invoice.id)}',
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         actions: [
//           if (_isGeneratingPdf)
//             const Center(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0),
//                 child: SizedBox(
//                   width: 20,
//                   height: 20,
//                   child: CircularProgressIndicator(strokeWidth: 2),
//                 ),
//               ),
//             )
//           else
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: _sharePdf,
//                   icon: const Icon(Icons.share),
//                   tooltip: 'Share Invoice',
//                 ),
//                 IconButton(
//                   onPressed: _downloadPdf,
//                   icon: const Icon(Icons.download),
//                   tooltip: 'Download Invoice',
//                 ),
//               ],
//             ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: RepaintBoundary(
//             key: _printableKey,
//             child: Container(
//               color: Colors.white,
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'INVOICE',
//                             style: TextStyle(
//                               fontSize: 32,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF1DA1F2),
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             _generateInvoiceNumber(invoice.id),
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           const Text(
//                             'Company Name',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const Text(
//                             '123 Business Street',
//                             style: TextStyle(fontSize: 14),
//                           ),
//                           const Text(
//                             'City, State ZIP',
//                             style: TextStyle(fontSize: 14),
//                           ),
//                           const Text(
//                             'Phone: (123) 456-7890',
//                             style: TextStyle(fontSize: 14),
//                           ),
//                           const Text(
//                             'Email: info@company.com',
//                             style: TextStyle(fontSize: 14),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
                  
//                   const SizedBox(height: 40),
                  
//                   // Invoice info
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Bill To
//                       // Column(
//                       //   crossAxisAlignment: CrossAxisAlignment.start,
//                       //   children: [
//                       //     const Text(
//                       //       'BILL TO',
//                       //       style: TextStyle(
//                       //         fontSize: 14,
//                       //         fontWeight: FontWeight.bold,
//                       //         color: Colors.grey,
//                       //       ),
//                       //     ),
//                       //     const SizedBox(height: 8),
//                       //     const Text(
//                       //       'Customer Name',
//                       //       style: TextStyle(
//                       //         fontSize: 16,
//                       //         fontWeight: FontWeight.bold,
//                       //       ),
//                       //     ),
//                       //     const Text(
//                       //       'Customer Address',
//                       //       style: TextStyle(fontSize: 14),
//                       //     ),
//                       //     const Text(
//                       //       'City, State ZIP',
//                       //       style: TextStyle(fontSize: 14),
//                       //     ),
//                       //     const Text(
//                       //       'customer@email.com',
//                       //       style: TextStyle(fontSize: 14),
//                       //     ),
//                       //   ],
//                       // ),
                      
//                       // Invoice Details
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Row(
//                             children: [
//                               const Text(
//                                 'Invoice Date: ',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               Text(
//                                 _formatDate(invoice.createdAt),
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 4),
//                           Row(
//                             children: [
//                               const Text(
//                                 'Due Date: ',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               Text(
//                                 _formatDate(invoice.createdAt.add(const Duration(days: 30))),
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
                  
//                   const SizedBox(height: 40),
                  
//                   // Product table header
//                   Container(
//                     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF1DA1F2).withOpacity(0.1),
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(8),
//                         topRight: Radius.circular(8),
//                       ),
//                     ),
//                     child: const Row(
//                       children: [
//                         Expanded(
//                           flex: 4,
//                           child: Text(
//                             'ITEM',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'QTY',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'UNIT',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'PRICE',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                             ),
//                             textAlign: TextAlign.right,
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'AMOUNT',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                             ),
//                             textAlign: TextAlign.right,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
                  
//                   // Product list
//                   Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade300),
//                       borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(8),
//                         bottomRight: Radius.circular(8),
//                       ),
//                     ),
//                     child: ListView.separated(
//                       physics: const NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: invoice.products.length,
//                       separatorBuilder: (context, index) => Divider(
//                         color: Colors.grey.shade300,
//                         height: 1,
//                       ),
//                       itemBuilder: (context, index) {
//                         final product = invoice.products[index];
//                         final amount = product.price * product.quantity;
                        
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 4,
//                                 child: Text(
//                                   product.productName,
//                                   style: const TextStyle(fontSize: 14),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                   product.quantity.toString(),
//                                   style: const TextStyle(fontSize: 14),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                   product.unit,
//                                   style: const TextStyle(fontSize: 14),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                   '\$${product.price.toStringAsFixed(2)}',
//                                   style: const TextStyle(fontSize: 14),
//                                   textAlign: TextAlign.right,
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                   '\$${amount.toStringAsFixed(2)}',
//                                   style: const TextStyle(fontSize: 14),
//                                   textAlign: TextAlign.right,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
                  
//                   const SizedBox(height: 20),
                  
//                   // Summary
//                   Row(
//                     children: [
//                       const Spacer(flex: 6),
//                       Expanded(
//                         flex: 4,
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   'Subtotal:',
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                                 Text(
//                                   '\$${totalAmount.toStringAsFixed(2)}',
//                                   style: const TextStyle(fontSize: 14),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 8),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   'Tax (0%):',
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                                 const Text(
//                                   '\$0.00',
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 8),
//                             Divider(color: Colors.grey.shade400),
//                             const SizedBox(height: 8),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   'Total:',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   '\$${totalAmount.toStringAsFixed(2)}',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF1DA1F2),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
                  
//                   const SizedBox(height: 40),
                  
           
                  
//                   const SizedBox(height: 20),
                  
                  
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: ElevatedButton.icon(
//                 onPressed: _sharePdf,
//                 icon: const Icon(Icons.share, color: Colors.white),
//                 label: const Text(
//                   'Share',
//                   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.grey.shade700,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: ElevatedButton.icon(
//                 onPressed: _downloadPdf,
//                 icon: const Icon(Icons.download, color: Colors.white),
//                 label: const Text(
//                   'Download',
//                   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF1DA1F2),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<Uint8List> _captureWidget() async {
//     try {
//       // Find the repaint boundary
//       RenderRepaintBoundary boundary = _printableKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      
//       // Capture the image with a higher pixel ratio for better quality
//       ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      
//       return byteData!.buffer.asUint8List();
//     } catch (e) {
//       debugPrint('Error capturing widget: $e');
//       rethrow;
//     }
//   }

//   Future<Uint8List> _generatePdf() async {
//     setState(() {
//       _isGeneratingPdf = true;
//     });

//     try {
//       final Uint8List imageBytes = await _captureWidget();
      
//       // Create PDF document
//       final pdf = pw.Document();
      
//       // Get image dimensions
//       final ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
//       final ui.FrameInfo frameInfo = await codec.getNextFrame();
//       final ui.Image image = frameInfo.image;
      
//       // Calculate aspect ratio
//       final double aspectRatio = image.width / image.height;
      
//       // Create PDF page with proper scaling
//       pdf.addPage(
//         pw.Page(
//           build: (pw.Context context) {
//             return pw.Center(
//               child: pw.Image(
//                 pw.MemoryImage(imageBytes),
//                 width: PdfPageFormat.a4.width,
//                 height: PdfPageFormat.a4.width / aspectRatio,
//                 fit: pw.BoxFit.contain,
//               ),
//             );
//           },
//           pageFormat: PdfPageFormat.a4,
//         ),
//       );
      
//       // Generate PDF bytes
//       final bytes = await pdf.save();

//       setState(() {
//         _isGeneratingPdf = false;
//       });
      
//       return bytes;
//     } catch (e) {
//       setState(() {
//         _isGeneratingPdf = false;
//       });
//       debugPrint('Error generating PDF: $e');
//       rethrow;
//     }
//   }

//   Future<void> _downloadPdf() async {
//     try {
//       final pdfBytes = await _generatePdf();
      
//       // Get application directory
//       final directory = await getApplicationDocumentsDirectory();
//       final invoiceId = _generateInvoiceNumber(widget.invoice.id);
//       final filePath = '${directory.path}/invoice_$invoiceId.pdf';
      
//       // Write to file
//       final file = File(filePath);
//       await file.writeAsBytes(pdfBytes);
      
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Invoice saved: $filePath'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error saving PDF: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   Future<void> _sharePdf() async {
//     try {
//       final pdfBytes = await _generatePdf();
      
//       // Get temporary directory
//       final directory = await getTemporaryDirectory();
//       final invoiceId = _generateInvoiceNumber(widget.invoice.id);
//       final filePath = '${directory.path}/invoice_$invoiceId.pdf';
      
//       // Write to file
//       final file = File(filePath);
//       await file.writeAsBytes(pdfBytes);
      
//       // Share the file
//       await Share.shareXFiles(
//         [XFile(filePath)],
//         subject: 'Invoice $invoiceId',
//         text: 'Please find attached invoice $invoiceId',
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error sharing PDF: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
// }






// import 'dart:io';
// import 'dart:typed_data';
// import 'package:company_project/models/product_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:share_plus/share_plus.dart';
// import 'dart:ui' as ui;
// import 'package:shared_preferences/shared_preferences.dart';

// class InvoiceDetailScreen extends StatefulWidget {
//   final Invoice invoice;

//   const InvoiceDetailScreen({
//     super.key,
//     required this.invoice,
//   });

//   @override
//   State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
// }

// class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
//   final GlobalKey _printableKey = GlobalKey();
//   bool _isGeneratingPdf = false;

//   // Variables to store user data
//   String businessName = 'Company Name';
//   String mobile = '(123) 456-7890';
//   String email = 'info@company.com';
//   String gst = 'Not Available';

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   // Load user data from SharedPreferences
//   Future<void> _loadUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       businessName = prefs.getString('businessName') ?? 'Company Name';
//       mobile = prefs.getString('mobile') ?? '(123) 456-7890';
//       email = prefs.getString('email') ?? 'info@company.com';
//       gst = prefs.getString('gst') ?? 'Not Available';
//     });
//   }

//   String _formatDate(DateTime date) {
//     return DateFormat('MM/dd/yyyy').format(date);
//   }

//   String _generateInvoiceNumber(String id) {
//     return "#${id.substring(0, 7).toUpperCase()}";
//   }

//   @override
//   Widget build(BuildContext context) {
//     final invoice = widget.invoice;
//     final totalAmount = invoice.products.fold<double>(
//       0, (total, product) => total + (product.price * product.quantity)
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Invoice ${_generateInvoiceNumber(invoice.id)}',
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         actions: [
//           if (_isGeneratingPdf)
//             const Center(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0),
//                 child: SizedBox(
//                   width: 20,
//                   height: 20,
//                   child: CircularProgressIndicator(strokeWidth: 2),
//                 ),
//               ),
//             )
//           else
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: _sharePdf,
//                   icon: const Icon(Icons.share),
//                   tooltip: 'Share Invoice',
//                 ),
//                 IconButton(
//                   onPressed: _downloadPdf,
//                   icon: const Icon(Icons.download),
//                   tooltip: 'Download Invoice',
//                 ),
//               ],
//             ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: RepaintBoundary(
//             key: _printableKey,
//             child: Container(
//               color: Colors.white,
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'INVOICE',
//                             style: TextStyle(
//                               fontSize: 32,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF1DA1F2),
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             _generateInvoiceNumber(invoice.id),
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             businessName,
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const Text(
//                             '123 Business Street',
//                             style: TextStyle(fontSize: 14),
//                           ),
//                           const Text(
//                             'City, State ZIP',
//                             style: TextStyle(fontSize: 14),
//                           ),
//                           Text(
//                             'Phone: $mobile',
//                             style: const TextStyle(fontSize: 14),
//                           ),
//                           Text(
//                             'Email: $email',
//                             style: const TextStyle(fontSize: 14),
//                           ),
//                           const SizedBox(height: 8),
//                           // Display GST
//                           Row(
//                             children: [
//                               const Text(
//                                 'GST: ',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 gst,
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
                  
//                   const SizedBox(height: 40),
                  
//                   // Invoice info
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Bill To section can be uncommented if needed
                      
//                       // Invoice Details
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Row(
//                             children: [
//                               const Text(
//                                 'Invoice Date: ',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               Text(
//                                 _formatDate(invoice.createdAt),
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 4),
//                           Row(
//                             children: [
//                               const Text(
//                                 'Due Date: ',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               Text(
//                                 _formatDate(invoice.createdAt.add(const Duration(days: 30))),
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
                  
//                   const SizedBox(height: 40),
                  
//                   // Product table header
//                   Container(
//                     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF1DA1F2).withOpacity(0.1),
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(8),
//                         topRight: Radius.circular(8),
//                       ),
//                     ),
//                     child: const Row(
//                       children: [
//                         Expanded(
//                           flex: 4,
//                           child: Text(
//                             'ITEM',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'QTY',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'UNIT',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'PRICE',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                             ),
//                             textAlign: TextAlign.right,
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'AMOUNT',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                             ),
//                             textAlign: TextAlign.right,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
                  
//                   // Product list
//                   Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade300),
//                       borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(8),
//                         bottomRight: Radius.circular(8),
//                       ),
//                     ),
//                     child: ListView.separated(
//                       physics: const NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: invoice.products.length,
//                       separatorBuilder: (context, index) => Divider(
//                         color: Colors.grey.shade300,
//                         height: 1,
//                       ),
//                       itemBuilder: (context, index) {
//                         final product = invoice.products[index];
//                         final amount = product.price * product.quantity;
                        
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 4,
//                                 child: Text(
//                                   product.productName,
//                                   style: const TextStyle(fontSize: 14),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                   product.quantity.toString(),
//                                   style: const TextStyle(fontSize: 14),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                   product.unit,
//                                   style: const TextStyle(fontSize: 14),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                   '\$${product.price.toStringAsFixed(2)}',
//                                   style: const TextStyle(fontSize: 14),
//                                   textAlign: TextAlign.right,
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                   '\$${amount.toStringAsFixed(2)}',
//                                   style: const TextStyle(fontSize: 14),
//                                   textAlign: TextAlign.right,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
                  
//                   const SizedBox(height: 20),
                  
//                   // Summary
//                   Row(
//                     children: [
//                       const Spacer(flex: 6),
//                       Expanded(
//                         flex: 4,
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   'Subtotal:',
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                                 Text(
//                                   '\$${totalAmount.toStringAsFixed(2)}',
//                                   style: const TextStyle(fontSize: 14),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 8),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   'Tax (0%):',
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                                 const Text(
//                                   '\$0.00',
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 8),
//                             Divider(color: Colors.grey.shade400),
//                             const SizedBox(height: 8),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   'Total:',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   '\$${totalAmount.toStringAsFixed(2)}',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF1DA1F2),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
                  
//                   const SizedBox(height: 40),
                  
//                   // Add GST info in footer section
//                   Align(
//                     alignment: Alignment.center,
//                     child: Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey.shade300),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Column(
//                         children: [
//                           Text(
//                             'GST Number: $gst',
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           const Text(
//                             'Thank you for your business!',
//                             style: TextStyle(fontSize: 14),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
                  
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: ElevatedButton.icon(
//                 onPressed: _sharePdf,
//                 icon: const Icon(Icons.share, color: Colors.white),
//                 label: const Text(
//                   'Share',
//                   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.grey.shade700,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: ElevatedButton.icon(
//                 onPressed: _downloadPdf,
//                 icon: const Icon(Icons.download, color: Colors.white),
//                 label: const Text(
//                   'Download',
//                   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF1DA1F2),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<Uint8List> _captureWidget() async {
//     try {
//       // Find the repaint boundary
//       RenderRepaintBoundary boundary = _printableKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      
//       // Capture the image with a higher pixel ratio for better quality
//       ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      
//       return byteData!.buffer.asUint8List();
//     } catch (e) {
//       debugPrint('Error capturing widget: $e');
//       rethrow;
//     }
//   }

//   Future<Uint8List> _generatePdf() async {
//     setState(() {
//       _isGeneratingPdf = true;
//     });

//     try {
//       final Uint8List imageBytes = await _captureWidget();
      
//       // Create PDF document
//       final pdf = pw.Document();
      
//       // Get image dimensions
//       final ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
//       final ui.FrameInfo frameInfo = await codec.getNextFrame();
//       final ui.Image image = frameInfo.image;
      
//       // Calculate aspect ratio
//       final double aspectRatio = image.width / image.height;
      
//       // Create PDF page with proper scaling
//       pdf.addPage(
//         pw.Page(
//           build: (pw.Context context) {
//             return pw.Center(
//               child: pw.Image(
//                 pw.MemoryImage(imageBytes),
//                 width: PdfPageFormat.a4.width,
//                 height: PdfPageFormat.a4.width / aspectRatio,
//                 fit: pw.BoxFit.contain,
//               ),
//             );
//           },
//           pageFormat: PdfPageFormat.a4,
//         ),
//       );
      
//       // Generate PDF bytes
//       final bytes = await pdf.save();

//       setState(() {
//         _isGeneratingPdf = false;
//       });
      
//       return bytes;
//     } catch (e) {
//       setState(() {
//         _isGeneratingPdf = false;
//       });
//       debugPrint('Error generating PDF: $e');
//       rethrow;
//     }
//   }

//   Future<void> _downloadPdf() async {
//     try {
//       final pdfBytes = await _generatePdf();
      
//       // Get application directory
//       final directory = await getApplicationDocumentsDirectory();
//       final invoiceId = _generateInvoiceNumber(widget.invoice.id);
//       final filePath = '${directory.path}/invoice_$invoiceId.pdf';
      
//       // Write to file
//       final file = File(filePath);
//       await file.writeAsBytes(pdfBytes);
      
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Invoice saved: $filePath'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error saving PDF: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   Future<void> _sharePdf() async {
//     try {
//       final pdfBytes = await _generatePdf();
      
//       // Get temporary directory
//       final directory = await getTemporaryDirectory();
//       final invoiceId = _generateInvoiceNumber(widget.invoice.id);
//       final filePath = '${directory.path}/invoice_$invoiceId.pdf';
      
//       // Write to file
//       final file = File(filePath);
//       await file.writeAsBytes(pdfBytes);
      
//       // Share the file
//       await Share.shareXFiles(
//         [XFile(filePath)],
//         subject: 'Invoice $invoiceId',
//         text: 'Please find attached invoice $invoiceId',
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error sharing PDF: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
// }









// import 'dart:io';
// import 'dart:typed_data';
// import 'package:company_project/models/product_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:share_plus/share_plus.dart';
// import 'dart:ui' as ui;
// import 'package:shared_preferences/shared_preferences.dart';

// class InvoiceDetailScreen extends StatefulWidget {
//   final Invoice invoice;

//   const InvoiceDetailScreen({
//     super.key,
//     required this.invoice,
//   });

//   @override
//   State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
// }

// class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
//   final GlobalKey _printableKey = GlobalKey();
//   bool _isGeneratingPdf = false;

//   // Variables to store user data
//   String businessName = 'Design Studio';
//   String mobile = '(123) 456-7890';
//   String email = 'designstudio@email.com';
//   String bankAccount = '1234-5678-9012-3456';
//   String bankName = 'Bank Transfer';
//   String gst = 'Not Available';

//   // Client data - in a real app this would be part of the invoice model
//   String clientName = 'Narasimhavarma';
//   String clientCompany = 'PixelMindsolutions';
//   String clientAddress = '123 Elm Street Green Valley';
//   String clientPhone = '9961593179';
//   String clientEmail = 'varma@email.com';

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   // Load user data from SharedPreferences
//   Future<void> _loadUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       businessName = prefs.getString('businessName') ?? 'Design Studio';
//       mobile = prefs.getString('mobile') ?? '(123) 456-7890';
//       email = prefs.getString('email') ?? 'designstudio@email.com';
//       bankAccount = prefs.getString('bankAccount') ?? '1234-5678-9012-3456';
//       bankName = prefs.getString('bankName') ?? 'Bank Transfer';
//        gst = prefs.getString('gst') ?? 'Not Available';
//     });
//   }

//   String _formatDate(DateTime date) {
//     return DateFormat('MMMM dd, yyyy').format(date);
//   }

//   String _generateInvoiceNumber(String id) {
//     return "SI${DateTime.now().year}-${id.substring(0, 3)}";
//   }

//   @override
//   Widget build(BuildContext context) {
//     final invoice = widget.invoice;
//     final dueDate = invoice.createdAt.add(const Duration(days: 20));
//     final totalAmount = invoice.products.fold<double>(
//       0, (total, product) => total + (product.price * product.quantity)
//     );


//      double gstRate = 0.0;
//     if (gst != 'Not Available') {
//       // Try to parse the GST value (handle formats like "18%" or "18")
//       String gstValue = gst.replaceAll('%', '').trim();
//       try {
//         gstRate = double.parse(gstValue) / 100; // Convert percentage to decimal
//       } catch (e) {
//         debugPrint('Error parsing GST rate: $e');
//         // Keep default 0.0 if parsing fails
//       }
//     }
//     final tax = totalAmount * gstRate; // 8% tax rate
//     final totalWithTax = totalAmount + tax;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Invoice ${_generateInvoiceNumber(invoice.id)}',
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         actions: [
//           if (_isGeneratingPdf)
//             const Center(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0),
//                 child: SizedBox(
//                   width: 20,
//                   height: 20,
//                   child: CircularProgressIndicator(strokeWidth: 2),
//                 ),
//               ),
//             )
//           else
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: _sharePdf,
//                   icon: const Icon(Icons.share),
//                   tooltip: 'Share Invoice',
//                 ),
//                 IconButton(
//                   onPressed: _downloadPdf,
//                   icon: const Icon(Icons.download),
//                   tooltip: 'Download Invoice',
//                 ),
//               ],
//             ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: RepaintBoundary(
//             key: _printableKey,
//             child: Container(
//               color: Colors.white,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Top teal accent
//                   Container(
//                     height: 15,
//                     color: const Color(0xFF4ACBBC),
//                   ),
                  
//                   // Navy header
//                   Container(
//                     color: const Color(0xFF0E2945),
//                     width: double.infinity,
//                     height: 8,
//                   ),
                  
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Header with logo and invoice title
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Invoice title
//                             const Text(
//                               'INVOICE',
//                               style: TextStyle(
//                                 fontSize: 38,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                                 letterSpacing: 1.5,
//                               ),
//                             ),
                            
//                             // Logo
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFFFFC84D),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               padding: const EdgeInsets.all(10),
//                               height: 70,
//                               width: 70,
//                               child: const Center(
//                                 child: Text(
//                                   'd',
//                                   style: TextStyle(
//                                     fontSize: 40,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
                        
//                         const SizedBox(height: 16),
                        
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Bill To Section
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     'Bill To:',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
                                  
//                                   Text(
//                                     'Client Name: $clientName',
//                                     style: const TextStyle(fontSize: 14),
//                                   ),
//                                   Text(
//                                     'Company Name: $clientCompany',
//                                     style: const TextStyle(fontSize: 14),
//                                   ),
//                                   Text(
//                                     'Billing Address: $clientAddress',
//                                     style: const TextStyle(fontSize: 14),
//                                   ),
//                                   Text(
//                                     'Phone: $clientPhone',
//                                     style: const TextStyle(fontSize: 14),
//                                   ),
//                                   Text(
//                                     'Email: $clientEmail',
//                                     style: const TextStyle(fontSize: 14),
//                                   ),
//                                 ],
//                               ),
//                             ),
                            
//                             // Invoice Details
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       const Text(
//                                         'Invoice Number: ',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                       Text(
//                                         _generateInvoiceNumber(invoice.id),
//                                         style: const TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       const Text(
//                                         'Invoice Date: ',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                       Text(
//                                         _formatDate(invoice.createdAt),
//                                         style: const TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
                        
//                         const SizedBox(height: 30),
                        
//                         // Service Details
//                         const Text(
//                           'Service Details:',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
                        
//                         // Table header with gold background
//                         Container(
//                           decoration: const BoxDecoration(
//                             color: Color(0xFFFFC84D),
//                           ),
//                           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//                           child: const Row(
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Text(
//                                   'No',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 4,
//                                 child: Text(
//                                   'Description of Service',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                   'Quantity',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                   'Rate (₹)',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14,
//                                   ),
//                                   textAlign: TextAlign.right,
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                   'Total (₹)',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14,
//                                   ),
//                                   textAlign: TextAlign.right,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
                        
//                         // Service items
//                         ListView.builder(
//                           physics: const NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           itemCount: invoice.products.length,
//                           itemBuilder: (context, index) {
//                             final product = invoice.products[index];
//                             final amount = product.price * product.quantity;
//                             final isEven = index % 2 == 0;
                            
//                             return Container(
//                               color: isEven ? Colors.grey.shade200 : Colors.white,
//                               padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     flex: 1,
//                                     child: Text(
//                                       '${index + 1}',
//                                       style: const TextStyle(fontSize: 14),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 4,
//                                     child: Text(
//                                       product.productName,
//                                       style: const TextStyle(fontSize: 14),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       product.quantity.toString() + (product.unit.isNotEmpty ? ' ${product.unit}' : ''),
//                                       style: const TextStyle(fontSize: 14),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       '\$${product.price.toStringAsFixed(2)}',
//                                       style: const TextStyle(fontSize: 14),
//                                       textAlign: TextAlign.right,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       '\$${amount.toStringAsFixed(2)}',
//                                       style: const TextStyle(fontSize: 14),
//                                       textAlign: TextAlign.right,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
                        
//                         const SizedBox(height: 20),
                        
//                         // Terms and Conditions and Summary
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Terms and Conditions
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     'Terms and Conditions:',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   const Text(
//                                     '• Payment is due upon receipt of this invoice.',
//                                     style: TextStyle(fontSize: 14),
//                                   ),
//                                   const Text(
//                                     '• Late payments may incur additional charges.',
//                                     style: TextStyle(fontSize: 14),
//                                   ),
//                                   const Text(
//                                     '• Please make checks payable to Your Graphic',
//                                     style: TextStyle(fontSize: 14),
//                                   ),
//                                   const Text(
//                                     '  Design Studio.',
//                                     style: TextStyle(fontSize: 14),
//                                   ),
//                                 ],
//                               ),
//                             ),
                            
//                             // Summary
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       const Text(
//                                         'Subtotal',
//                                         style: TextStyle(fontSize: 14),
//                                       ),
//                                       Text(
//                                         '\$${totalAmount.toStringAsFixed(2)}',
//                                         style: const TextStyle(fontSize: 14),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       const Text(
//                                         'GST',
//                                         style: TextStyle(fontSize: 14),
//                                       ),
//                                        Text(
//                                         'Tax (${gst != 'Not Available' ? gst : '0%'})',
//                                         style: const TextStyle(fontSize: 14),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 8),
//                                   const Divider(),
//                                   const SizedBox(height: 8),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       const Text(
//                                         'Total Amount Due',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       Text(
//                                         '\$${totalWithTax.toStringAsFixed(2)}',
//                                         style: const TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
                  
//                   // Payment Information - Navy background
//                   Container(
//                     color: const Color(0xFF0E2945),
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Payment Information:',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Row(
//                           children: [
//                             // Payment Details
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       const Text(
//                                         'Payment Method: ',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       Text(
//                                         bankName,
//                                         style: const TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Row(
//                                     children: [
//                                       const Text(
//                                         'Due Date: ',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       Text(
//                                         _formatDate(dueDate),
//                                         style: const TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Row(
//                                     children: [
//                                       const Text(
//                                         'Bank Account: ',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       Text(
//                                         bankAccount,
//                                         style: const TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
                            
//                             // Signature
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   const Text(
//                                     'Date: ',
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   Text(
//                                     _formatDate(invoice.createdAt),
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 20),
//                                   const Text(
//                                     '- Signature -',
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       fontStyle: FontStyle.italic,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   const Text(
//                                     'John Smith',
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
                  
//                   // Questions Section
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Questions',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Email US: $email',
//                           style: const TextStyle(fontSize: 14),
//                         ),
//                         Text(
//                           'Call US: $mobile',
//                           style: const TextStyle(fontSize: 14),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: ElevatedButton.icon(
//                 onPressed: _sharePdf,
//                 icon: const Icon(Icons.share, color: Colors.white),
//                 label: const Text(
//                   'Share',
//                   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.grey.shade700,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: ElevatedButton.icon(
//                 onPressed: _downloadPdf,
//                 icon: const Icon(Icons.download, color: Colors.white),
//                 label: const Text(
//                   'Download',
//                   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF4ACBBC),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<Uint8List> _captureWidget() async {
//     try {
//       // Find the repaint boundary
//       RenderRepaintBoundary boundary = _printableKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      
//       // Capture the image with a higher pixel ratio for better quality
//       ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      
//       return byteData!.buffer.asUint8List();
//     } catch (e) {
//       debugPrint('Error capturing widget: $e');
//       rethrow;
//     }
//   }

//   Future<Uint8List> _generatePdf() async {
//     setState(() {
//       _isGeneratingPdf = true;
//     });

//     try {
//       final Uint8List imageBytes = await _captureWidget();
      
//       // Create PDF document
//       final pdf = pw.Document();
      
//       // Get image dimensions
//       final ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
//       final ui.FrameInfo frameInfo = await codec.getNextFrame();
//       final ui.Image image = frameInfo.image;
      
//       // Calculate aspect ratio
//       final double aspectRatio = image.width / image.height;
      
//       // Create PDF page with proper scaling
//       pdf.addPage(
//         pw.Page(
//           build: (pw.Context context) {
//             return pw.Center(
//               child: pw.Image(
//                 pw.MemoryImage(imageBytes),
//                 width: PdfPageFormat.a5.width,
//                 height: PdfPageFormat.a5.width / aspectRatio,
//                 fit: pw.BoxFit.contain,
//               ),
//             );
//           },
//           pageFormat: PdfPageFormat.a4,
//         ),
//       );
      
//       // Generate PDF bytes
//       final bytes = await pdf.save();

//       setState(() {
//         _isGeneratingPdf = false;
//       });
      
//       return bytes;
//     } catch (e) {
//       setState(() {
//         _isGeneratingPdf = false;
//       });
//       debugPrint('Error generating PDF: $e');
//       rethrow;
//     }
//   }

//   Future<void> _downloadPdf() async {
//     try {
//       final pdfBytes = await _generatePdf();
      
//       // Get application directory
//       final directory = await getApplicationDocumentsDirectory();
//       final invoiceId = _generateInvoiceNumber(widget.invoice.id);
//       final filePath = '${directory.path}/invoice_$invoiceId.pdf';
      
//       // Write to file
//       final file = File(filePath);
//       await file.writeAsBytes(pdfBytes);
      
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Invoice saved: $filePath'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error saving PDF: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   Future<void> _sharePdf() async {
//     try {
//       final pdfBytes = await _generatePdf();
      
//       // Get temporary directory
//       final directory = await getTemporaryDirectory();
//       final invoiceId = _generateInvoiceNumber(widget.invoice.id);
//       final filePath = '${directory.path}/invoice_$invoiceId.pdf';
      
//       // Write to file
//       final file = File(filePath);
//       await file.writeAsBytes(pdfBytes);
      
//       // Share the file
//       await Share.shareXFiles(
//         [XFile(filePath)],
//         subject: 'Invoice $invoiceId',
//         text: 'Please find attached invoice $invoiceId',
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error sharing PDF: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
// }










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
import 'package:shared_preferences/shared_preferences.dart';

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

  // Variables to store user data
  String businessName = 'Design Studio';
  String mobile = '(123) 456-7890';
  String email = 'designstudio@email.com';
  String bankAccount = '1234-5678-9012-3456';
  String bankName = 'Bank Transfer';
  String gst = 'Not Available';

  // Client data - in a real app this would be part of the invoice model
  String clientName = 'Narasimhavarma';
  String clientCompany = 'PixelMindsolutions';
  String clientAddress = '123 Elm Street Green Valley';
  String clientPhone = '9961593179';
  String clientEmail = 'varma@email.com';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      businessName = prefs.getString('businessName') ?? 'Design Studio';
      mobile = prefs.getString('mobile') ?? '(123) 456-7890';
      email = prefs.getString('email') ?? 'designstudio@email.com';
      bankAccount = prefs.getString('bankAccount') ?? '1234-5678-9012-3456';
      bankName = prefs.getString('bankName') ?? 'Bank Transfer';
      gst = prefs.getString('gst') ?? 'Not Available';
    });
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMMM dd, yyyy').format(date);
  }

  String _generateInvoiceNumber(String id) {
    return "SI${DateTime.now().year}-${id.substring(0, 3)}";
  }

  @override
  Widget build(BuildContext context) {
    final invoice = widget.invoice;
    final dueDate = invoice.createdAt.add(const Duration(days: 20));
    final totalAmount = invoice.products.fold<double>(
      0, (total, product) => total + (product.price * product.quantity)
    );

    double gstRate = 0.0;
    if (gst != 'Not Available') {
      // Try to parse the GST value (handle formats like "18%" or "18")
      String gstValue = gst.replaceAll('%', '').trim();
      try {
        gstRate = double.parse(gstValue) / 100; // Convert percentage to decimal
      } catch (e) {
        debugPrint('Error parsing GST rate: $e');
        // Keep default 0.0 if parsing fails
      }
    }
    final tax = totalAmount * gstRate;
    final totalWithTax = totalAmount + tax;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Your existing invoice UI code here
                  // ... (all the UI elements)
                  
                  // Top teal accent
                  Container(
                    height: 15,
                    color: const Color(0xFF4ACBBC),
                  ),
                  
                  // Navy header
                  Container(
                    color: const Color(0xFF0E2945),
                    width: double.infinity,
                    height: 8,
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with logo and invoice title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Invoice title
                            const Text(
                              'INVOICE',
                              style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                letterSpacing: 1.5,
                              ),
                            ),
                            
                            // Logo
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFC84D),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(10),
                              height: 70,
                              width: 70,
                              child: const Center(
                                child: Text(
                                  'd',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Bill To Section
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Bill To:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  
                                  Text(
                                    'Client Name: $clientName',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    'Company Name: $clientCompany',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    'Billing Address: $clientAddress',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    'Phone: $clientPhone',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    'Email: $clientEmail',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Invoice Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'Invoice Number: ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        _generateInvoiceNumber(invoice.id),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'Invoice Date: ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
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
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Service Details
                        const Text(
                          'Service Details:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        
                        // Table header with gold background
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFC84D),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                          child: const Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'No',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  'Description of Service',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Quantity',
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
                                  'Rate (₹)',
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
                                  'Total (₹)',
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
                        
                        // Service items
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: invoice.products.length,
                          itemBuilder: (context, index) {
                            final product = invoice.products[index];
                            final amount = product.price * product.quantity;
                            final isEven = index % 2 == 0;
                            
                            return Container(
                              color: isEven ? Colors.grey.shade200 : Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
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
                                      product.quantity.toString() + (product.unit.isNotEmpty ? ' ${product.unit}' : ''),
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
                        
                        const SizedBox(height: 20),
                        
                        // Terms and Conditions and Summary
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Terms and Conditions
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Terms and Conditions:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    '• Payment is due upon receipt of this invoice.',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  const Text(
                                    '• Late payments may incur additional charges.',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  const Text(
                                    '• Please make checks payable to Your Graphic',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  const Text(
                                    '  Design Studio.',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Summary
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Subtotal',
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
                                        'GST',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                       Text(
                                        'Tax (${gst != 'Not Available' ? gst : '0%'})',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Divider(),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Total Amount Due',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '\$${totalWithTax.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Payment Information - Navy background
                  Container(
                    color: const Color(0xFF0E2945),
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Payment Information:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            // Payment Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Payment Method: ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        bankName,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
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
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        _formatDate(dueDate),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Text(
                                        'Bank Account: ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        bankAccount,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            // Signature
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Date: ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    _formatDate(invoice.createdAt),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    '- Signature -',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'John Smith',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Questions Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Questions',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Email US: $email',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Call US: $mobile',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
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
                  backgroundColor: const Color(0xFF4ACBBC),
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

  // NEW IMPROVED PDF GENERATION METHOD
  // This directly builds a PDF document using the pw library rather than capturing a widget
  Future<Uint8List> _generatePdf() async {
    setState(() {
      _isGeneratingPdf = true;
    });

    try {
      final invoice = widget.invoice;
      final invoiceId = _generateInvoiceNumber(invoice.id);
      final dueDate = invoice.createdAt.add(const Duration(days: 20));
      final totalAmount = invoice.products.fold<double>(
        0, (total, product) => total + (product.price * product.quantity)
      );

      double gstRate = 0.0;
      if (gst != 'Not Available') {
        String gstValue = gst.replaceAll('%', '').trim();
        try {
          gstRate = double.parse(gstValue) / 100;
        } catch (e) {
          debugPrint('Error parsing GST rate: $e');
        }
      }
      final tax = totalAmount * gstRate;
      final totalWithTax = totalAmount + tax;

      // Create a PDF document directly with pw
      final pdf = pw.Document();

      // Add a page to the PDF document
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return [
              // Top teal accent
              pw.Container(
                height: 15,
                color: PdfColor.fromInt(0xFF4ACBBC),
              ),
              
              // Navy header
              pw.Container(
                color: PdfColor.fromInt(0xFF0E2945),
                width: double.infinity,
                height: 8,
              ),
              
              pw.SizedBox(height: 16),
              
              // Header with logo and invoice title
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Invoice title
                  pw.Text(
                    'INVOICE',
                    style: pw.TextStyle(
                      fontSize: 38,
                      fontWeight: pw.FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  
                  // Logo
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromInt(0xFFFFC84D),
                      borderRadius: pw.BorderRadius.circular(8),
                    ),
                    padding: const pw.EdgeInsets.all(10),
                    height: 70,
                    width: 70,
                    child: pw.Center(
                      child: pw.Text(
                        'd',
                        style: pw.TextStyle(
                          fontSize: 40,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              pw.SizedBox(height: 16),
              
              // Bill To and Invoice Details
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Bill To Section
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Bill To:',
                          style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 8),
                        
                        pw.Text('Client Name: $clientName', style: const pw.TextStyle(fontSize: 14)),
                        pw.Text('Company Name: $clientCompany', style: const pw.TextStyle(fontSize: 14)),
                        pw.Text('Billing Address: $clientAddress', style: const pw.TextStyle(fontSize: 14)),
                        pw.Text('Phone: $clientPhone', style: const pw.TextStyle(fontSize: 14)),
                        pw.Text('Email: $clientEmail', style: const pw.TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                  
                  // Invoice Details
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.end,
                          children: [
                            pw.Text(
                              'Invoice Number: ',
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              invoiceId,
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 4),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.end,
                          children: [
                            pw.Text(
                              'Invoice Date: ',
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              _formatDate(invoice.createdAt),
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              pw.SizedBox(height: 30),
              
              // Service Details
              pw.Text(
                'Service Details:',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              
              // Table header with gold background
              pw.Container(
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromInt(0xFFFFC84D),
                ),
                padding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 1,
                      child: pw.Text(
                        'No',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    pw.Expanded(
  flex: 1,
  child: pw.Text(
    'No',
    style: pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: 14,
    ),
  ),
),
pw.Expanded(
  flex: 4,
  child: pw.Text(
    'Description of Service',
    style: pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: 14,
    ),
  ),
),
pw.Expanded(
  flex: 2,
  child: pw.Text(
    'Quantity',
    style: pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: 14,
    ),
    textAlign: pw.TextAlign.center,
  ),
),
pw.Expanded(
  flex: 2,
  child: pw.Text(
    'Rate (₹)',
    style: pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: 14,
    ),
    textAlign: pw.TextAlign.right,
  ),
),
pw.Expanded(
  flex: 2,
  child: pw.Text(
    'Total (₹)',
    style: pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: 14,
    ),
    textAlign: pw.TextAlign.right,
  ),
),
],
),
),

// Service items
...invoice.products.asMap().entries.map((entry) {
  final index = entry.key;
  final product = entry.value;
  final amount = product.price * product.quantity;
  final isEven = index % 2 == 0;
  
  return pw.Container(
    color: isEven ? PdfColors.grey200 : PdfColors.white,
    padding: const pw.EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    child: pw.Row(
      children: [
        pw.Expanded(
          flex: 1,
          child: pw.Text(
            '${index + 1}',
            style: const pw.TextStyle(fontSize: 14),
          ),
        ),
        pw.Expanded(
          flex: 4,
          child: pw.Text(
            product.productName,
            style: const pw.TextStyle(fontSize: 14),
          ),
        ),
        pw.Expanded(
          flex: 2,
          child: pw.Text(
            product.quantity.toString() + (product.unit.isNotEmpty ? ' ${product.unit}' : ''),
            style: const pw.TextStyle(fontSize: 14),
            textAlign: pw.TextAlign.center,
          ),
        ),
        pw.Expanded(
          flex: 2,
          child: pw.Text(
            '\Rs${product.price.toStringAsFixed(2)}',
            style: const pw.TextStyle(fontSize: 14),
            textAlign: pw.TextAlign.right,
          ),
        ),
        pw.Expanded(
          flex: 2,
          child: pw.Text(
            '\$${amount.toStringAsFixed(2)}',
            style: const pw.TextStyle(fontSize: 14),
            textAlign: pw.TextAlign.right,
          ),
        ),
      ],
    ),
  );
}).toList(),

pw.SizedBox(height: 20),

// Terms and Conditions and Summary
pw.Row(
  crossAxisAlignment: pw.CrossAxisAlignment.start,
  children: [
    // Terms and Conditions
    pw.Expanded(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Terms and Conditions:',
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            '• Payment is due upon receipt of this invoice.',
            style: const pw.TextStyle(fontSize: 14),
          ),
          pw.Text(
            '• Late payments may incur additional charges.',
            style: const pw.TextStyle(fontSize: 14),
          ),
          pw.Text(
            '• Please make checks payable to Your Graphic',
            style: const pw.TextStyle(fontSize: 14),
          ),
          pw.Text(
            '  Design Studio.',
            style: const pw.TextStyle(fontSize: 14),
          ),
        ],
      ),
    ),
    
    // Summary
    pw.Expanded(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Subtotal',
                style: const pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                '\Rs${totalAmount.toStringAsFixed(2)}',
                style: const pw.TextStyle(fontSize: 14),
              ),
            ],
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Tax',
                style: const pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                '(${gst != 'Not Available' ? gst : '0%'})',
                style: const pw.TextStyle(fontSize: 14),
              ),
            ],
          ),
          pw.SizedBox(height: 8),
          pw.Divider(),
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Total Amount Due',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                '\Rs${totalWithTax.toStringAsFixed(2)}',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ],
),

// Payment Information - Navy background
pw.Container(
  color: PdfColor.fromInt(0xFF0E2945),
  width: double.infinity,
  padding: const pw.EdgeInsets.all(16),
  child: pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        'Payment Information:',
        style: pw.TextStyle(
          fontSize: 18,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.white,
        ),
      ),
      pw.SizedBox(height: 16),
      pw.Row(
        children: [
          // Payment Details
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text(
                      'Payment Method: ',
                      style: const pw.TextStyle(
                        fontSize: 14,
                        color: PdfColors.white,
                      ),
                    ),
                    pw.Text(
                      bankName,
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 4),
                pw.Row(
                  children: [
                    pw.Text(
                      'Due Date: ',
                      style: const pw.TextStyle(
                        fontSize: 14,
                        color: PdfColors.white,
                      ),
                    ),
                    pw.Text(
                      _formatDate(dueDate),
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 4),
                pw.Row(
                  children: [
                    pw.Text(
                      'Bank Account: ',
                      style: const pw.TextStyle(
                        fontSize: 14,
                        color: PdfColors.white,
                      ),
                    ),
                    pw.Text(
                      bankAccount,
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Signature
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  'Date: ',
                  style: const pw.TextStyle(
                    fontSize: 14,
                    color: PdfColors.white,
                  ),
                ),
                pw.Text(
                  _formatDate(invoice.createdAt),
                  style: const pw.TextStyle(
                    fontSize: 14,
                    color: PdfColors.white,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  '- Signature -',
                  style:  pw.TextStyle(
                    fontSize: 14,
                    fontStyle: pw.FontStyle.italic,
                    color: PdfColors.white,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'John Smith',
                  style: const pw.TextStyle(
                    fontSize: 14,
                    color: PdfColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  ),
),

// Questions Section
pw.Padding(
  padding: const pw.EdgeInsets.all(16.0),
  child: pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        'Questions',
        style: pw.TextStyle(
          fontSize: 18,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
      pw.SizedBox(height: 8),
      pw.Text(
        'Email US: $email',
        style: const pw.TextStyle(fontSize: 14),
      ),
      pw.Text(
        'Call US: $mobile',
        style: const pw.TextStyle(fontSize: 14),
      ),
    ],
  ),
),
];
},
),
);

      // Build the PDF file as bytes
      final pdfBytes = await pdf.save();
      setState(() {
        _isGeneratingPdf = false;
      });
      
      return pdfBytes;
    } catch (e) {
      debugPrint('Error generating PDF: $e');
      setState(() {
        _isGeneratingPdf = false;
      });
      return Uint8List(0);
    }
  }

  Future<void> _sharePdf() async {
    final pdfBytes = await _generatePdf();
    if (pdfBytes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to generate PDF')),
      );
      return;
    }

    final invoiceId = _generateInvoiceNumber(widget.invoice.id);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/Invoice_$invoiceId.pdf');
    await file.writeAsBytes(pdfBytes);

    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Invoice $invoiceId',
    );
  }

  Future<void> _downloadPdf() async {
    final pdfBytes = await _generatePdf();
    if (pdfBytes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to generate PDF')),
      );
      return;
    }

    try {
      final invoiceId = _generateInvoiceNumber(widget.invoice.id);
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/Invoice_$invoiceId.pdf';
      final file = File(filePath);
      await file.writeAsBytes(pdfBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invoice saved to: $filePath'),
          duration: const Duration(seconds: 5),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving file: $e')),
      );
    }
  }
}