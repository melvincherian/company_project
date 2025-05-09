// // ignore_for_file: use_build_context_synchronously

// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class BusinessCardMaker extends StatefulWidget {
//   const BusinessCardMaker({super.key});

//   @override
//   State<BusinessCardMaker> createState() => _BusinessCardMakerState();
// }

// class _BusinessCardMakerState extends State<BusinessCardMaker> {
//   final _businessNameController = TextEditingController();
//   final _ownerNameController = TextEditingController();
//   final _contactController = TextEditingController();
//   final _whatsappController = TextEditingController();
//   final _addressController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _websiteController = TextEditingController();

//   File? _imageFile;
//   Uint8List? _imageBytes;
//   final GlobalKey _previewContainer = GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//     _loadBusinessData();
//   }

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       final image = File(pickedFile.path);
//       final bytes = await image.readAsBytes();

//       setState(() {
//         _imageFile = image;
//         _imageBytes = bytes;
//       });
//     }
//   }

//   Future<void> _saveBusinessData() async {
//     final prefs = await SharedPreferences.getInstance();

//     await prefs.setString('businessName', _businessNameController.text);
//     await prefs.setString('ownerName', _ownerNameController.text);
//     await prefs.setString('contact', _contactController.text);
//     await prefs.setString('whatsapp', _whatsappController.text);
//     await prefs.setString('address', _addressController.text);
//     await prefs.setString('email', _emailController.text);
//     await prefs.setString('website', _websiteController.text);

//     debugPrint('Business data saved to SharedPreferences');
//   }

//   Future<void> _loadBusinessData() async {
//     final prefs = await SharedPreferences.getInstance();

//     setState(() {
//       _businessNameController.text = prefs.getString('businessName') ?? '';
//       _ownerNameController.text = prefs.getString('ownerName') ?? '';
//       _contactController.text = prefs.getString('contact') ?? '';
//       _whatsappController.text = prefs.getString('whatsapp') ?? '';
//       _addressController.text = prefs.getString('address') ?? '';
//       _emailController.text = prefs.getString('email') ?? '';
//       _websiteController.text = prefs.getString('website') ?? '';
//     });
//   }

//   Future<void> _saveToGallery() async {
//     try {
//       final boundary =
//           _previewContainer.currentContext?.findRenderObject() as RenderRepaintBoundary?;

//       if (boundary != null) {
//         final image = await boundary.toImage(pixelRatio: 3.0);
//         final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//         final pngBytes = byteData!.buffer.asUint8List();

//         final permission = await PhotoManager.requestPermissionExtend();
//         if (permission.isAuth) {
//           await PhotoManager.editor.saveImage(
//             filename: '',
//             pngBytes,
//             title: 'business_card_${DateTime.now().millisecondsSinceEpoch}.png',
//           );

//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Saved to gallery!')),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Permission denied')),
//           );
//         }
//       }
//     } catch (e) {
//       debugPrint('Error saving to gallery: $e');
//     }
//   }

//   Widget buildTextField(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//       ),
//     );
//   }

