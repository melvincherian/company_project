// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:company_project/views/cutomers/create_new_invoice.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:company_project/providers/invoice_provider.dart';

// class GetInvoice extends StatefulWidget {
//   const GetInvoice({super.key});

//   @override
//   State<GetInvoice> createState() => _GetInvoiceState();
// }

// class _GetInvoiceState extends State<GetInvoice> {
//   final GlobalKey _invoiceKey = GlobalKey();
//   String invoiceDate = '';
//   String dueDate = '';
//   String invoiceNumber = '#1234565'; // This could be generated or stored
//   String customerName = '';
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadInvoiceData();
//   }

//   Future<void> _loadInvoiceData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedInvoiceDate = prefs.getString('invoice_date') ?? '';
//     final savedDueDate = prefs.getString('due_date') ?? '';
//     final savedName = prefs.getString('invoice_name') ?? '';

//     setState(() {
//       invoiceDate = savedInvoiceDate.isNotEmpty ? _formatDateFromIso(savedInvoiceDate) : 'N/A';
//       dueDate = savedDueDate.isNotEmpty ? _formatDateFromIso(savedDueDate) : 'N/A';
//       customerName = savedName.isNotEmpty ? savedName : 'N/A';
//     });
//   }

//   String _formatDateFromIso(String isoDate) {
//     try {
//       final date = DateTime.parse(isoDate);
//       return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
//     } catch (e) {
//       return isoDate;
//     }
//   }

//   String _formatCurrency(double amount) {
//     return '₹${amount.toStringAsFixed(2)}';
//   }

//   Future<void> _sharePoster() async {
//     setState(() {
//       isLoading = true;
//     });
    
//     try {
//       // Ensure the key is attached to a rendered widget
//       if (_invoiceKey.currentContext == null) {
//         throw Exception('Invoice container not found in widget tree');
//       }
      
//       // Capture the poster as image
//       RenderRepaintBoundary boundary = _invoiceKey.currentContext!
//           .findRenderObject() as RenderRepaintBoundary;
          
//       // Add a small delay to ensure rendering is complete
//       await Future.delayed(const Duration(milliseconds: 300));
      
//       ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData? byteData =
//           await image.toByteData(format: ui.ImageByteFormat.png);

//       if (byteData != null) {
//         final buffer = byteData.buffer.asUint8List();

//         // Get temporary directory
//         final tempDir = await getTemporaryDirectory();
//         final fileName = 'invoice_${DateTime.now().millisecondsSinceEpoch}.png';
//         final file = File('${tempDir.path}/$fileName');

//         // Save file
//         await file.writeAsBytes(buffer);

//         // Share file
//         await Share.shareXFiles([XFile(file.path)],
//             text: 'Invoice $invoiceNumber');
//       } else {
//         throw Exception('Failed to get image data');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to share invoice: $e')),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   // Generate PDF document
//   Future<File> _generatePDF() async {
//     final invoiceProvider = Provider.of<InvoiceProvider>(context, listen: false);
//     final pdf = pw.Document();

