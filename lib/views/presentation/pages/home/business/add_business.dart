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

// 






// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class BusinessCardMaker extends StatefulWidget {
//   final bool shouldSaveOnCreate;
//   final String? posterImageUrl;

//   const BusinessCardMaker({super.key, this.shouldSaveOnCreate = false, this.posterImageUrl});

//   @override
//   State<BusinessCardMaker> createState() => _BusinessCardMakerState();
// }

// class _BusinessCardMakerState extends State<BusinessCardMaker> with SingleTickerProviderStateMixin {
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
//   bool _autoSaveInProgress = false;
//   double _downloadProgress = 0.0;
//   String _statusMessage = '';

//   bool _isLoadingImage = false;
//   bool _networkImageLoaded = false;
  
//   // Animation controller for download progress
//   late AnimationController _animationController;

//   @override
//   void initState() {
//     super.initState();
    
//     // Initialize animation controller
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );
    
//     _loadBusinessData().then((_) {
//       if (widget.posterImageUrl != null && widget.posterImageUrl!.isNotEmpty) {
//         _downloadPosterImage();
//       }
      
//       // If we're coming from "Buy Now", we'll automatically save the card
//       // after loading the data
//       if (widget.shouldSaveOnCreate && !_autoSaveInProgress) {
//         setState(() {
//           _autoSaveInProgress = true;
//           _statusMessage = 'Preparing your business card...';
//         });
        
//         // Delay to ensure the UI is built and data is loaded
//         Future.delayed(const Duration(milliseconds: 1500), () {
//           _saveBusinessCardToGallery().then((_) {
//             setState(() {
//               _autoSaveInProgress = false;
//             });
            
