// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'dart:io';

import 'package:company_project/models/deitor_item.dart';
import 'package:company_project/models/poster_model.dart';
import 'package:company_project/models/poster_size_model.dart';
import 'package:company_project/models/poster_template_model.dart';
import 'package:company_project/views/presentation/pages/home/poster/add_element_screen.dart';
import 'package:company_project/views/presentation/pages/home/poster/add_image.dart';
import 'package:company_project/views/presentation/pages/home/poster/add_shape.dart';
import 'package:company_project/views/presentation/pages/home/poster/animation_screen.dart';
import 'package:company_project/views/presentation/pages/home/poster/audio_screen.dart';
import 'package:company_project/views/presentation/pages/home/poster/brand_screen.dart';
import 'package:company_project/views/presentation/widgets/bottom_navbar.dart';
import 'package:company_project/views/presentation/widgets/sticker_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

// class PosterTemplate extends StatefulWidget {
//   const PosterTemplate({super.key});

//   @override
//   State<PosterTemplate> createState() => _PosterTemplateState();
// }

// class _PosterTemplateState extends State<PosterTemplate> {
//   double _sliderPosition = 150;
//   bool _showLayerSlider = false;

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         icon: const Icon(Icons.arrow_back_ios),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _showLayerSlider = !_showLayerSlider;
//                           });
//                         },
//                         child: const Icon(Icons.layers),
//                       ),
//                       const Spacer(),
//                       InkWell(
//                         onTap: () {},
//                         borderRadius: BorderRadius.circular(30),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 10),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             gradient: const LinearGradient(
//                               colors: [
//                                 Color(0xFF5C6BC0),
//                                 Color.fromARGB(255, 127, 81, 255)
//                               ],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ),
//                           ),
//                           child: const Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.download_for_offline_sharp,
//                                 color: Colors.white,
//                                 size: 18,
//                               ),
//                               SizedBox(width: 6),
//                               Text(
//                                 'Download',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   Expanded(
//                     child: Center(
//                       child: ClipRRect(
//                         child: Image.network(
//                           'https://s3-alpha-sig.figma.com/img/9cf6/9546/ebfe8be7faa0bcece189903d1e14b4d7?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=YGwJR0j8WDu-tfa~nvJd90b9coqrtqXsWyqXePok5XUXvpyN5lVWahW33A5oomX6R05rIsJnDgFouHZMy3-~iGFbdXhbaupOkOAtNM2p3O6o9iBJDeil8qfb519bIUiu-7dZBHmy~y~UUOf-eymwdj9ikjqOY~XTlycxvxcZJE3rwdcZg6pAptH6Kw~nVTymvMpIq~eLrcrq2vLxVdWVhw7jNLHAZkpfIe0jCALLAgmQ5nyZNvMqRwmnAcpSKxwjudRM0ZsDqcCUukmupdFSNCB8fbpurIjoTK7v9KR6S0WCkv5MpzD0sJiXfsXGVLHK80RHO69RMXtGZAPhRsRNkQ__',
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 70,
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
//                     color: Colors.black,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: [
//                           const SizedBox(width: 12),
//                           GestureDetector(
//                             onTap: () {
//                               showAddTextBottomSheet(context);
//                             },
//                             child: BottomNavbaritem(
//                                 icon: Icons.text_fields, label: 'Text'),
//                           ),
//                           const SizedBox(width: 24),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => AudioScreen()));
//                             },
//                             child: BottomNavbaritem(
//                                 icon: Icons.music_note, label: 'Audio'),
//                           ),
//                           const SizedBox(width: 24),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const AnimationScreen()));
//                             },
//                             child: BottomNavbaritem(
//                                 icon: Icons.animation, label: 'Animation'),
//                           ),
//                           const SizedBox(width: 24),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => FlyerScreen()));
//                             },
//                             child: BottomNavbaritem(
//                                 icon: Icons.info_outline, label: 'Brand Info'),
//                           ),
//                           SizedBox(width: 24),
//                           GestureDetector(
//                             onTap: () {
//                               showModalBottomSheet(
//                                   context: context,
//                                   isScrollControlled: true,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.vertical(
//                                           top: Radius.circular(20))),
//                                   builder: (context) => StickerPicker());
//                             },
//                             child: BottomNavbaritem(
//                                 icon: Icons.emoji_emotions_outlined,
//                                 label: 'Sticker'),
//                           ),
//                           const SizedBox(width: 24),
//                           GestureDetector(
//                             onTap: () {
//                               showModalBottomSheet(
//                                 context: context,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.vertical(
//                                       top: Radius.circular(20)),
//                                 ),
//                                 backgroundColor: Colors.white,
//                                 isScrollControlled: true,
//                                 builder: (context) {
//                                   return Padding(
//                                     padding: const EdgeInsets.all(16.0),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Text('Effects',
//                                             style: TextStyle(
//                                                 fontSize: 20,
//                                                 fontWeight: FontWeight.bold)),
//                                         SizedBox(height: 16),
//                                         GridView.builder(
//                                           shrinkWrap: true,
//                                           itemCount: 12,
//                                           gridDelegate:
//                                               SliverGridDelegateWithFixedCrossAxisCount(
//                                             crossAxisCount: 4,
//                                             crossAxisSpacing: 10,
//                                             mainAxisSpacing: 10,
//                                           ),
//                                           itemBuilder: (context, index) {
//                                             return GestureDetector(
//                                               onTap: () {
//                                                 Navigator.pop(context);
//                                               },
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                   image: DecorationImage(
//                                                     image: NetworkImage(
//                                                         'https://s3-alpha-sig.figma.com/img/5e8e/a20b/0e90eda78d8ce5b358accbc97b5e0476?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=lcb~llFZJWH3X9GXWLJbZP9FH-Va3HaqX0-tUqh312afObF3eTTYontZpvDAKmg~HiGoX9OeqqrWxNIL3Vc~y~7Y7HS0bu2MvXuBrjp~CjjabYJvuwK2z~tnnFKMhjGXUVLzzBQeXjEb5VrEuF2XZdlUYhpSV5DiyBbdtDKJ8-9tqYdu~wW7Fk~YhDN1HoEB0FHUa4Pbvd2jKnhr1Uoj~o0TDQbbS6zBMxEHVscCpnXAIQqPyRVwQrapidke8t09n5LR7yLyGHCW01xnNNDJNPe51KQq6As4BLsoIgdOpJN-J1C9Uwrae10q7EvYfdD9BKmCfVgYBTqdHdbnbP6KVA__'), // Replace with your asset path
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                   border: Border.all(
//                                                     color: index == 2
//                                                         ? Colors.cyanAccent
//                                                         : Colors.transparent,
//                                                     width: 3,
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                         SizedBox(height: 20),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                             child: BottomNavbaritem(
//                                 icon: Icons.explore_off_outlined,
//                                 label: 'Effects'),
//                           ),
//                           const SizedBox(width: 24),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddElementScreen()));
//                             },
//                             child: BottomNavbaritem(
//                                 icon: Icons.electric_meter_rounded,
//                                 label: 'Elements'),
//                           ),
//                           const SizedBox(width: 24),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddShape()));
//                             },
//                             child: BottomNavbaritem(
//                                 icon: Icons.category, label: 'Shapes'),
//                           ),
//                           const SizedBox(width: 24),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddImage()));
//                             },
//                             child: BottomNavbaritem(
//                                 icon: Icons.badge, label: 'Background'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             if (_showLayerSlider) ...[
//               Positioned.fill(
//                 left: _sliderPosition,
//                 child: Container(
//                   color: Colors.black.withOpacity(0.5),
//                 ),
//               ),
//               Positioned(
//                 left: _sliderPosition - 1,
//                 top: 0,
//                 bottom: 0,
//                 child: GestureDetector(
//                   onHorizontalDragUpdate: (details) {
//                     setState(() {
//                       _sliderPosition += details.delta.dx;
//                       if (_sliderPosition < 0) _sliderPosition = 0;
//                       if (_sliderPosition > screenWidth) {
//                         _sliderPosition = screenWidth;
//                       }
//                     });
//                   },
//                   child: Container(
//                     width: 3,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ]
//           ],
//         ),
//       ),
//     );
//   }

//   void showAddTextBottomSheet(BuildContext context) {
//     TextEditingController _textController = TextEditingController();

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//             top: 10,
//             left: 10,
//             right: 10,
//           ),
//           child: Container(
//             height:
//                 MediaQuery.of(context).size.height * 0.5, // Half screen height
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.close),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     Text(
//                       "Add Text",
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.check),
//                       onPressed: () {
//                         String addedText = _textController.text;
//                         Navigator.pop(context);
//                         print("Text added: $addedText");
//                       },
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),

//                 // TextField
//                 Expanded(
//                   child: TextField(
//                     controller: _textController,
//                     maxLines: null,
//                     expands: true,
//                     decoration: InputDecoration(
//                       hintText: 'Add Your Text here',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class BottomNavbaritem extends StatelessWidget {
//   final IconData icon;
//   final String label;

//   BottomNavbaritem({required this.icon, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(
//           icon,
//           color: Colors.white,
//         ),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: const TextStyle(color: Colors.white, fontSize: 12),
//         ),
//       ],
//     );
//   }
// }

// class StickerPicker extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       height: 300, // adjust height as needed
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("Select Sticker",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               // SizedBox(width: 40,),
//               // Icon(Icons.image),
//               // SizedBox(width: 70,),
//               // Text('Choose from\nGallery ')
//             ],
//           ),
//           SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _categoryChip(context, "Business", true),
//               _categoryChip(context, "Education", false),
//               _categoryChip(context, "Ugadi", false),
//               _categoryChip(context, "Beauty", false),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               _stickerCard("assets/sticker1.png"),
//               _stickerCard("assets/sticker2.png"),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _categoryChip(BuildContext context, String label, bool isSelected) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
//         borderRadius: BorderRadius.circular(20),
//         color: isSelected ? Colors.blue.shade100 : Colors.transparent,
//       ),
//       child: Text(label),
//     );
//   }

//   Widget _stickerCard(String assetPath) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 8.0),
//       child: Container(
//           width: 80,
//           height: 80,
//           padding: EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade300),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Image.network(
//               'https://s3-alpha-sig.figma.com/img/07a0/1466/64d5872b93df17bb100eb7a52c533210?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=hYYZm~RMOrGasAsiyp4pjNKBSKdv3BTdbnlcSA4agRYmGyLLYExfGSPi59GL2JErFA1oaZcvxWkzXawazyerSbeaAuwleIcyTykjBRqBW5eiDigQ2vlCpOfpIJHGX2DHbqL7Uw7FO5iERMvlkeU8RvJH15hWvJncYvvq2qzcdpphordCrfInqe0RO22KvwDrWPt6oIJiZaP8k5o3sbAwZm9KiRijnaBJtpK6H9sgv~GaCjPOIEwIo7WvO3ZLpJ-54CgnArzWwV3zbf~H~K-WxcU5MmQa395qSKo~bys4mD-b07ad40yiIzCdZqgkuG7zAn7NwLp5aroxWzfx3Gyuig__') // Replace with NetworkImage or FileImage if needed
//           ),
//     );
//   }
// }

// class PosterTemplate extends StatefulWidget {
//   final bool isCustom;
//   final TemplateModel? poster; // Passed when selecting an existing poster
//   final PosterSize? customSize; // Passed when creating a custom poster

//   const PosterTemplate({
//     super.key,
//     required this.isCustom,
//     this.poster,
//     this.customSize,
//   });

//   @override
//   State<PosterTemplate> createState() => _PosterTemplateState();
// }

// class _PosterTemplateState extends State<PosterTemplate> {
//   double _sliderPosition = 150;
//   bool _showLayerSlider = false;

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         icon: const Icon(Icons.arrow_back_ios),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _showLayerSlider = !_showLayerSlider;
//                           });
//                         },
//                         child: const Icon(Icons.layers),
//                       ),
//                       const Spacer(),
//                       InkWell(
//                         onTap: () {},
//                         borderRadius: BorderRadius.circular(30),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 10),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             gradient: const LinearGradient(
//                               colors: [
//                                 Color(0xFF5C6BC0),
//                                 Color.fromARGB(255, 127, 81, 255)
//                               ],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ),
//                           ),
//                           child: const Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.download_for_offline_sharp,
//                                 color: Colors.white,
//                                 size: 18,
//                               ),
//                               SizedBox(width: 6),
//                               Text(
//                                 'Download',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   Expanded(
//                     child: Center(
//                       child: ClipRRect(
//                         child: widget.isCustom
//                           // Custom blank canvas with the selected size
//                           ? AspectRatio(
//                               aspectRatio: widget.customSize!.width / widget.customSize!.height,
//                               child: Container(
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border: Border.all(color: Colors.grey),
//                                   boxShadow: const [
//                                     BoxShadow(
//                                       color: Colors.black26,
//                                       blurRadius: 5,
//                                       offset: Offset(0, 2),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     '${widget.customSize!.title}\n${widget.customSize!.size}',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       color: Colors.grey[400],
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           // Show the selected poster
//                           : widget.poster != null
//                               ? Image.network(
//                                   widget.poster!.images[0],
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return Container(
//                                       color: Colors.grey[300],
//                                       child: const Icon(Icons.image_not_supported),
//                                     );
//                                   },
//                                 )
//                               // Default placeholder image if no poster is selected
//                               : Image.network(
//                                   'https://s3-alpha-sig.figma.com/img/9cf6/9546/ebfe8be7faa0bcece189903d1e14b4d7?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=YGwJR0j8WDu-tfa~nvJd90b9coqrtqXsWyqXePok5XUXvpyN5lVWahW33A5oomX6R05rIsJnDgFouHZMy3-~iGFbdXhbaupOkOAtNM2p3O6o9iBJDeil8qfb519bIUiu-7dZBHmy~y~UUOf-eymwdj9ikjqOY~XTlycxvxcZJE3rwdcZg6pAptH6Kw~nVTymvMpIq~eLrcrq2vLxVdWVhw7jNLHAZkpfIe0jCALLAgmQ5nyZNvMqRwmnAcpSKxwjudRM0ZsDqcCUukmupdFSNCB8fbpurIjoTK7v9KR6S0WCkv5MpzD0sJiXfsXGVLHK80RHO69RMXtGZAPhRsRNkQ__',
//                                   fit: BoxFit.cover,
//                                 ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 70,
//                     padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
//                     color: Colors.black,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: [
//                           const SizedBox(width: 12),
//                           GestureDetector(
//                             onTap: () {
//                               showAddTextBottomSheet(context);
//                             },
//                             child: BottomNavbaritem(
//                               icon: Icons.text_fields, label: 'Text'),
//                           ),
//                           const SizedBox(width: 24),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => AudioScreen()
//                                 )
//                               );
//                             },
//                             child: BottomNavbaritem(
//                               icon: Icons.music_note, label: 'Audio'),
//                           ),
//                           const SizedBox(width: 24),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const AnimationScreen()
//                                 )
//                               );
//                             },
//                             child: BottomNavbaritem(
//                               icon: Icons.animation, label: 'Animation'),
//                           ),
//                           const SizedBox(width: 24),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => FlyerScreen()
//                                 )
//                               );
//                             },
//                             child: BottomNavbaritem(
//                               icon: Icons.info_outline, label: 'Brand Info'),
//                           ),
//                           const SizedBox(width: 24),
//                           GestureDetector(
//                             onTap: () {
//                               showModalBottomSheet(
//                                 context: context,
//                                 isScrollControlled: true,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.vertical(
//                                     top: Radius.circular(20)
//                                   )
//                                 ),
//                                 builder: (context) => StickerPicker()
//                               );
//                             },
//                             child: BottomNavbaritem(
//                               icon: Icons.emoji_emotions_outlined,
//                               label: 'Sticker'
//                             ),
//                           ),
//                           // Rest of the navigation items...
//                           const SizedBox(width: 24),
//                           GestureDetector(
//                             onTap: () {
//                               showModalBottomSheet(
//                                 context: context,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.vertical(
//                                     top: Radius.circular(20)
//                                   ),
//                                 ),
//                                 backgroundColor: Colors.white,
//                                 isScrollControlled: true,
//                                 builder: (context) {
//                                   return Padding(
//                                     padding: const EdgeInsets.all(16.0),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Text('Effects',
//                                           style: TextStyle(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold
//                                           )
//                                         ),
//                                         SizedBox(height: 16),
//                                         GridView.builder(
//                                           shrinkWrap: true,
//                                           itemCount: 12,
//                                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                             crossAxisCount: 4,
//                                             crossAxisSpacing: 10,
//                                             mainAxisSpacing: 10,
//                                           ),
//                                           itemBuilder: (context, index) {
//                                             return GestureDetector(
//                                               onTap: () {
//                                                 Navigator.pop(context);
//                                               },
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                   image: DecorationImage(
//                                                     image: NetworkImage(
//                                                       'https://s3-alpha-sig.figma.com/img/5e8e/a20b/0e90eda78d8ce5b358accbc97b5e0476?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=lcb~llFZJWH3X9GXWLJbZP9FH-Va3HaqX0-tUqh312afObF3eTTYontZpvDAKmg~HiGoX9OeqqrWxNIL3Vc~y~7Y7HS0bu2MvXuBrjp~CjjabYJvuwK2z~tnnFKMhjGXUVLzzBQeXjEb5VrEuF2XZdlUYhpSV5DiyBbdtDKJ8-9tqYdu~wW7Fk~YhDN1HoEB0FHUa4Pbvd2jKnhr1Uoj~o0TDQbbS6zBMxEHVscCpnXAIQqPyRVwQrapidke8t09n5LR7yLyGHCW01xnNNDJNPe51KQq6As4BLsoIgdOpJN-J1C9Uwrae10q7EvYfdD9BKmCfVgYBTqdHdbnbP6KVA__'
//                                                     ),
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                   border: Border.all(
//                                                     color: index == 2
//                                                       ? Colors.cyanAccent
//                                                       : Colors.transparent,
//                                                     width: 3,
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                         SizedBox(height: 20),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                             child: BottomNavbaritem(
//                               icon: Icons.explore_off_outlined,
//                               label: 'Effects'
//                             ),
//                           ),
//                           const SizedBox(width: 24),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(context, MaterialPageRoute(
//                                 builder: (context) => const AddElementScreen()
//                               ));
//                             },
//                             child: BottomNavbaritem(
//                               icon: Icons.electric_meter_rounded,
//                               label: 'Elements'
//                             ),
//                           ),
//                           const SizedBox(width: 24),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(context, MaterialPageRoute(
//                                 builder: (context) => const AddShape()
//                               ));
//                             },
//                             child: BottomNavbaritem(
//                               icon: Icons.category, label: 'Shapes'
//                             ),
//                           ),
//                           const SizedBox(width: 24),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(context, MaterialPageRoute(
//                                 builder: (context) => const AddImage()
//                               ));
//                             },
//                             child: BottomNavbaritem(
//                               icon: Icons.badge, label: 'Background'
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             if (_showLayerSlider) ...[
//               Positioned.fill(
//                 left: _sliderPosition,
//                 child: Container(
//                   color: Colors.black.withOpacity(0.5),
//                 ),
//               ),
//               Positioned(
//                 left: _sliderPosition - 1,
//                 top: 0,
//                 bottom: 0,
//                 child: GestureDetector(
//                   onHorizontalDragUpdate: (details) {
//                     setState(() {
//                       _sliderPosition += details.delta.dx;
//                       if (_sliderPosition < 0) _sliderPosition = 0;
//                       if (_sliderPosition > screenWidth) {
//                         _sliderPosition = screenWidth;
//                       }
//                     });
//                   },
//                   child: Container(
//                     width: 3,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ]
//           ],
//         ),
//       ),
//     );
//   }

//   void showAddTextBottomSheet(BuildContext context) {
//     TextEditingController _textController = TextEditingController();

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//             top: 10,
//             left: 10,
//             right: 10,
//           ),
//           child: Container(
//             height: MediaQuery.of(context).size.height * 0.5, // Half screen height
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.close),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     Text(
//                       "Add Text",
//                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.check),
//                       onPressed: () {
//                         String addedText = _textController.text;
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),

//                 // TextField
//                 Expanded(
//                   child: TextField(
//                     controller: _textController,
//                     maxLines: null,
//                     expands: true,
//                     decoration: InputDecoration(
//                       hintText: 'Add Your Text here',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class BottomNavbaritem extends StatelessWidget {
  final IconData icon;
  final String label;

  const BottomNavbaritem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
      ],
    );
  }
}

class PosterTemplate extends StatefulWidget {
  final bool isCustom;
  final TemplateModel? poster; // Passed when selecting an existing poster
  final PosterSize? customSize; // Passed when creating a custom poster

  const PosterTemplate({
    super.key,
    required this.isCustom,
    this.poster,
    this.customSize,
  });

  @override
  State<PosterTemplate> createState() => _PosterTemplateState();
}

class _PosterTemplateState extends State<PosterTemplate> with SingleTickerProviderStateMixin {
  final ScreenshotController screenshotController = ScreenshotController();
  double _sliderPosition = 150;
  bool _showLayerSlider = false;
  String _backgroundImage = '';
  final List<EditorItem> _editorItems = [];
  EditorItem? _selectedItem;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Future<void> _downloadPoster() async {
  //   try {
  //     // First capture the screenshot
  //     final Uint8List? imageBytes = await screenshotController.capture();
  //     if (imageBytes == null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Failed to capture poster')),
  //       );
  //       return;
  //     }

  //     // Platform-specific permission handling
  //     if (Platform.isAndroid) {
  //       // For Android 10+ (Q/API 29+), we need to check different permissions
  //       if (await Permission.storage.request().isGranted) {
  //         // Permission granted, proceed with saving
  //         await _saveImageToGallery(imageBytes);
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //               content:
  //                   Text('Storage permission is required to save the poster')),
  //         );
  //       }
  //     } else if (Platform.isIOS) {
  //       // iOS usually doesn't need explicit permission for photo library saves
  //       // but we'll check photos permission to be safe
  //       if (await Permission.photos.request().isGranted) {
  //         await _saveImageToGallery(imageBytes);
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //               content:
  //                   Text('Photos permission is required to save the poster')),
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error saving poster: ${e.toString()}')),
  //     );
  //   }
  // }

  // // Add this new helper method
  // Future<void> _saveImageToGallery(Uint8List imageBytes) async {
  //   final result = await ImageGallerySaver.saveImage(
  //     imageBytes,
  //     quality: 100,
  //     name: "Poster_${DateTime.now().millisecondsSinceEpoch}",
  //   );

  //   if (result['isSuccess']) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Poster saved to gallery successfully!')),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //           content: Text(
  //               'Failed to save poster: ${result['errorMessage'] ?? "Unknown error"}')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showLayerSlider = !_showLayerSlider;
                          });
                        },
                        child: const Icon(Icons.layers),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Poster downloaded')),
                          );
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF5C6BC0),
                                Color.fromARGB(255, 127, 81, 255)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.download_for_offline_sharp,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Download',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: Screenshot(
                        controller:
                            screenshotController, // 👈 use your ScreenshotController here
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: _buildPosterCanvas(),
                            ),
                            ..._editorItems
                                .map((item) => _buildEditorItem(item)),
                            if (_selectedItem != null)
                              _buildSelectionControls(_selectedItem!),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    color: Colors.black,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              showAddTextBottomSheet(context);
                            },
                            child: const BottomNavbaritem(
                                icon: Icons.text_fields, label: 'Text'),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AudioScreen()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Audio added to poster')),
                              );
                            },
                            child: const BottomNavbaritem(
                                icon: Icons.music_note, label: 'Audio'),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AnimationScreen()));
                              _animationController.reset();
                              _animationController.forward();
                            },
                            child: const BottomNavbaritem(
                                icon: Icons.animation, label: 'Animation'),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FlyerScreen()));
                            },
                            child: const BottomNavbaritem(
                                icon: Icons.info_outline, label: 'Brand Info'),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () async {
                              final result = await showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20))),
                                  builder: (context) => StickerPicker());

                              if (result != null) {
                                _addStickerItem(result);
                              }
                            },
                            child: const BottomNavbaritem(
                                icon: Icons.emoji_emotions_outlined,
                                label: 'Sticker'),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                backgroundColor: Colors.white,
                                isScrollControlled: true,
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text('Effects',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 16),
                                        GridView.builder(
                                          shrinkWrap: true,
                                          itemCount: 12,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          'Effect ${index + 1} applied')),
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: index == 2
                                                      ? Border.all(
                                                          color:
                                                              Colors.cyanAccent,
                                                          width: 3,
                                                        )
                                                      : null,
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.auto_fix_high,
                                                    color: Colors.indigo,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: const BottomNavbaritem(
                                icon: Icons.auto_fix_high, label: 'Effects'),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () async {
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddElementScreen()));

                              if (result != null) {
                                _addShapeItem(ShapeType.star, Colors.amber);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('${result['name']} added')),
                                );
                              }
                            },
                            child: const BottomNavbaritem(
                                icon: Icons.stars, label: 'Elements'),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () async {
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AddShape()));

                              if (result != null) {
                                _addShapeItem(
                                    result['shapeType'], result['color']);
                              }
                            },
                            child: const BottomNavbaritem(
                                icon: Icons.category, label: 'Shapes'),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () async {
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AddImage()));

                              if (result != null) {
                                setState(() {
                                  _backgroundImage = result;
                                });
                              }
                            },
                            child: const BottomNavbaritem(
                                icon: Icons.badge, label: 'Background'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (_showLayerSlider) ...[
              Positioned.fill(
                left: _sliderPosition,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              Positioned(
                left: _sliderPosition - 1,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      _sliderPosition += details.delta.dx;
                      if (_sliderPosition < 0) _sliderPosition = 0;
                      if (_sliderPosition > screenWidth) {
                        _sliderPosition = screenWidth;
                      }
                    });
                  },
                  child: Container(
                    width: 3,
                    color: Colors.white,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildPosterCanvas() {
    if (widget.isCustom) {
      return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (_animation.value * 0.05),
            child: Opacity(
              opacity: 0.7 + (_animation.value * 0.3),
              child: AspectRatio(
                aspectRatio:
                    widget.customSize!.width / widget.customSize!.height,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                    image: _backgroundImage.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(_backgroundImage),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _backgroundImage.isEmpty
                      ? Center(
                          child: Text(
                            '${widget.customSize!.title}\n${widget.customSize!.size}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ),
          );
        },
      );
    } else if (widget.poster != null) {
      return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (_animation.value * 0.05),
            child: Opacity(
              opacity: 0.7 + (_animation.value * 0.3),
              child: Image.network(
                widget.poster!.images[0],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
          );
        },
      );
    } else {
      return Image.network(
        'https://s3-alpha-sig.figma.com/img/9cf6/9546/ebfe8be7faa0bcece189903d1e14b4d7?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=YGwJR0j8WDu-tfa~nvJd90b9coqrtqXsWyqXePok5XUXvpyN5lVWahW33A5oomX6R05rIsJnDgFouHZMy3-~iGFbdXhbaupOkOAtNM2p3O6o9iBJDeil8qfb519bIUiu-7dZBHmy~y~UUOf-eymwdj9ikjqOY~XTlycxvxcZJE3rwdcZg6pAptH6Kw~nVTymvMpIq~eLrcrq2vLxVdWVhw7jNLHAZkpfIe0jCALLAgmQ5nyZNvMqRwmnAcpSKxwjudRM0ZsDqcCUukmupdFSNCB8fbpurIjoTK7v9KR6S0WCkv5MpzD0sJiXfsXGVLHK80RHO69RMXtGZAPhRsRNkQ__',
        fit: BoxFit.cover,
      );
    }
  }

  Widget _buildEditorItem(EditorItem item) {
    if (item is TextItem) {
      return Positioned(
        left: item.position.dx,
        top: item.position.dy,
        child: GestureDetector(
          onTap: () {
            _selectItem(item);
          },
          onPanUpdate: (details) {
            _moveItem(item, details);
          },
          child: Transform.rotate(
            angle: item.rotation,
            child: Transform.scale(
              scale: item.scale,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: item.isSelected
                      ? Border.all(color: Colors.blue, width: 2)
                      : null,
                ),
                child: Text(
                  item.text,
                  style: TextStyle(
                    color: item.color,
                    fontSize: item.fontSize,
                    fontFamily: item.fontFamily,
                    fontWeight: item.fontWeight,
                  ),
                  textAlign: item.textAlign,
                ),
              ),
            ),
          ),
        ),
      );
    } else if (item is StickerItem) {
      return Positioned(
        left: item.position.dx,
        top: item.position.dy,
        child: GestureDetector(
          onTap: () {
            _selectItem(item);
          },
          onPanUpdate: (details) {
            _moveItem(item, details);
          },
          child: Transform.rotate(
            angle: item.rotation,
            child: Transform.scale(
              scale: item.scale,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: item.isSelected
                      ? Border.all(color: Colors.blue, width: 2)
                      : null,
                ),
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      );
    } else if (item is ShapeItem) {
      return Positioned(
        left: item.position.dx,
        top: item.position.dy,
        child: GestureDetector(
          onTap: () {
            _selectItem(item);
          },
          onPanUpdate: (details) {
            _moveItem(item, details);
          },
          child: Transform.rotate(
            angle: item.rotation,
            child: Transform.scale(
              scale: item.scale,
              child: Container(
                width: item.width,
                height: item.height,
                decoration: BoxDecoration(
                  border: item.isSelected
                      ? Border.all(color: Colors.blue, width: 2)
                      : null,
                ),
                child: _buildShapeWidget(item),
              ),
            ),
          ),
        ),
      );
    }

    return Container(); // Default empty container
  }

  Widget _buildShapeWidget(ShapeItem item) {
    switch (item.shapeType) {
      case ShapeType.rectangle:
        return Container(
          width: item.width,
          height: item.height,
          color: item.color,
        );
      case ShapeType.circle:
        return Container(
          width: item.width,
          height: item.height,
          decoration: BoxDecoration(
            color: item.color,
            shape: BoxShape.circle,
          ),
        );
      case ShapeType.triangle:
        return CustomPaint(
          size: Size(item.width, item.height),
          painter: TrianglePainter(color: item.color),
        );
      case ShapeType.star:
        return CustomPaint(
          size: Size(item.width, item.height),
          painter: StarPainter(color: item.color),
        );
      default:
        return Container();
    }
  }

  Widget _buildSelectionControls(EditorItem item) {
    // Calculate bounds based on item type
    double width = 100;
    double height = 100;

    if (item is TextItem) {
      width = 150;
      height = 30;
    } else if (item is ShapeItem) {
      width = item.width * item.scale;
      height = item.height * item.scale;
    }

    return Positioned(
      left: item.position.dx - 10,
      top: item.position.dy - 10,
      child: Container(
        width: width + 20,
        height: height + 20,
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.blue, width: 2, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Stack(
          children: [
            // Delete button (top-right)
            Positioned(
              right: -10,
              top: -10,
              child: GestureDetector(
                onTap: () {
                  _removeItem(item);
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, size: 16, color: Colors.white),
                ),
              ),
            ),

            // Rotate handle (bottom-right)
            Positioned(
              right: -10,
              bottom: -10,
              child: GestureDetector(
                onPanUpdate: (details) {
                  _rotateItem(item, details);
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.rotate_right,
                      size: 16, color: Colors.white),
                ),
              ),
            ),

            // Scale handle (bottom-left)
            Positioned(
              left: -10,
              bottom: -10,
              child: GestureDetector(
                onPanUpdate: (details) {
                  _scaleItem(item, details);
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.open_with,
                      size: 16, color: Colors.white),
                ),
              ),
            ),

            // Edit handle (top-left) - only for text
            if (item is TextItem)
              Positioned(
                left: -10,
                top: -10,
                child: GestureDetector(
                  onTap: () {
                    _editTextItem(item);
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child:
                        const Icon(Icons.edit, size: 16, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _selectItem(EditorItem item) {
    setState(() {
      // Deselect all items first
      for (var editorItem in _editorItems) {
        editorItem.isSelected = false;
      }

      // Select the tapped item
      item.isSelected = true;
      _selectedItem = item;
    });
  }

  void _moveItem(EditorItem item, DragUpdateDetails details) {
    setState(() {
      item.position = Offset(
        item.position.dx + details.delta.dx,
        item.position.dy + details.delta.dy,
      );
    });
  }

  void _rotateItem(EditorItem item, DragUpdateDetails details) {
    // Calculate the center of the item
    final centerX = item.position.dx + 50;
    final centerY = item.position.dy + 50;

    // Calculate the angle between the center and the current position
    final angle = math.atan2(
      details.globalPosition.dy - centerY,
      details.globalPosition.dx - centerX,
    );

    setState(() {
      item.rotation = angle;
    });
  }

  void _scaleItem(EditorItem item, DragUpdateDetails details) {
    setState(() {
      // Adjust scale based on drag direction
      item.scale += details.delta.dy > 0 ? -0.01 : 0.01;

      // Limit scale range
      if (item.scale < 0.5) item.scale = 0.5;
      if (item.scale > 3.0) item.scale = 3.0;
    });
  }

  void _removeItem(EditorItem item) {
    setState(() {
      _editorItems.remove(item);
      _selectedItem = null;
    });
  }

  void _editTextItem(TextItem item) {
    TextEditingController controller = TextEditingController(text: item.text);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 10,
            left: 10,
            right: 10,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      "Edit Text",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () {
                        setState(() {
                          item.text = controller.text;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // TextField
                SizedBox(
                  height: 100,
                  child: TextField(
                    controller: controller,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      hintText: 'Edit your text',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Text styling options
                const Text(
                  "Text Style",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),

                // Font size slider
                Row(
                  children: [
                    const Icon(Icons.format_size, size: 16),
                    Expanded(
                      child: Slider(
                        value: item.fontSize,
                        min: 10,
                        max: 48,
                        divisions: 38,
                        label: item.fontSize.round().toString(),
                        onChanged: (value) {
                          setState(() {
                            item.fontSize = value;
                          });
                        },
                      ),
                    ),
                    Text(item.fontSize.round().toString()),
                  ],
                ),

                // Font color picker
                const Text(
                  "Text Color",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Colors.black,
                      Colors.white,
                      Colors.red,
                      Colors.blue,
                      Colors.green,
                      Colors.yellow,
                      Colors.orange,
                      Colors.purple,
                      Colors.pink,
                      Colors.teal,
                    ].map((color) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            item.color = color;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: color,
                            border: Border.all(
                              color: item.color == color
                                  ? Colors.blue
                                  : Colors.grey,
                              width: item.color == color ? 3 : 1,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 15),

                // Text alignment
                const Text(
                  "Text Alignment",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.format_align_left),
                      color: item.textAlign == TextAlign.left
                          ? Colors.blue
                          : Colors.grey,
                      onPressed: () {
                        setState(() {
                          item.textAlign = TextAlign.left;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.format_align_center),
                      color: item.textAlign == TextAlign.center
                          ? Colors.blue
                          : Colors.grey,
                      onPressed: () {
                        setState(() {
                          item.textAlign = TextAlign.center;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.format_align_right),
                      color: item.textAlign == TextAlign.right
                          ? Colors.blue
                          : Colors.grey,
                      onPressed: () {
                        setState(() {
                          item.textAlign = TextAlign.right;
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // Font weight
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: item.fontWeight == FontWeight.normal
                            ? Colors.blue
                            : Colors.grey[300],
                      ),
                      child: Text(
                        "Normal",
                        style: TextStyle(
                          color: item.fontWeight == FontWeight.normal
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          item.fontWeight = FontWeight.normal;
                        });
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: item.fontWeight == FontWeight.bold
                            ? Colors.blue
                            : Colors.grey[300],
                      ),
                      child: Text(
                        "Bold",
                        style: TextStyle(
                          color: item.fontWeight == FontWeight.bold
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          item.fontWeight = FontWeight.bold;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showAddTextBottomSheet(BuildContext context) {
    TextEditingController controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 10,
            left: 10,
            right: 10,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      "Add Text",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () {
                        _addTextItem(controller.text);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // TextField
                Expanded(
                  child: TextField(
                    controller: controller,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      hintText: 'Add Your Text here',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addTextItem(String text) {
    if (text.isEmpty) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final newItem = TextItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      position: Offset(screenWidth / 4, screenHeight / 4),
      text: text,
      isSelected: true,
    );

    setState(() {
      // Deselect all existing items
      for (var item in _editorItems) {
        item.isSelected = false;
      }

      _editorItems.add(newItem);
      _selectedItem = newItem;
    });
  }

  void _addStickerItem(String imageUrl) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final newItem = StickerItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      position: Offset(screenWidth / 4, screenHeight / 4),
      imageUrl: imageUrl,
      isSelected: true,
    );

    setState(() {
      // Deselect all existing items
      for (var item in _editorItems) {
        item.isSelected = false;
      }

      _editorItems.add(newItem);
      _selectedItem = newItem;
    });
  }

  void _addShapeItem(ShapeType shapeType, Color color) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final newItem = ShapeItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      position: Offset(screenWidth / 4, screenHeight / 4),
      shapeType: shapeType,
      color: color,
      isSelected: true,
    );

    setState(() {
      // Deselect all existing items
      for (var item in _editorItems) {
        item.isSelected = false;
      }

      _editorItems.add(newItem);
      _selectedItem = newItem;
    });
  }
}

class StarPainter extends CustomPainter {
  final Color color;

  StarPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width < size.height ? size.width / 2 : size.height / 2;
    final innerRadius = radius * 0.4;

    const int nPoints = 5;
    const double angle = (2 * math.pi) / (2 * nPoints);

    path.moveTo(centerX + radius * math.cos(0), centerY + radius * math.sin(0));

    for (int i = 1; i < 2 * nPoints; i++) {
      final r = i.isOdd ? innerRadius : radius;
      final x = centerX + r * math.cos(i * angle);
      final y = centerY + r * math.sin(i * angle);
      path.lineTo(x, y);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Main (add for completeness)
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poster Creator',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PosterTemplate(
        isCustom: true,
        customSize: PosterSize(
          title: 'Instagram Post',
          size: '1080x1080px',
          width: 1080,
          height: 1080,
        ),
      ),
    );
  }
}