//  Widget buildImagePicker() {
//   return Center(  // Centers the whole widget
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,  // Centers children inside the Column
//       crossAxisAlignment: CrossAxisAlignment.center, // Ensures the column is centered
//       children: [
//         if (_imageFile != null)
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.file(
//               _imageFile!,
//               height: 150,
//             ),
//           ),
//         const SizedBox(height: 16),
//         Text(
//           'Tap the logo below to upload your business logo',
//           style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//         ),
//         const SizedBox(height: 16),
//         GestureDetector(
//           onTap: _pickImage,
//           child: CircleAvatar(
//             radius: 35,
//             backgroundColor: Colors.blueAccent.withOpacity(0.1),
//             child: _imageFile != null
//                 ? ClipOval(
//                     child: Image.file(
//                       _imageFile!,
//                       fit: BoxFit.cover,
//                       width: 70,
//                       height: 70,
//                     ),
//                   )
//                 : const Icon(
//                     Icons.add_a_photo,
//                     color: Colors.blueAccent,
//                     size: 28,
//                   ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(onPressed: (){
//           Navigator.of(context).pop();
//         }, icon:const Icon(Icons.arrow_back_ios)),
//         title:const  Text('Add Business Details',style: TextStyle(fontWeight: ui.FontWeight.bold),)),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: RepaintBoundary(
//           key: _previewContainer,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               buildTextField('Business Name/Person Name', _businessNameController),
//               buildTextField('Tagline / Owner Name', _ownerNameController),
//               buildTextField('Contact Number', _contactController),
//               buildTextField('Whatsapp Number', _whatsappController),
//               buildTextField('Address', _addressController),
//               buildTextField('Email', _emailController),
//               buildTextField('Website', _websiteController),
//               const SizedBox(height: 20),
//               buildImagePicker(),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 74, 71, 248),
//                   ),
//                   onPressed: () async {
//                     await _saveBusinessData();
//                     await _saveToGallery();
//                   },
//                   child: const Text('Save', style: TextStyle(color: Colors.white)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: use_build_context_synchronously

// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class BusinessCardMaker extends StatefulWidget {
//   final bool shouldSaveOnCreate;

//   const BusinessCardMaker({
//     super.key,
//     this.shouldSaveOnCreate = false
//   });

//   @override
//   State<BusinessCardMaker> createState() => _BusinessCardMakerState();
// }

// class _BusinessCardMakerState extends State<BusinessCardMaker> {
//   final _businessNameController = TextEditingController();
//   final _ownerNameController = TextEditingController();
//   final _contactController = TextEditingController();
//   final _whatsappController = TextEditingController();
//   final _addressController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _websiteController = TextEditingController();

//   File? _imageFile;
//   Uint8List? _imageBytes;
//   final GlobalKey _previewContainer = GlobalKey();
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadBusinessData();

//     // If we're coming from "Buy Now", we'll automatically save the card
//     // after loading the data
//     if (widget.shouldSaveOnCreate) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         // Delay to ensure the UI is built and data is loaded
//         Future.delayed(const Duration(milliseconds: 500), () {
//           _saveBusinessCardToGallery();
//         });
//       });
//     }
//   }

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       final image = File(pickedFile.path);
//       final bytes = await image.readAsBytes();

//       setState(() {
//         _imageFile = image;
//         _imageBytes = bytes;
//       });
//     }
//   }

//   Future<void> _saveBusinessData() async {
//     final prefs = await SharedPreferences.getInstance();

//     await prefs.setString('businessName', _businessNameController.text);
//     await prefs.setString('ownerName', _ownerNameController.text);
//     await prefs.setString('contact', _contactController.text);
//     await prefs.setString('whatsapp', _whatsappController.text);
//     await prefs.setString('address', _addressController.text);
//     await prefs.setString('email', _emailController.text);
//     await prefs.setString('website', _websiteController.text);

//     debugPrint('Business data saved to SharedPreferences');
//   }

//   Future<void> _loadBusinessData() async {
//     final prefs = await SharedPreferences.getInstance();

//     setState(() {
//       _businessNameController.text = prefs.getString('businessName') ?? '';
//       _ownerNameController.text = prefs.getString('ownerName') ?? '';
//       _contactController.text = prefs.getString('contact') ?? '';
//       _whatsappController.text = prefs.getString('whatsapp') ?? '';
//       _addressController.text = prefs.getString('address') ?? '';
//       _emailController.text = prefs.getString('email') ?? '';
//       _websiteController.text = prefs.getString('website') ?? '';
//     });
//   }

//   Future<void> _saveToGallery() async {
//     try {
//       await _saveBusinessData();
//       await _saveBusinessCardToGallery();
//     } catch (e) {
//       debugPrint('Error in save process: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error saving: $e')),
//       );
//     }
//   }

//   Future<void> _saveBusinessCardToGallery() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       // Wait a bit to ensure the UI is fully rendered
//       await Future.delayed(const Duration(milliseconds: 100));

//       final boundary =
//           _previewContainer.currentContext?.findRenderObject() as RenderRepaintBoundary?;

//       if (boundary != null) {
//         final image = await boundary.toImage(pixelRatio: 3.0);
//         final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//         final pngBytes = byteData!.buffer.asUint8List();

//         final permission = await PhotoManager.requestPermissionExtend();
//         if (permission.isAuth) {
//           final fileName = 'business_card_${DateTime.now().millisecondsSinceEpoch}.png';

//           await PhotoManager.editor.saveImage(
//             filename: 'gallery',
//             pngBytes,
//             title: fileName,
//             desc: 'Business Card for ${_businessNameController.text}',
//           );

//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Business card saved to gallery!')),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Permission denied to save to gallery')),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Could not render business card')),
//         );
//       }
//     } catch (e) {
//       debugPrint('Error saving to gallery: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error saving business card: $e')),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   Widget buildTextField(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//       ),
//     );
//   }

//   Widget buildImagePicker() {
//     return Center(  // Centers the whole widget
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,  // Centers children inside the Column
//         crossAxisAlignment: CrossAxisAlignment.center, // Ensures the column is centered
//         children: [
//           if (_imageFile != null)
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.file(
//                 _imageFile!,
//                 height: 150,
//               ),
//             ),
//           const SizedBox(height: 16),
//           Text(
//             'Tap the logo below to upload your business logo',
//             style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//           ),
//           const SizedBox(height: 16),
//           GestureDetector(
//             onTap: _pickImage,
//             child: CircleAvatar(
//               radius: 35,
//               backgroundColor: Colors.blueAccent.withOpacity(0.1),
//               child: _imageFile != null
//                   ? ClipOval(
//                       child: Image.file(
//                         _imageFile!,
//                         fit: BoxFit.cover,
//                         width: 70,
//                         height: 70,
//                       ),
//                     )
//                   : const Icon(
//                       Icons.add_a_photo,
//                       color: Colors.blueAccent,
//                       size: 28,
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBusinessCardPreview() {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 20),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Text(
//             'Business Card Preview',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.deepPurple,
//             ),
//           ),
//           const SizedBox(height: 12),
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey.shade300),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Text(
//                     _businessNameController.text.isNotEmpty ? _businessNameController.text : 'Business Name',
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const Divider(),
//                 if (_ownerNameController.text.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 4),
//                     child: Text('Owner: ${_ownerNameController.text}'),
//                   ),
//                 if (_contactController.text.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 4),
//                     child: Text('Contact: ${_contactController.text}'),
//                   ),
//                 if (_whatsappController.text.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 4),
//                     child: Text('WhatsApp: ${_whatsappController.text}'),
//                   ),
//                 if (_addressController.text.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 4),
//                     child: Text('Address: ${_addressController.text}'),
//                   ),
//                 if (_emailController.text.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 4),
//                     child: Text('Email: ${_emailController.text}'),
//                   ),
//                 if (_websiteController.text.isNotEmpty)
//                   Text('Website: ${_websiteController.text}'),
//                 if (_imageFile != null)
//                   Center(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(4),
//                         child: Image.file(
//                           _imageFile!,
//                           height: 50,
//                           width: 50,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           icon: const Icon(Icons.arrow_back_ios)
//         ),
//         title: const Text(
//           'Add Business Details',
//           style: TextStyle(fontWeight: ui.FontWeight.bold),
//         ),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // This is the hidden container used for generating the image
//                 Offstage(
//                   offstage: true,
//                   child: RepaintBoundary(
//                     key: _previewContainer,
//                     child: Container(
//                       width: 500, // Fixed width for business card
//                       padding: const EdgeInsets.all(16),
//                       color: Colors.white,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Center(
//                             child: Text(
//                               _businessNameController.text.isNotEmpty ? _businessNameController.text : 'Business Name',
//                               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                           const Divider(color: Colors.black),
//                           if (_ownerNameController.text.isNotEmpty)
//                             Text('Owner: ${_ownerNameController.text}', style: const TextStyle(fontSize: 16)),
//                           if (_contactController.text.isNotEmpty)
//                             Text('Contact: ${_contactController.text}', style: const TextStyle(fontSize: 16)),
//                           if (_whatsappController.text.isNotEmpty)
//                             Text('WhatsApp: ${_whatsappController.text}', style: const TextStyle(fontSize: 16)),
//                           if (_addressController.text.isNotEmpty)
//                             Text('Address: ${_addressController.text}', style: const TextStyle(fontSize: 16)),
//                           if (_emailController.text.isNotEmpty)
//                             Text('Email: ${_emailController.text}', style: const TextStyle(fontSize: 16)),
//                           if (_websiteController.text.isNotEmpty)
//                             Text('Website: ${_websiteController.text}', style: const TextStyle(fontSize: 16)),
//                           if (_imageFile != null)
//                             Center(
//                               child: Padding(
//                                 padding: const EdgeInsets.only(top: 8),
//                                 child: Image.file(
//                                   _imageFile!,
//                                   height: 80,
//                                   width: 80,
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Form fields
//                 buildTextField('Business Name/Person Name', _businessNameController),
//                 buildTextField('Tagline / Owner Name', _ownerNameController),
//                 buildTextField('Contact Number', _contactController),
//                 buildTextField('Whatsapp Number', _whatsappController),
//                 buildTextField('Address', _addressController),
//                 buildTextField('Email', _emailController),
//                 buildTextField('Website', _websiteController),
//                 const SizedBox(height: 20),
//                 buildImagePicker(),
//                 const SizedBox(height: 20),

//                 // Preview of business card
//                 _buildBusinessCardPreview(),

//                 const SizedBox(height: 20),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 74, 71, 248),
//                     ),
//                     onPressed: _isLoading ? null : _saveToGallery,
//                     child: _isLoading
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Text('Save', style: TextStyle(color: Colors.white)),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),

//           // Loading overlay
//           if (_isLoading)
//             Container(
//               color: Colors.black.withOpacity(0.3),
//               child: const Center(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     CircularProgressIndicator(),
//                     SizedBox(height: 16),
//                     Text(
//                       'Saving business card...',
//                       style: TextStyle(color: Colors.white, fontSize: 16),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessCardMaker extends StatefulWidget {
  final bool shouldSaveOnCreate;

  const BusinessCardMaker({super.key, this.shouldSaveOnCreate = false});

  @override
  State<BusinessCardMaker> createState() => _BusinessCardMakerState();
}

class _BusinessCardMakerState extends State<BusinessCardMaker> {
  final _businessNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _contactController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();

  File? _imageFile;
  Uint8List? _imageBytes;
  final GlobalKey _previewContainer = GlobalKey();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadBusinessData();

    // If we're coming from "Buy Now", we'll automatically save the card
    // after loading the data
    if (widget.shouldSaveOnCreate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Delay to ensure the UI is built and data is loaded
        Future.delayed(const Duration(seconds: 1), () {
          _saveBusinessCardToGallery();
        });
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final image = File(pickedFile.path);
      final bytes = await image.readAsBytes();

      setState(() {
        _imageFile = image;
        _imageBytes = bytes;
      });
    }
  }

  Future<void> _saveBusinessData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('businessName', _businessNameController.text);
    await prefs.setString('ownerName', _ownerNameController.text);
    await prefs.setString('contact', _contactController.text);
    await prefs.setString('whatsapp', _whatsappController.text);
    await prefs.setString('address', _addressController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('website', _websiteController.text);

    debugPrint('Business data saved to SharedPreferences');
  }

  Future<void> _loadBusinessData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _businessNameController.text = prefs.getString('businessName') ?? '';
      _ownerNameController.text = prefs.getString('ownerName') ?? '';
      _contactController.text = prefs.getString('contact') ?? '';
      _whatsappController.text = prefs.getString('whatsapp') ?? '';
      _addressController.text = prefs.getString('address') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _websiteController.text = prefs.getString('website') ?? '';
    });
  }

  Future<void> _saveToGallery() async {
    try {
      await _saveBusinessData();
      await _saveBusinessCardToGallery();
    } catch (e) {
      debugPrint('Error in save process: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving: $e')),
      );
    }
  }

  Future<void> _saveBusinessCardToGallery() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // First ensure we rebuild the preview container to be visible
      setState(() {
        // Set any state to force rebuild
      });

      // Allow sufficient time for the widget to fully render
      await Future.delayed(const Duration(seconds: 1));

      final boundary = _previewContainer.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;

      if (boundary == null) {
        throw Exception('Could not find the RepaintBoundary widget');
      }

      // Ensure the widget is fully painted before capturing
      await Future.delayed(const Duration(milliseconds: 500));

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        throw Exception('Failed to convert image to PNG format');
      }

      final pngBytes = byteData.buffer.asUint8List();

      final permission = await PhotoManager.requestPermissionExtend();
      if (permission.isAuth) {
        final fileName =
            'business_card_${DateTime.now().millisecondsSinceEpoch}.png';

        await PhotoManager.editor.saveImage(
          filename: 'gallery',
          pngBytes,
          title: fileName,
          desc: 'Business Card for ${_businessNameController.text}',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Business card saved to gallery!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permission denied to save to gallery')),
        );
      }
    } catch (e) {
      debugPrint('Error saving to gallery: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving business card: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildImagePicker() {
    return Center(
      // Centers the whole widget
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Centers children inside the Column
        crossAxisAlignment:
            CrossAxisAlignment.center, // Ensures the column is centered
        children: [
          if (_imageFile != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                _imageFile!,
                height: 150,
              ),
            ),
          const SizedBox(height: 16),
          Text(
            'Tap the logo below to upload your business logo',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.blueAccent.withOpacity(0.1),
              child: _imageFile != null
                  ? ClipOval(
                      child: Image.file(
                        _imageFile!,
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                      ),
                    )
                  : const Icon(
                      Icons.add_a_photo,
                      color: Colors.blueAccent,
                      size: 28,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessCardPreview() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Business Card Preview',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    _businessNameController.text.isNotEmpty
                        ? _businessNameController.text
                        : 'Business Name',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(),
                if (_ownerNameController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('Owner: ${_ownerNameController.text}'),
                  ),
                if (_contactController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('Contact: ${_contactController.text}'),
                  ),
                if (_whatsappController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('WhatsApp: ${_whatsappController.text}'),
                  ),
                if (_addressController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('Address: ${_addressController.text}'),
                  ),
                if (_emailController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('Email: ${_emailController.text}'),
                  ),
                if (_websiteController.text.isNotEmpty)
                  Text('Website: ${_websiteController.text}'),
                if (_imageFile != null)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.file(
                          _imageFile!,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text(
          'Add Business Details',
          style: TextStyle(fontWeight: ui.FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Form fields
                buildTextField(
                    'Business Name/Person Name', _businessNameController),
                buildTextField('Tagline / Owner Name', _ownerNameController),
                buildTextField('Contact Number', _contactController),
                buildTextField('Whatsapp Number', _whatsappController),
                buildTextField('Address', _addressController),
                buildTextField('Email', _emailController),
                buildTextField('Website', _websiteController),
                const SizedBox(height: 20),
                buildImagePicker(),
                const SizedBox(height: 20),

                // Preview of business card
                _buildBusinessCardPreview(),

                // This is the container used for generating the image
                // Now visible but positioned at the end for better rendering
                RepaintBoundary(
                  key: _previewContainer,
                  child: Container(
                    width: 500, // Fixed width for business card
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            _businessNameController.text.isNotEmpty
                                ? _businessNameController.text
                                : 'Business Name',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Divider(color: Colors.black),
                        if (_ownerNameController.text.isNotEmpty)
                          Text('Owner: ${_ownerNameController.text}',
                              style: const TextStyle(fontSize: 16)),
                        if (_contactController.text.isNotEmpty)
                          Text('Contact: ${_contactController.text}',
                              style: const TextStyle(fontSize: 16)),
                        if (_whatsappController.text.isNotEmpty)
                          Text('WhatsApp: ${_whatsappController.text}',
                              style: const TextStyle(fontSize: 16)),
                        if (_addressController.text.isNotEmpty)
                          Text('Address: ${_addressController.text}',
                              style: const TextStyle(fontSize: 16)),
                        if (_emailController.text.isNotEmpty)
                          Text('Email: ${_emailController.text}',
                              style: const TextStyle(fontSize: 16)),
                        if (_websiteController.text.isNotEmpty)
                          Text('Website: ${_websiteController.text}',
                              style: const TextStyle(fontSize: 16)),
                        if (_imageFile != null)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Image.file(
                                _imageFile!,
                                height: 80,
                                width: 80,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 74, 71, 248),
                    ),
                    onPressed: _isLoading ? null : _saveToGallery,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Save',
                            style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Loading overlay
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      'Saving business card...',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