//             // Show a snackbar to notify the user
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Business card downloaded to your gallery!'),
//                 behavior: SnackBarBehavior.floating,
//                 duration: Duration(seconds: 3),
//               ),
//             );
//           });
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   Future<void> _downloadPosterImage() async {
//     if (widget.posterImageUrl == null || widget.posterImageUrl!.isEmpty) {
//       return;
//     }
    
//     setState(() {
//       _isLoadingImage = true;
//       _statusMessage = 'Downloading business logo...';
//     });
    
//     try {
//       // Create a client with timeout
//       final client = http.Client();
//       final request = http.Request('GET', Uri.parse(widget.posterImageUrl!));
//       final response = await client.send(request);
      
//       if (response.statusCode == 200) {
//         // Get total size for progress calculation
//         final totalBytes = response.contentLength ?? 0;
//         int downloadedBytes = 0;
//         final List<int> bytes = [];
        
//         // Get the temporary directory
//         final Directory tempDir = await getTemporaryDirectory();
//         final String tempPath = tempDir.path;
//         final File file = File('$tempPath/poster_${DateTime.now().millisecondsSinceEpoch}.png');
        
//         // Start download with progress updates
//         response.stream.listen(
//           (List<int> chunk) {
//             // Update download progress
//             downloadedBytes += chunk.length;
//             if (totalBytes > 0) {
//               setState(() {
//                 _downloadProgress = downloadedBytes / totalBytes;
//                 _animationController.value = _downloadProgress;
//               });
//             }
//             bytes.addAll(chunk);
//           },
//           onDone: () async {
//             // Write the image to the file
//             await file.writeAsBytes(bytes);
            
//             // Update state with the downloaded image
//             setState(() {
//               _imageFile = file;
//               _imageBytes = Uint8List.fromList(bytes);
//               _networkImageLoaded = true;
//               _isLoadingImage = false;
//               _downloadProgress = 1.0;
//               _statusMessage = '';
//             });
            
//             client.close();
//           },
//           onError: (error) {
//             throw Exception('Error during download: $error');
//           },
//         );
//       } else {
//         throw Exception('Failed to download image: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Error downloading poster image: $e');
//       setState(() {
//         _isLoadingImage = false;
//         _statusMessage = '';
//       });
      
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to download business image'),
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//       }
//     }
//   }
  
//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _statusMessage = 'Processing image...';
//         _isLoadingImage = true;
//       });
      
//       try {
//         final image = File(pickedFile.path);
//         final bytes = await image.readAsBytes();

//         setState(() {
//           _imageFile = image;
//           _imageBytes = bytes;
//           _isLoadingImage = false;
//           _statusMessage = '';
//         });
//       } catch (e) {
//         setState(() {
//           _isLoadingImage = false;
//           _statusMessage = '';
//         });
        
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to process image: $e'),
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//       }
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
//       setState(() {
//         _statusMessage = 'Saving business data...';
//         _isLoading = true;
//         _downloadProgress = 0.2;
//         _animationController.value = 0.2;
//       });
      
//       await _saveBusinessData();
      
//       setState(() {
//         _statusMessage = 'Creating business card...';
//         _downloadProgress = 0.5;
//         _animationController.value = 0.5;
//       });
      
//       await _saveBusinessCardToGallery();
//     } catch (e) {
//       debugPrint('Error in save process: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error saving: $e'),
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
      
//       setState(() {
//         _isLoading = false;
//         _statusMessage = '';
//       });
//     }
//   }

//   Future<void> _saveBusinessCardToGallery() async {
//     try {
//       // First ensure we rebuild the preview container to be visible
//       setState(() {
//         _statusMessage = 'Preparing your business card...';
//         _downloadProgress = 0.7;
//         _animationController.value = 0.7;
//       });

//       // Allow sufficient time for the widget to fully render
//       await Future.delayed(const Duration(milliseconds: 800));

//       final boundary = _previewContainer.currentContext?.findRenderObject()
//           as RenderRepaintBoundary?;
        
//       if (boundary == null) {
//         throw Exception('Could not find the RepaintBoundary widget');
//       }

//       // Ensure the widget is fully painted before capturing
//       await Future.delayed(const Duration(milliseconds: 300));
      
//       setState(() {
//         _statusMessage = 'Rendering business card...';
//         _downloadProgress = 0.8;
//         _animationController.value = 0.8;
//       });

//       final image = await boundary.toImage(pixelRatio: 3.0);
//       final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

//       if (byteData == null) {
//         throw Exception('Failed to convert image to PNG format');
//       }

//       final pngBytes = byteData.buffer.asUint8List();
      
//       setState(() {
//         _statusMessage = 'Saving to gallery...';
//         _downloadProgress = 0.9;
//         _animationController.value = 0.9;
//       });

//       final permission = await PhotoManager.requestPermissionExtend();
//       if (permission.isAuth) {
//         final fileName = 'business_card_${DateTime.now().millisecondsSinceEpoch}.png';

//         await PhotoManager.editor.saveImage(
//           filename: 'gallery',
//           pngBytes,
//           title: fileName,
//           desc: 'Business Card for ${_businessNameController.text}',
//         );
        
//         setState(() {
//           _statusMessage = 'Complete!';
//           _downloadProgress = 1.0;
//           _animationController.value = 1.0;
//         });
        
//         await Future.delayed(const Duration(milliseconds: 500));

//         if (!widget.shouldSaveOnCreate) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Business card saved to gallery!'),
//               behavior: SnackBarBehavior.floating,
//             ),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Permission denied to save to gallery'),
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//       }
//     } catch (e) {
//       debugPrint('Error saving to gallery: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error saving business card: $e'),
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//         _statusMessage = '';
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
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           if (_isLoadingImage)
//             Container(
//               width: 150,
//               height: 150,
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 40,
//                     height: 40,
//                     child: CircularProgressIndicator(
//                       value: _downloadProgress > 0 ? _downloadProgress : null,
//                       strokeWidth: 3,
//                       valueColor: AlwaysStoppedAnimation<Color>(
//                         Colors.blueAccent,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     _statusMessage,
//                     style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//                     textAlign: TextAlign.center,
//                   ),
//                   if (_downloadProgress > 0)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: Text(
//                         '${(_downloadProgress * 100).toInt()}%',
//                         style: const TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blueAccent,
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             )
//           else if (_imageFile != null)
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 8,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.file(
//                   _imageFile!,
//                   height: 150,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           const SizedBox(height: 16),
//           Text(
//             _networkImageLoaded 
//                 ? 'Business logo uploaded successfully'
//                 : 'Tap below to upload your business logo',
//             style: TextStyle(
//               fontSize: 14, 
//               color: Colors.grey[700],
//               fontWeight: FontWeight.w500
//             ),
//           ),
//           const SizedBox(height: 16),
//           GestureDetector(
//             onTap: _isLoadingImage ? null : _pickImage,
//             child: Container(
//               width: 70,
//               height: 70,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: _imageFile != null 
//                     ? Colors.white 
//                     : Colors.blueAccent.withOpacity(0.1),
//                 border: Border.all(
//                   color: Colors.blueAccent.withOpacity(0.3),
//                   width: 2,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.blueAccent.withOpacity(0.1),
//                     spreadRadius: 1,
//                     blurRadius: 5,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: _isLoadingImage
//                   ? const SizedBox(
//                       width: 20, 
//                       height: 20, 
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
//                       ),
//                     )
//                   : _imageFile != null
//                       ? ClipOval(
//                           child: Image.file(
//                             _imageFile!,
//                             fit: BoxFit.cover,
//                             width: 70,
//                             height: 70,
//                           ),
//                         )
//                       : const Icon(
//                           Icons.add_a_photo,
//                           color: Colors.blueAccent,
//                           size: 28,
//                         ),
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
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 8,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.preview, size: 18, color: Colors.deepPurple),
//               const SizedBox(width: 8),
//               const Text(
//                 'Business Card Preview',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.deepPurple,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey.shade300, width: 1.5),
//               borderRadius: BorderRadius.circular(12),
//               gradient: LinearGradient(
//                 colors: [Colors.white, Colors.grey.shade50],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Text(
//                     _businessNameController.text.isNotEmpty
//                         ? _businessNameController.text
//                         : 'Business Name',
//                     style: const TextStyle(
//                       fontSize: 18, 
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 0.5,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const Divider(height: 24),
//                 if (_ownerNameController.text.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 6),
//                     child: Text(
//                       'Owner: ${_ownerNameController.text}',
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 if (_contactController.text.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 6),
//                     child: Text(
//                       'Contact: ${_contactController.text}',
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 if (_whatsappController.text.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 6),
//                     child: Text(
//                       'WhatsApp: ${_whatsappController.text}',
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 if (_addressController.text.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 6),
//                     child: Text(
//                       'Address: ${_addressController.text}',
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 if (_emailController.text.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 6),
//                     child: Text(
//                       'Email: ${_emailController.text}',
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 if (_websiteController.text.isNotEmpty)
//                   Text(
//                     'Website: ${_websiteController.text}',
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                 if (_imageFile != null)
//                   Center(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 12),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(6),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.05),
//                               blurRadius: 4,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(6),
//                           child: Image.file(
//                             _imageFile!,
//                             height: 50,
//                             width: 50,
//                             fit: BoxFit.cover,
//                           ),
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
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: const Icon(Icons.arrow_back_ios)),
//         title: const Text(
//           'Add Business Details',
//           style: TextStyle(fontWeight: ui.FontWeight.bold),
//         ),
//         elevation: 0.5,
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Form fields
//                 buildTextField(
//                     'Business Name/Person Name', _businessNameController),
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

