// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:company_project/views/presentation/pages/home/poster/edit_brand.dart';

// class BrandInfoScreenposter extends StatefulWidget {
//   @override
//   State<BrandInfoScreenposter> createState() => _BrandInfoScreenState();
// }

// class _BrandInfoScreenState extends State<BrandInfoScreenposter> {
//   File? _backgroundImage;
//   bool _showContactNumber = false;
//   final String _contactNumber = "+8051281283";

//   Future<void> _pickBackgroundImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _backgroundImage = File(pickedFile.path);
//       });
//     }
//   }

//   void _toggleContactNumber() {
//     setState(() {
//       _showContactNumber = !_showContactNumber;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Top bar
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Icon(Icons.arrow_back_ios_new),
//                   ),
//                   SizedBox(width: 10),
//                   Icon(Icons.layers),
//                   Spacer(),
//                   ElevatedButton.icon(
//                     onPressed: () {},
//                     icon: Icon(Icons.download, color: Colors.white),
//                     label: Text(
//                       "Download",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF6C47FF),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),

//             Expanded(
//               child: Center(
//                 child: Image.network(
//                   'https://s3-alpha-sig.figma.com/img/4e71/f25b/9da2a00e2c56e397c0aab306442e3108?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=bXabt491VjIxVWXU4BwFOpRQ0~dptbneilGiT0gLdaKzX1SjMqGtvvfCpkQG~RWVPnkq11fJt8JmQJ5af5eZY3ng~K-gfxAjE117qFSPH-Hms5MkgfGBrDbcWrI3yZCNDM2G4gje4blA-m3jaRn9ZqRM8qobMkHHK5huEGvljuXC5aFsKaZq3VXT82fLc-em0wuVfGsEy~5TtzK5i7AqD7N~jD2ZT3C4xzKbSBXi0OFqwQUIs03A3I0wv7BxDbBq3g50CQs9rVXd77dNpPoAq4KYz2ZzsmyXgUlJhXAmugo4uIOssMg-uxiTATfvprOVsXRMhAfcrcT9XKu9lFpYkA__',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),

//             Flexible(
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: const BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // Header
//                       Row(
//                         children: [
//                           Text(
//                             "Brand Info",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Spacer(),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => EditBrand(),
//                                 ),
//                               );
//                             },
//                             child: CircleAvatar(
//                               child: Icon(Icons.edit, color: Colors.blue),
//                               backgroundColor: Colors.white,
//                             ),
//                           ),
//                           SizedBox(width: 8),
//                           Text(
//                             'Edit',
//                             style: TextStyle(color: Colors.white, fontSize: 16),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16),

//                       // Buttons Row
//                       Wrap(
//                         spacing: 12,
//                         runSpacing: 12,
//                         alignment: WrapAlignment.spaceBetween,
//                         children: [
//                           GestureDetector(
//                             onTap: _toggleContactNumber,
//                             child: _buildBrandButton(Icons.phone, "Logo"),
//                           ),
//                           GestureDetector(
//                             onTap: _toggleContactNumber,
//                             child: _buildBrandButton(Icons.phone, "Business Name"),
//                           ),
//                           _buildBrandButton(Icons.share, "Contact Number"),
//                           GestureDetector(
//                             onTap: _pickBackgroundImage,
//                             child: _buildBrandButton(Icons.image, "Address"),
//                           ),
//                           GestureDetector(
//                             onTap: _pickBackgroundImage,
//                             child: _buildBrandButton(Icons.image, "Social Media"),
//                           ),
//                           GestureDetector(
//                             onTap: _pickBackgroundImage,
//                             child: _buildBrandButton(Icons.image, "Company Logo"),
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: 12),

//                       if (_showContactNumber)
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8.0),
//                           child: Text(
//                             'Contact: $_contactNumber',
//                             style: TextStyle(color: Colors.white, fontSize: 16),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBrandButton(IconData icon, String label) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Icon(icon, color: Colors.black),
//         ),
//         SizedBox(height: 6),
//         SizedBox(
//           width: 70,
//           child: Text(
//             label,
//             style: TextStyle(color: Colors.white, fontSize: 10),
//             textAlign: TextAlign.center,
//           ),
//         )
//       ],
//     );
//   }
// }