//     // Add content to the PDF
//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text('Invoice', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20)),
//               pw.SizedBox(height: 4),
//               pw.Text('Date: $invoiceDate', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//               pw.Text('Due Date: $dueDate', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//               pw.Text('Invoice: $invoiceNumber', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//               pw.Text('Customer: $customerName', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 16),
//               pw.Table(
//                 border: pw.TableBorder.symmetric(
//                   inside: pw.BorderSide(color: PdfColors.grey300),
//                 ),
//                 columnWidths: {
//                   0: const pw.FlexColumnWidth(2),
//                   1: const pw.FlexColumnWidth(1),
//                   2: const pw.FlexColumnWidth(1),
//                   3: const pw.FlexColumnWidth(1.2),
//                 },
//                 children: [
//                   pw.TableRow(
//                     decoration: const pw.BoxDecoration(color: PdfColors.white),
//                     children: [
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text('DESCRIPTION', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                       ),
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text('QTY', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                       ),
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text('PRICE', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                       ),
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text('SUBTOTAL', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                       ),
//                     ],
//                   ),
//                   ...invoiceProvider.items.map((item) => pw.TableRow(
//                     children: [
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text(item.name),
//                       ),
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text(item.quantity.toString()),
//                       ),
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text('₹${item.price.toStringAsFixed(2)}'),
//                       ),
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(8.0),
//                         child: pw.Text('₹${(item.price * item.quantity).toStringAsFixed(2)}'),
//                       ),
//                     ],
//                   )),
//                 ],
//               ),
//               pw.SizedBox(height: 16),
//               pw.Divider(),
//               pw.SizedBox(height: 4),
//               _buildPdfSummaryRow('Total Items', invoiceProvider.itemCount.toString()),
//               _buildPdfSummaryRow('Sub Total', '₹${invoiceProvider.subTotal.toStringAsFixed(2)}'),
//               _buildPdfSummaryRow('Discount', '₹${invoiceProvider.discount.toStringAsFixed(2)}'),
//               _buildPdfSummaryRow('Tax', '₹${invoiceProvider.taxAmount.toStringAsFixed(2)}'),
//               pw.Divider(height: 24),
//               _buildPdfSummaryRow('Total', '₹${invoiceProvider.total.toStringAsFixed(2)}', isBold: true),
//             ],
//           );
//         },
//       ),
//     );

//     // Save the PDF
//     final output = await getTemporaryDirectory();
//     final file = File('${output.path}/invoice_$invoiceNumber.pdf');
//     await file.writeAsBytes(await pdf.save());
//     return file;
//   }

//   pw.Widget _buildPdfSummaryRow(String title, String value, {bool isBold = false}) {
//     return pw.Padding(
//       padding: const pw.EdgeInsets.symmetric(vertical: 2.0),
//       child: pw.Row(
//         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//         children: [
//           pw.Text(title, style: pw.TextStyle(fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal)),
//           pw.Text(
//             value,
//             style: pw.TextStyle(
//               fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
//               color: isBold ? PdfColors.blue : PdfColors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Download PDF to device
//   Future<void> _downloadPDF() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       // Request storage permission
//       var status = await Permission.storage.request();
//       if (status.isGranted) {
//         final pdfFile = await _generatePDF();
        
//         // Get the downloads directory
//         Directory? downloadsDir;
//         if (Platform.isAndroid) {
//           downloadsDir = Directory('/storage/emulated/0/Download');
//           // Ensure the directory exists
//           if (!await downloadsDir.exists()) {
//             downloadsDir = await getExternalStorageDirectory();
//           }
//         } else if (Platform.isIOS) {
//           downloadsDir = await getApplicationDocumentsDirectory();
//         }
        