//                 // This is the container used for generating the image
//                 // Now visible but positioned at the end for better rendering
//                 RepaintBoundary(
//                   key: _previewContainer,
//                   child: Container(
//                     width: 500, // Fixed width for business card
//                     padding: const EdgeInsets.all(16),
//                     color: Colors.white,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Center(
//                           child: Text(
//                             _businessNameController.text.isNotEmpty
//                                 ? _businessNameController.text
//                                 : 'Business Name',
//                             style: const TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         const Divider(color: Colors.black),
//                         if (_ownerNameController.text.isNotEmpty)
//                           Text('Owner: ${_ownerNameController.text}',
//                               style: const TextStyle(fontSize: 16)),
//                         if (_contactController.text.isNotEmpty)
//                           Text('Contact: ${_contactController.text}',
//                               style: const TextStyle(fontSize: 16)),
//                         if (_whatsappController.text.isNotEmpty)
//                           Text('WhatsApp: ${_whatsappController.text}',
//                               style: const TextStyle(fontSize: 16)),
//                         if (_addressController.text.isNotEmpty)
//                           Text('Address: ${_addressController.text}',
//                               style: const TextStyle(fontSize: 16)),
//                         if (_emailController.text.isNotEmpty)
//                           Text('Email: ${_emailController.text}',
//                               style: const TextStyle(fontSize: 16)),
//                         if (_websiteController.text.isNotEmpty)
//                           Text('Website: ${_websiteController.text}',
//                               style: const TextStyle(fontSize: 16)),
//                         if (_imageFile != null)
//                           Center(
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 8),
//                               child: Image.file(
//                                 _imageFile!,
//                                 height: 80,
//                                 width: 80,
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 54,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 74, 71, 248),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 2,
//                     ),
//                     onPressed: (_isLoading || _autoSaveInProgress) ? null : _saveToGallery,
//                     child: _isLoading || _autoSaveInProgress
//                         ? const SizedBox(
//                             width: 24,
//                             height: 24,
//                             child: CircularProgressIndicator(
//                               color: Colors.white,
//                               strokeWidth: 2,
//                             ),
//                           )
//                         : const Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(Icons.save_alt, color: Colors.white),
//                               SizedBox(width: 8),
//                               Text(
//                                 'Save Business Card',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),

//           // Professional loading overlay with progress
//           if (_isLoading || _autoSaveInProgress)
//             Container(
//               color: Colors.black.withOpacity(0.5),
//               child: Center(
//                 child: Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Container(
//                     width: 280,
//                     padding: const EdgeInsets.all(24),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         SizedBox(
//                           width: 70,
//                           height: 70,
//                           child: Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               SizedBox(
//                                 width: 70,
//                                 height: 70,
//                                 child: CircularProgressIndicator(
//                                   value: _downloadProgress > 0 ? _downloadProgress : null,
//                                   strokeWidth: 5,
//                                   valueColor: const AlwaysStoppedAnimation<Color>(
//                                     Color.fromARGB(255, 74, 71, 248),
//                                   ),
//                                   backgroundColor: Colors.grey[200],
//                                 ),
//                               ),
//                               if (_downloadProgress > 0)
//                                 Text(
//                                   '${(_downloadProgress * 100).toInt()}%',
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 24),
//                         Text(
//                           _statusMessage,
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         const LinearProgressIndicator(
//                           minHeight: 3,
//                           backgroundColor: Color(0xFFE0E0E0),
//                           valueColor: AlwaysStoppedAnimation<Color>(
//                             Color.fromARGB(255, 74, 71, 248),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         const Text(
//                           'Please don\'t close the app',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }










// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class BusinessCardMaker extends StatefulWidget {
//   final bool shouldSaveOnCreate;
//   final String? posterImageUrl;

//   const BusinessCardMaker({super.key, this.shouldSaveOnCreate = false, this.posterImageUrl});

//   @override
//   State<BusinessCardMaker> createState() => _BusinessCardMakerState();
// }

// class _BusinessCardMakerState extends State<BusinessCardMaker> with SingleTickerProviderStateMixin {
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
//   bool _autoSaveInProgress = false;
//   double _downloadProgress = 0.0;
//   String _statusMessage = '';

//   bool _isLoadingImage = false;
//   bool _networkImageLoaded = false;
  
//   // Animation controller for download progress
//   late AnimationController _animationController;

//   @override
//   void initState() {
//     super.initState();
    
//     // Initialize animation controller
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );
    
//     _loadBusinessData().then((_) {
//       if (widget.posterImageUrl != null && widget.posterImageUrl!.isNotEmpty) {
//         _downloadPosterImage();
//       }
      
//       // If we're coming from "Buy Now", we'll automatically save the card
//       // after loading the data
//       if (widget.shouldSaveOnCreate && !_autoSaveInProgress) {
//         setState(() {
//           _autoSaveInProgress = true;
//           _statusMessage = 'Preparing your business card...';
//         });
        
//         // Delay to ensure the UI is built and data is loaded
//         Future.delayed(const Duration(milliseconds: 1500), () {
//           _saveBusinessCardToGallery().then((_) {
//             setState(() {
//               _autoSaveInProgress = false;
//             });
            
//             // Show a snackbar to notify the user
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Business card downloaded to your gallery!'),
//                 behavior: SnackBarBehavior.floating,
//                 duration: Duration(seconds: 3),
//               ),
//             );
//           });
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   Future<void> _downloadPosterImage() async {
//     if (widget.posterImageUrl == null || widget.posterImageUrl!.isEmpty) {
//       return;
//     }
    
//     setState(() {
//       _isLoadingImage = true;
//       _statusMessage = 'Downloading business logo...';
//     });
    
//     try {
//       // Create a client with timeout
//       final client = http.Client();
//       final request = http.Request('GET', Uri.parse(widget.posterImageUrl!));
//       final response = await client.send(request);
      
//       if (response.statusCode == 200) {
//         // Get total size for progress calculation
//         final totalBytes = response.contentLength ?? 0;
//         int downloadedBytes = 0;
//         final List<int> bytes = [];
        
//         // Get the temporary directory
//         final Directory tempDir = await getTemporaryDirectory();
//         final String tempPath = tempDir.path;
//         final File file = File('$tempPath/poster_${DateTime.now().millisecondsSinceEpoch}.png');
        
//         // Start download with progress updates
//         response.stream.listen(
//           (List<int> chunk) {
//             // Update download progress
//             downloadedBytes += chunk.length;
//             if (totalBytes > 0) {
//               setState(() {
//                 _downloadProgress = downloadedBytes / totalBytes;
//                 _animationController.value = _downloadProgress;
//               });
//             }
//             bytes.addAll(chunk);
//           },
//           onDone: () async {
//             // Write the image to the file
//             await file.writeAsBytes(bytes);
            
//             // Update state with the downloaded image
//             setState(() {
//               _imageFile = file;
//               _imageBytes = Uint8List.fromList(bytes);
//               _networkImageLoaded = true;
//               _isLoadingImage = false;
//               _downloadProgress = 1.0;
//               _statusMessage = '';
//             });
            
//             client.close();
//           },
//           onError: (error) {
//             throw Exception('Error during download: $error');
//           },
//         );
//       } else {
//         throw Exception('Failed to download image: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Error downloading poster image: $e');
//       setState(() {
//         _isLoadingImage = false;
//         _statusMessage = '';
//       });
      
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to download business image'),
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//       }
//     }
//   }
  
//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _statusMessage = 'Processing image...';
//         _isLoadingImage = true;
//       });
      
//       try {
//         final image = File(pickedFile.path);
//         final bytes = await image.readAsBytes();

//         setState(() {
//           _imageFile = image;
//           _imageBytes = bytes;
//           _isLoadingImage = false;
//           _statusMessage = '';
//         });
//       } catch (e) {
//         setState(() {
//           _isLoadingImage = false;
//           _statusMessage = '';
//         });
        
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to process image: $e'),
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//       }
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
//       setState(() {
//         _statusMessage = 'Saving business data...';
//         _isLoading = true;
//         _downloadProgress = 0.2;
//         _animationController.value = 0.2;
//       });
      
//       await _saveBusinessData();
      
//       setState(() {
//         _statusMessage = 'Creating business card...';
//         _downloadProgress = 0.5;
//         _animationController.value = 0.5;
//       });
      
//       await _saveBusinessCardToGallery();
//     } catch (e) {
//       debugPrint('Error in save process: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error saving: $e'),
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
      
//       setState(() {
//         _isLoading = false;
//         _statusMessage = '';
//       });
//     }
//   }

//   Future<void> _saveBusinessCardToGallery() async {
//     try {
//       // First ensure we rebuild the preview container to be visible
//       setState(() {
//         _statusMessage = 'Preparing your business card...';
//         _downloadProgress = 0.7;
//         _animationController.value = 0.7;
//       });

//       // Allow sufficient time for the widget to fully render
//       await Future.delayed(const Duration(milliseconds: 800));

//       final boundary = _previewContainer.currentContext?.findRenderObject()
//           as RenderRepaintBoundary?;
        
//       if (boundary == null) {
//         throw Exception('Could not find the RepaintBoundary widget');
//       }

//       // Ensure the widget is fully painted before capturing
//       await Future.delayed(const Duration(milliseconds: 300));
      
//       setState(() {
//         _statusMessage = 'Rendering business card...';
//         _downloadProgress = 0.8;
//         _animationController.value = 0.8;
//       });

//       final image = await boundary.toImage(pixelRatio: 3.0);
//       final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

//       if (byteData == null) {
//         throw Exception('Failed to convert image to PNG format');
//       }

//       final pngBytes = byteData.buffer.asUint8List();
      
//       setState(() {
//         _statusMessage = 'Saving to gallery...';
//         _downloadProgress = 0.9;
//         _animationController.value = 0.9;
//       });

//       final permission = await PhotoManager.requestPermissionExtend();
//       if (permission.isAuth) {
//         final fileName = 'business_card_${DateTime.now().millisecondsSinceEpoch}.png';

//         await PhotoManager.editor.saveImage(
//           filename: 'gallery',
//           pngBytes,
//           title: fileName,
//           desc: 'Business Card for ${_businessNameController.text}',
//         );
        
//         setState(() {
//           _statusMessage = 'Complete!';
//           _downloadProgress = 1.0;
//           _animationController.value = 1.0;
//         });
        
//         await Future.delayed(const Duration(milliseconds: 500));

//         if (!widget.shouldSaveOnCreate) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Business card saved to gallery!'),
//               behavior: SnackBarBehavior.floating,
//             ),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Permission denied to save to gallery'),
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//       }
//     } catch (e) {
//       debugPrint('Error saving to gallery: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error saving business card: $e'),
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//         _statusMessage = '';
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
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           if (_isLoadingImage)
//             Container(
//               width: 150,
//               height: 150,
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 40,
//                     height: 40,
//                     child: CircularProgressIndicator(
//                       value: _downloadProgress > 0 ? _downloadProgress : null,
//                       strokeWidth: 3,
//                       valueColor: AlwaysStoppedAnimation<Color>(
//                         Colors.blueAccent,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     _statusMessage,
//                     style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//                     textAlign: TextAlign.center,
//                   ),
//                   if (_downloadProgress > 0)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: Text(
//                         '${(_downloadProgress * 100).toInt()}%',
//                         style: const TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blueAccent,
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             )
//           else if (_imageFile != null)
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 8,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.file(
//                   _imageFile!,
//                   height: 150,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           const SizedBox(height: 16),
//           Text(
//             _networkImageLoaded 
//                 ? 'Business logo uploaded successfully'
//                 : 'Tap below to upload your business logo',
//             style: TextStyle(
//               fontSize: 14, 
//               color: Colors.grey[700],
//               fontWeight: FontWeight.w500
//             ),
//           ),
//           const SizedBox(height: 16),
//           GestureDetector(
//             onTap: _isLoadingImage ? null : _pickImage,
//             child: Container(
//               width: 70,
//               height: 70,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: _imageFile != null 
//                     ? Colors.white 
//                     : Colors.blueAccent.withOpacity(0.1),
//                 border: Border.all(
//                   color: Colors.blueAccent.withOpacity(0.3),
//                   width: 2,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.blueAccent.withOpacity(0.1),
//                     spreadRadius: 1,
//                     blurRadius: 5,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: _isLoadingImage
//                   ? const SizedBox(
//                       width: 20, 
//                       height: 20, 
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
//                       ),
//                     )
//                   : _imageFile != null
//                       ? ClipOval(
//                           child: Image.file(
//                             _imageFile!,
//                             fit: BoxFit.cover,
//                             width: 70,
//                             height: 70,
//                           ),
//                         )
//                       : const Icon(
//                           Icons.add_a_photo,
//                           color: Colors.blueAccent,
//                           size: 28,
//                         ),
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
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 8,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.preview, size: 18, color: Colors.deepPurple),
//               const SizedBox(width: 8),
//               const Text(
//                 'Business Card Preview',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.deepPurple,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey.shade300, width: 1.5),
//               borderRadius: BorderRadius.circular(12),
//               gradient: LinearGradient(
//                 colors: [Colors.white, Colors.grey.shade50],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Text(
//                     _businessNameController.text.isNotEmpty
//                         ? _businessNameController.text
//                         : 'Business Name',
//                     style: const TextStyle(
//                       fontSize: 18, 
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 0.5,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const Divider(height: 24),
//                 if (_ownerNameController.text.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 6),
//                     child: Text(
//                       'Owner: ${_ownerNameController.text}',
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 if (_contactController.text.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 6),
//                     child: Text(
//                       'Contact: ${_contactController.text}',
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 if (_whatsappController.text.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 6),
//                     child: Text(
//                       'WhatsApp: ${_whatsappController.text}',
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 if (_addressController.text.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 6),
//                     child: Text(
//                       'Address: ${_addressController.text}',
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 if (_emailController.text.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 6),
//                     child: Text(
//                       'Email: ${_emailController.text}',
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 if (_websiteController.text.isNotEmpty)
//                   Text(
//                     'Website: ${_websiteController.text}',
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                 if (_imageFile != null)
//                   Center(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 12),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(6),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.05),
//                               blurRadius: 4,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(6),
//                           child: Image.file(
//                             _imageFile!,
//                             height: 50,
//                             width: 50,
//                             fit: BoxFit.cover,
//                           ),
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
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: const Icon(Icons.arrow_back_ios)),
//         title: const Text(
//           'Add Business Details',
//           style: TextStyle(fontWeight: ui.FontWeight.bold),
//         ),
//         elevation: 0.5,
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Form fields
//                 buildTextField(
//                     'Business Name/Person Name', _businessNameController),
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

//                 // This is the container used for generating the image
//                 // Now visible but positioned at the end for better rendering
//                 RepaintBoundary(
//                   key: _previewContainer,
//                   child: Container(
//                     width: 500, // Fixed width for business card
//                     padding: const EdgeInsets.all(16),
//                     color: Colors.white,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Center(
//                           child: Text(
//                             _businessNameController.text.isNotEmpty
//                                 ? _businessNameController.text
//                                 : 'Business Name',
//                             style: const TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         const Divider(color: Colors.black),
//                         if (_ownerNameController.text.isNotEmpty)
//                           Text('Owner: ${_ownerNameController.text}',
//                               style: const TextStyle(fontSize: 16)),
//                         if (_contactController.text.isNotEmpty)
//                           Text('Contact: ${_contactController.text}',
//                               style: const TextStyle(fontSize: 16)),
//                         if (_whatsappController.text.isNotEmpty)
//                           Text('WhatsApp: ${_whatsappController.text}',
//                               style: const TextStyle(fontSize: 16)),
//                         if (_addressController.text.isNotEmpty)
//                           Text('Address: ${_addressController.text}',
//                               style: const TextStyle(fontSize: 16)),
//                         if (_emailController.text.isNotEmpty)
//                           Text('Email: ${_emailController.text}',
//                               style: const TextStyle(fontSize: 16)),
//                         if (_websiteController.text.isNotEmpty)
//                           Text('Website: ${_websiteController.text}',
//                               style: const TextStyle(fontSize: 16)),
//                         if (_imageFile != null)
//                           Center(
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 8),
//                               child: Image.file(
//                                 _imageFile!,
//                                 height: 80,
//                                 width: 80,
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 54,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 74, 71, 248),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 2,
//                     ),
//                     onPressed: (_isLoading || _autoSaveInProgress) ? null : _saveToGallery,
//                     child: _isLoading || _autoSaveInProgress
//                         ? const SizedBox(
//                             width: 24,
//                             height: 24,
//                             child: CircularProgressIndicator(
//                               color: Colors.white,
//                               strokeWidth: 2,
//                             ),
//                           )
//                         : const Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(Icons.save_alt, color: Colors.white),
//                               SizedBox(width: 8),
//                               Text(
//                                 'Save Business Card',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),

//           // Professional loading overlay with progress
//           if (_isLoading || _autoSaveInProgress)
//             Container(
//               color: Colors.black.withOpacity(0.5),
//               child: Center(
//                 child: Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Container(
//                     width: 280,
//                     padding: const EdgeInsets.all(24),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         SizedBox(
//                           width: 70,
//                           height: 70,
//                           child: Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               SizedBox(
//                                 width: 70,
//                                 height: 70,
//                                 child: CircularProgressIndicator(
//                                   value: _downloadProgress > 0 ? _downloadProgress : null,
//                                   strokeWidth: 5,
//                                   valueColor: const AlwaysStoppedAnimation<Color>(
//                                     Color.fromARGB(255, 74, 71, 248),
//                                   ),
//                                   backgroundColor: Colors.grey[200],
//                                 ),
//                               ),
//                               if (_downloadProgress > 0)
//                                 Text(
//                                   '${(_downloadProgress * 100).toInt()}%',
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 24),
//                         Text(
//                           _statusMessage,
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         const LinearProgressIndicator(
//                           minHeight: 3,
//                           backgroundColor: Color(0xFFE0E0E0),
//                           valueColor: AlwaysStoppedAnimation<Color>(
//                             Color.fromARGB(255, 74, 71, 248),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         const Text(
//                           'Please don\'t close the app',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
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
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BusinessCardMaker extends StatefulWidget {
  final bool shouldSaveOnCreate;
  final String? posterImageUrl;

  const BusinessCardMaker({super.key, this.shouldSaveOnCreate = false, this.posterImageUrl});

  @override
  State<BusinessCardMaker> createState() => _BusinessCardMakerState();
}

class _BusinessCardMakerState extends State<BusinessCardMaker> with SingleTickerProviderStateMixin {
  // Form Controllers
  final _businessNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _contactController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();
  final _designationController = TextEditingController(); // Added for designation
  final _gstController = TextEditingController(); // Added for GST number
  final _socialMediaController = TextEditingController(); // Added for social media
  final _businessTimingsController = TextEditingController(); // Added for business timings
  
  // State variables
  File? _imageFile;
  Uint8List? _imageBytes;
  final GlobalKey _previewContainer = GlobalKey();
  bool _isLoading = false;
  bool _autoSaveInProgress = false;
  double _downloadProgress = 0.0;
  String _statusMessage = '';

  bool _isLoadingImage = false;
  bool _networkImageLoaded = false;
  
  // Colors for business card sections
  final Color _headerColor = const Color(0xFF3B82F6); // Blue color for section headers
  final Color _backgroundColor = Colors.white;
  final Color _accentColor = const Color(0xFFECF0F1); // Light gray background for content

  // Animation controller for download progress
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _loadBusinessData().then((_) {
      if (widget.posterImageUrl != null && widget.posterImageUrl!.isNotEmpty) {
        _downloadPosterImage();
      }
      
      // If we're coming from "Buy Now", we'll automatically save the card
      // after loading the data
      if (widget.shouldSaveOnCreate && !_autoSaveInProgress) {
        setState(() {
          _autoSaveInProgress = true;
          _statusMessage = 'Preparing your business card...';
        });
        
        // Delay to ensure the UI is built and data is loaded
        Future.delayed(const Duration(milliseconds: 1500), () {
          _saveBusinessCardToGallery().then((_) {
            setState(() {
              _autoSaveInProgress = false;
            });
            
            // Show a snackbar to notify the user
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Business card downloaded to your gallery!'),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 3),
              ),
            );
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _businessNameController.dispose();
    _ownerNameController.dispose();
    _contactController.dispose();
    _whatsappController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _designationController.dispose();
    _gstController.dispose();
    _socialMediaController.dispose();
    _businessTimingsController.dispose();
    super.dispose();
  }

  Future<void> _downloadPosterImage() async {
    if (widget.posterImageUrl == null || widget.posterImageUrl!.isEmpty) {
      return;
    }
    
    setState(() {
      _isLoadingImage = true;
      _statusMessage = 'Downloading business logo...';
    });
    
    try {
      // Create a client with timeout
      final client = http.Client();
      final request = http.Request('GET', Uri.parse(widget.posterImageUrl!));
      final response = await client.send(request);
      
      if (response.statusCode == 200) {
        // Get total size for progress calculation
        final totalBytes = response.contentLength ?? 0;
        int downloadedBytes = 0;
        final List<int> bytes = [];
        
        // Get the temporary directory
        final Directory tempDir = await getTemporaryDirectory();
        final String tempPath = tempDir.path;
        final File file = File('$tempPath/poster_${DateTime.now().millisecondsSinceEpoch}.png');
        
        // Start download with progress updates
        response.stream.listen(
          (List<int> chunk) {
            // Update download progress
            downloadedBytes += chunk.length;
            if (totalBytes > 0) {
              setState(() {
                _downloadProgress = downloadedBytes / totalBytes;
                _animationController.value = _downloadProgress;
              });
            }
            bytes.addAll(chunk);
          },
          onDone: () async {
            // Write the image to the file
            await file.writeAsBytes(bytes);
            
            // Update state with the downloaded image
            setState(() {
              _imageFile = file;
              _imageBytes = Uint8List.fromList(bytes);
              _networkImageLoaded = true;
              _isLoadingImage = false;
              _downloadProgress = 1.0;
              _statusMessage = '';
            });
            
            client.close();
          },
          onError: (error) {
            throw Exception('Error during download: $error');
          },
        );
      } else {
        throw Exception('Failed to download image: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error downloading poster image: $e');
      setState(() {
        _isLoadingImage = false;
        _statusMessage = '';
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to download business image'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
  
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _statusMessage = 'Processing image...';
        _isLoadingImage = true;
      });
      
      try {
        final image = File(pickedFile.path);
        final bytes = await image.readAsBytes();

        setState(() {
          _imageFile = image;
          _imageBytes = bytes;
          _isLoadingImage = false;
          _statusMessage = '';
        });
      } catch (e) {
        setState(() {
          _isLoadingImage = false;
          _statusMessage = '';
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to process image: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _saveBusinessData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('businessName', _businessNameController.text);
    await prefs.setString('ownerName', _ownerNameController.text);
    await prefs.setString('designation', _designationController.text);
    await prefs.setString('contact', _contactController.text);
    await prefs.setString('whatsapp', _whatsappController.text);
    await prefs.setString('address', _addressController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('website', _websiteController.text);
    await prefs.setString('gst', _gstController.text);
    await prefs.setString('socialMedia', _socialMediaController.text);
    await prefs.setString('businessTimings', _businessTimingsController.text);

    debugPrint('Business data saved to SharedPreferences');
  }

  Future<void> _loadBusinessData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _businessNameController.text = prefs.getString('businessName') ?? '';
      _ownerNameController.text = prefs.getString('ownerName') ?? '';
      _designationController.text = prefs.getString('designation') ?? '';
      _contactController.text = prefs.getString('contact') ?? '';
      _whatsappController.text = prefs.getString('whatsapp') ?? '';
      _addressController.text = prefs.getString('address') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _websiteController.text = prefs.getString('website') ?? '';
      _gstController.text = prefs.getString('gst') ?? '';
      _socialMediaController.text = prefs.getString('socialMedia') ?? '';
      _businessTimingsController.text = prefs.getString('businessTimings') ?? '';
    });
  }

  Future<void> _saveToGallery() async {
    try {
      setState(() {
        _statusMessage = 'Saving business data...';
        _isLoading = true;
        _downloadProgress = 0.2;
        _animationController.value = 0.2;
      });
      
      await _saveBusinessData();
      
      setState(() {
        _statusMessage = 'Creating business card...';
        _downloadProgress = 0.5;
        _animationController.value = 0.5;
      });
      
      await _saveBusinessCardToGallery();
    } catch (e) {
      debugPrint('Error in save process: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      
      setState(() {
        _isLoading = false;
        _statusMessage = '';
      });
    }
  }

  Future<void> _saveBusinessCardToGallery() async {
    try {
      // First ensure we rebuild the preview container to be visible
      setState(() {
        _statusMessage = 'Preparing your business card...';
        _downloadProgress = 0.7;
        _animationController.value = 0.7;
      });

      // Allow sufficient time for the widget to fully render
      await Future.delayed(const Duration(milliseconds: 800));

      final boundary = _previewContainer.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
        
      if (boundary == null) {
        throw Exception('Could not find the RepaintBoundary widget');
      }

      // Ensure the widget is fully painted before capturing
      await Future.delayed(const Duration(milliseconds: 300));
      
      setState(() {
        _statusMessage = 'Rendering business card...';
        _downloadProgress = 0.8;
        _animationController.value = 0.8;
      });

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        throw Exception('Failed to convert image to PNG format');
      }
       
      final pngBytes = byteData.buffer.asUint8List();
      
      setState(() {
        _statusMessage = 'Saving to gallery...';
        _downloadProgress = 0.9;
        _animationController.value = 0.9;
      });

      final permission = await PhotoManager.requestPermissionExtend();
      if (permission.isAuth) {
        final fileName = 'business_card_${DateTime.now().millisecondsSinceEpoch}.png';

        await PhotoManager.editor.saveImage(
          filename: 'gallery',
          pngBytes,
          title: fileName,
          desc: 'Business Card for ${_businessNameController.text}',
        );
        
        setState(() {
          _statusMessage = 'Complete!';
          _downloadProgress = 1.0;
          _animationController.value = 1.0;
        });
        
        await Future.delayed(const Duration(milliseconds: 500));

        if (!widget.shouldSaveOnCreate) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Business card saved to gallery!'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Permission denied to save to gallery'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error saving to gallery: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving business card: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
        _statusMessage = '';
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_isLoadingImage)
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      value: _downloadProgress > 0 ? _downloadProgress : null,
                      strokeWidth: 3,
                      valueColor:const AlwaysStoppedAnimation<Color>(
                        Colors.blueAccent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _statusMessage,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                  if (_downloadProgress > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '${(_downloadProgress * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                ],
              ),
            )
          else if (_imageFile != null)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  _imageFile!,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          const SizedBox(height: 16),
          Text(
            _networkImageLoaded 
                ? 'Business logo uploaded successfully'
                : 'Tap below to upload your business logo',
            style: TextStyle(
              fontSize: 14, 
              color: Colors.grey[700],
              fontWeight: FontWeight.w500
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _isLoadingImage ? null : _pickImage,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _imageFile != null 
                    ? Colors.white 
                    : Colors.blueAccent.withOpacity(0.1),
                border: Border.all(
                  color: Colors.blueAccent.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _isLoadingImage
                  ? const SizedBox(
                      width: 20, 
                      height: 20, 
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                      ),
                    )
                  : _imageFile != null
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
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.preview, size: 18, color: Colors.deepPurple),
              const SizedBox(width: 8),
              const Text(
                'Business Card Preview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1.5),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              image: DecorationImage(
                image: const AssetImage('assets/images/card_background.png'),
                fit: BoxFit.cover,
                opacity: 0.2,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.85),
                  BlendMode.srcOver,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top section with company name
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      if (_imageFile != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Image.file(
                            _imageFile!,
                            height: 60,
                            width: 60,
                            fit: BoxFit.contain,
                          ),
                        ),
                      Text(
                        _businessNameController.text.isNotEmpty
                            ? _businessNameController.text
                            : 'Software Company',
                        style: const TextStyle(
                          fontSize: 20, 
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _designationController.text.isNotEmpty
                            ? _designationController.text
                            : 'Your tagline or description here',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                // About Us section
                _buildSectionContainer(
                  title: 'About Us',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name and designation
                        Row(
                          children: [
                            const Text(
                              'Name: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              _ownerNameController.text.isNotEmpty
                                  ? _ownerNameController.text
                                  : 'Your Name',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Text(
                              'Designation: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _designationController.text.isNotEmpty
                                    ? _designationController.text
                                    : 'Your designation here',
                                style: const TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Contact Details section
                _buildSectionContainer(
                  title: 'Contact Details',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_whatsappController.text.isNotEmpty)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.whatshot, size: 16, color: Colors.green),
                              const SizedBox(width: 4),
                              const Text(
                                'WhatsApp: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _whatsappController.text,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        if (_emailController.text.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.email, size: 16, color: Colors.red),
                                const SizedBox(width: 4),
                                const Text(
                                  'Email: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    _emailController.text,
                                    style: const TextStyle(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (_addressController.text.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.location_on, size: 16, color: Colors.red),
                                const SizedBox(width: 4),
                                const Text(
                                  'Address: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    _addressController.text,
                                    style: const TextStyle(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                
                // Social Media Links section
                _buildSectionContainer(
                  title: 'Social Media Links',
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Your social media links here',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
                
                // Business Info section
                _buildSectionContainer(
                  title: 'Business Info',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'GST No: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              _gstController.text.isNotEmpty
                                  ? _gstController.text
                                  : '123456789',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Text(
                              'Business Timings: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              _businessTimingsController.text.isNotEmpty
                                  ? _businessTimingsController.text
                                  : _businessNameController.text.isNotEmpty
                                      ? _businessNameController.text
                                      : 'Software Company',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Product Images section
                _buildSectionContainer(
                  title: 'Product Images',
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Placeholder for product images
                        Placeholder(
                          fallbackHeight: 40,
                          fallbackWidth: 40,
                        ),
                        Placeholder(
                          fallbackHeight: 40,
                          fallbackWidth: 40,
                        ),
                        Placeholder(
                          fallbackHeight: 40,
                          fallbackWidth: 40,
                        ),
                        Placeholder(
                          fallbackHeight: 40,
                          fallbackWidth: 40,
                        ),
                      ],
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

  Widget _buildSectionContainer({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: _headerColor,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          color: _accentColor,
          child: child,
        ),
      ],
    );
  }

  // The actual render container used for generating the image
  Widget _buildBusinessCardRender() {
    return Container(
      width: 500, // Fixed width for business card
      color: _backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top section with company name
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                if (_imageFile != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Image.file(
                      _imageFile!,
                      height: 60,
                      width: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
               Text(
                  _businessNameController.text.isNotEmpty
                      ? _businessNameController.text
                      : 'Software Company',
                  style: const TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  _designationController.text.isNotEmpty
                      ? _designationController.text
                      : 'Your tagline or description here',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
          // About Us section
          _buildSectionContainer(
            title: 'About Us',
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and designation
                  Row(
                    children: [
                      const Text(
                        'Name: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        _ownerNameController.text.isNotEmpty
                            ? _ownerNameController.text
                            : 'Your Name',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text(
                        'Designation: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          _designationController.text.isNotEmpty
                              ? _designationController.text
                              : 'Your designation here',
                          style: const TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Contact Details section
          _buildSectionContainer(
            title: 'Contact Details',
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_contactController.text.isNotEmpty)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.phone, size: 16, color: Colors.blue),
                        const SizedBox(width: 4),
                        const Text(
                          'Phone: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _contactController.text,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  if (_whatsappController.text.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.whatshot, size: 16, color: Colors.green),
                          const SizedBox(width: 4),
                          const Text(
                            'WhatsApp: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              _whatsappController.text,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (_emailController.text.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.email, size: 16, color: Colors.red),
                          const SizedBox(width: 4),
                          const Text(
                            'Email: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              _emailController.text,
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (_addressController.text.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on, size: 16, color: Colors.red),
                          const SizedBox(width: 4),
                          const Text(
                            'Address: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              _addressController.text,
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          
          // Social Media Links section
          if (_socialMediaController.text.isNotEmpty)
            _buildSectionContainer(
              title: 'Social Media Links',
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.public, size: 16, color: Colors.blue),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        _socialMediaController.text,
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            _buildSectionContainer(
              title: 'Social Media Links',
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Your social media links here',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          
          // Business Info section
          _buildSectionContainer(
            title: 'Business Info',
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_gstController.text.isNotEmpty)
                    Row(
                      children: [
                        const Text(
                          'GST No: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          _gstController.text,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  if (_businessTimingsController.text.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.access_time, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          const Text(
                            'Hours: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              _businessTimingsController.text,
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (_websiteController.text.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.web, size: 16, color: Colors.blue),
                          const SizedBox(width: 4),
                          const Text(
                            'Website: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              _websiteController.text,
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
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
        centerTitle: true,
        title:  Text('Business Card Maker',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.grey[100],
            ),
          ),
          
          // Hidden container for rendering (positioned offscreen)
          Positioned(
            left: -1000, // Position offscreen
            child: RepaintBoundary(
              key: _previewContainer,
              child: Container(
                width: 500, // Fixed width for business card
                color: Colors.white,
                child: _buildBusinessCardRender(),
              ),
            ),
          ),
          
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.business, color: Colors.blue[700]),
                          const SizedBox(width: 8),
                          Text(
                            'Business Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      buildTextField('Business Name', _businessNameController),
                      buildTextField('Owner Name', _ownerNameController),
                      buildTextField('Designation', _designationController),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.image, color: Colors.blue[700]),
                          const SizedBox(width: 8),
                          Text(
                            'Business Logo',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      buildImagePicker(),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.contact_phone, color: Colors.blue[700]),
                          const SizedBox(width: 8),
                          Text(
                            'Contact Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      buildTextField('Phone Number', _contactController),
                      buildTextField('WhatsApp Number', _whatsappController),
                      buildTextField('Email Address', _emailController),
                      buildTextField('Website', _websiteController),
                      buildTextField('Address', _addressController),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Card(
              //   elevation: 2,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(16),
              //     child: Row(
              //       children: [
              //         // Icon(Icons.business_center, color: Colors.blue[700]),
              //         const SizedBox(width: 8),
              //         // Text(
              //         //   'Additional Information',
              //         //   style: TextStyle(
              //         //     fontSize: 18,
              //         //     fontWeight: FontWeight.bold,
              //         //     color: Colors.blue[700],
              //         //   ),
              //         // ),
              //       ],
              //     ),
              //   ),
              // ),
              
              const SizedBox(height: 24),
              
              // Business Card Preview section
              _buildBusinessCardPreview(),
              
              const SizedBox(height: 32),
              
              // Save Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _saveToGallery,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  icon: _isLoading 
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            value: _downloadProgress > 0 ? _downloadProgress : null,
                          ),
                        ) 
                      : const Icon(Icons.save_alt),
                  label: Text(
                    _isLoading ? 'Saving... ${(_downloadProgress * 100).toInt()}%' : 'Save to Gallery',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
          
          // Loading overlay
          if (_isLoading && !_autoSaveInProgress)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
                            value: _downloadProgress > 0 ? _downloadProgress : null,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          _statusMessage,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (_downloadProgress > 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              '${(_downloadProgress * 100).toInt()}%',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[700],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}