//         if (downloadsDir != null) {
//           final savedFile = File('${downloadsDir.path}/invoice_$invoiceNumber.pdf');
//           await pdfFile.copy(savedFile.path);
          
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Invoice downloaded to ${savedFile.path}')),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Storage permission denied')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error downloading PDF: $e')),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   // Share PDF
//   Future<void> _sharePDF() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final pdfFile = await _generatePDF();
//       await Share.shareXFiles(
//         [XFile(pdfFile.path)],
//         text: 'Invoice $invoiceNumber',
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error sharing PDF: $e')),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final invoiceProvider = Provider.of<InvoiceProvider>(context);
    
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Invoice', style: TextStyle(fontWeight: FontWeight.bold)),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit, color: Colors.blue),
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateNewInvoice()));
//             },
//           ),
//         ],
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 // This RepaintBoundary with the _invoiceKey is what you want to capture
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: RepaintBoundary(
//                       key: _invoiceKey,
//                       child: Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey.shade300),
//                           borderRadius: BorderRadius.circular(12),
//                           color: Colors.white,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const Text('Invoice', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                             const SizedBox(height: 4),
//                             Text('Date: $invoiceDate', style: const TextStyle(fontWeight: FontWeight.bold)),
//                             Text('Due Date: $dueDate', style: const TextStyle(fontWeight: FontWeight.bold)),
//                             Text('Invoice: $invoiceNumber', style: const TextStyle(fontWeight: FontWeight.bold)),
//                             Text('Customer: $customerName', style: const TextStyle(fontWeight: FontWeight.bold)),
//                             const SizedBox(height: 16),
//                             Table(
//                               border: TableBorder.symmetric(
//                                 inside: BorderSide(color: Colors.grey.shade300),
//                               ),
//                               columnWidths: const {
//                                 0: FlexColumnWidth(2),
//                                 1: FlexColumnWidth(1),
//                                 2: FlexColumnWidth(1),
//                                 3: FlexColumnWidth(1.2),
//                               },
//                               children: [
//                                 const TableRow(
//                                   decoration: BoxDecoration(color: Colors.transparent),
//                                   children: [
//                                     Padding(
//                                       padding: EdgeInsets.all(8.0),
//                                       child: Text('DESCRIPTION', style: TextStyle(fontWeight: FontWeight.bold)),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.all(8.0),
//                                       child: Text('QTY', style: TextStyle(fontWeight: FontWeight.bold)),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.all(8.0),
//                                       child: Text('PRICE', style: TextStyle(fontWeight: FontWeight.bold)),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.all(8.0),
//                                       child: Text('SUBTOTAL', style: TextStyle(fontWeight: FontWeight.bold)),
//                                     ),
//                                   ],
//                                 ),
//                                 ...invoiceProvider.items.map((item) => TableRow(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(item.name),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(item.quantity.toString()),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text('₹${item.price.toStringAsFixed(2)}'),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text('₹${(item.price * item.quantity).toStringAsFixed(2)}'),
//                                     ),
//                                   ],
//                                 )).toList(),
//                               ],
//                             ),
//                             const SizedBox(height: 16),
//                             const Divider(),
//                             const SizedBox(height: 4),
//                             _buildSummaryRow('Total Items', invoiceProvider.itemCount.toString()),
//                             _buildSummaryRow('Sub Total', _formatCurrency(invoiceProvider.subTotal)),
//                             _buildSummaryRow('Discount', _formatCurrency(invoiceProvider.discount)),
//                             _buildSummaryRow('Tax', _formatCurrency(invoiceProvider.taxAmount)),
//                             const Divider(height: 24),
//                             _buildSummaryRow('Total', _formatCurrency(invoiceProvider.total), isBold: true, isBlue: true),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton.icon(
//                       onPressed: isLoading ? null : _downloadPDF,
//                       icon: isLoading 
//                           ? const SizedBox(
//                               width: 16, 
//                               height: 16, 
//                               child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
//                             )
//                           : const Icon(Icons.download, color: Colors.white),
//                       label: const Text('Download', style: TextStyle(color: Colors.white)),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF1DA1F2),
//                         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                       ),
//                     ),
//                     OutlinedButton.icon(
//                       onPressed: isLoading ? null : _sharePDF,
//                       icon: const Icon(Icons.share, color: Color(0xFF1DA1F2)),
//                       label: const Text('Share', style: TextStyle(color: Color(0xFF1DA1F2))),
//                       style: OutlinedButton.styleFrom(
//                         side: const BorderSide(color: Color(0xFF1DA1F2)),
//                         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//           if (isLoading)
//             Container(
//               color: Colors.black.withOpacity(0.1),
//               child: Center(
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       CircularProgressIndicator(),
//                       SizedBox(height: 16),
//                       Text('Processing...'),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSummaryRow(String title, String value, {bool isBold = false, bool isBlue = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
//           Text(
//             value,
//             style: TextStyle(
//               fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//               color: isBlue ? Colors.blue : Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }