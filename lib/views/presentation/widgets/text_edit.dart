// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// // Add these dependencies to your pubspec.yaml:
// // flutter_quill: ^4.0.0  # An older version that has fewer conflicts
// // flutter_colorpicker: ^1.0.3

// class ModernTextEditor extends StatefulWidget {
//   final Function(String text, Map<String, dynamic> styleData) onTextAdded;

//   const ModernTextEditor({
//     Key? key,
//     required this.onTextAdded,
//   }) : super(key: key);

//   @override
//   State<ModernTextEditor> createState() => _ModernTextEditorState();
// }

// class _ModernTextEditorState extends State<ModernTextEditor> {
//   final TextEditingController _textController = TextEditingController();
  
//   Color selectedColor = Colors.black;
//   double fontSize = 20;
//   String fontFamily = 'Roboto';
//   FontWeight fontWeight = FontWeight.normal;
//   FontStyle fontStyle = FontStyle.normal;
//   TextDecoration textDecoration = TextDecoration.none;
//   TextAlign textAlign = TextAlign.left;

//   // List of available font families
//   final List<String> fontFamilies = [
//     'Roboto',
//     'Poppins',
//     'Montserrat',
//     'Lato',
//     'Open Sans',
//     'Playfair Display',
//     'Oswald',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(
//         top: 20,
//         left: 20,
//         right: 20,
//         bottom: MediaQuery.of(context).viewInsets.bottom + 20,
//       ),
//       height: MediaQuery.of(context).size.height * 0.85,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Text Editor',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.close),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
          
//           // Text Input Field
//           Container(
//             height: 120,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey.shade300),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: TextField(
//               controller: _textController,
//               maxLines: null,
//               expands: true,
//               decoration: const InputDecoration(
//                 hintText: 'Enter your text here...',
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.all(12),
//               ),
//               style: TextStyle(
//                 fontFamily: fontFamily,
//                 fontSize: fontSize,
//                 color: selectedColor,
//                 fontWeight: fontWeight,
//                 fontStyle: fontStyle,
//                 decoration: textDecoration,
//               ),
//               textAlign: textAlign,
//             ),
//           ),
          
//           const SizedBox(height: 16),
          
//           // Formatting Toolbar
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 _buildToolbarButton(
//                   icon: Icons.format_bold,
//                   isSelected: fontWeight == FontWeight.bold,
//                   onPressed: () {
//                     setState(() {
//                       fontWeight = fontWeight == FontWeight.bold
//                           ? FontWeight.normal
//                           : FontWeight.bold;
//                     });
//                   },
//                 ),
//                 _buildToolbarButton(
//                   icon: Icons.format_italic,
//                   isSelected: fontStyle == FontStyle.italic,
//                   onPressed: () {
//                     setState(() {
//                       fontStyle = fontStyle == FontStyle.italic
//                           ? FontStyle.normal
//                           : FontStyle.italic;
//                     });
//                   },
//                 ),
//                 _buildToolbarButton(
//                   icon: Icons.format_underline,
//                   isSelected: textDecoration == TextDecoration.underline,
//                   onPressed: () {
//                     setState(() {
//                       textDecoration = textDecoration == TextDecoration.underline
//                           ? TextDecoration.none
//                           : TextDecoration.underline;
//                     });
//                   },
//                 ),
//                 const SizedBox(width: 8),
//                 const VerticalDivider(thickness: 1),
//                 const SizedBox(width: 8),
//                 _buildToolbarButton(
//                   icon: Icons.format_align_left,
//                   isSelected: textAlign == TextAlign.left,
//                   onPressed: () {
//                     setState(() {
//                       textAlign = TextAlign.left;
//                     });
//                   },
//                 ),
//                 _buildToolbarButton(
//                   icon: Icons.format_align_center,
//                   isSelected: textAlign == TextAlign.center,
//                   onPressed: () {
//                     setState(() {
//                       textAlign = TextAlign.center;
//                     });
//                   },
//                 ),
//                 _buildToolbarButton(
//                   icon: Icons.format_align_right,
//                   isSelected: textAlign == TextAlign.right,
//                   onPressed: () {
//                     setState(() {
//                       textAlign = TextAlign.right;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
          
//           const SizedBox(height: 16),
          
//           // Font Size Controls
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Font Size:',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.remove_circle_outline),
//                     onPressed: () {
//                       if (fontSize > 12) {
//                         setState(() {
//                           fontSize -= 1;
//                         });
//                       }
//                     },
//                   ),
//                   Text(
//                     fontSize.toInt().toString(),
//                     style: const TextStyle(fontWeight: FontWeight.w500),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.add_circle_outline),
//                     onPressed: () {
//                       if (fontSize < 72) {
//                         setState(() {
//                           fontSize += 1;
//                         });
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
          
//           const SizedBox(height: 16),
          
//           // Color Picker
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Text Color:',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   _showColorPicker(context);
//                 },
//                 child: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: selectedColor,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.grey.shade300),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.2),
//                         spreadRadius: 1,
//                         blurRadius: 2,
//                         offset: const Offset(0, 1),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Icon(
//                       Icons.color_lens,
//                       color: selectedColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
//                       size: 20,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
          
//           const SizedBox(height: 16),
          
//           // Font Family Selector
//           const Text(
//             'Font Family:',
//             style: TextStyle(fontWeight: FontWeight.w500),
//           ),
//           const SizedBox(height: 8),
//           SizedBox(
//             height: 60,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: fontFamilies.length,
//               itemBuilder: (context, index) {
//                 final family = fontFamilies[index];
//                 return Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         fontFamily = family;
//                       });
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                       decoration: BoxDecoration(
//                         color: fontFamily == family ? Colors.blue.shade100 : Colors.grey.shade200,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           color: fontFamily == family ? Colors.blue : Colors.grey.shade300,
//                         ),
//                       ),
//                       child: Text(
//                         family,
//                         style: TextStyle(
//                           fontFamily: family,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
          
//           const Spacer(),
          
//           // Preview Text
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade100,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Preview:',
//                   style: TextStyle(fontWeight: FontWeight.w500),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   _textController.text.isEmpty ? 'Sample Text' : _textController.text,
//                   style: TextStyle(
//                     fontFamily: fontFamily,
//                     fontSize: fontSize,
//                     color: selectedColor,
//                     fontWeight: fontWeight,
//                     fontStyle: fontStyle,
//                     decoration: textDecoration,
//                   ),
//                   textAlign: textAlign,
//                 ),
//               ],
//             ),
//           ),
          
//           const SizedBox(height: 16),
          
//           // Add Text Button
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onPressed: () {
//                 final text = _textController.text.trim();
//                 if (text.isNotEmpty) {
//                   // Pass text and style as separate elements
//                   final styleData = {
//                     'fontFamily': fontFamily,
//                     'fontSize': fontSize,
//                     'color': selectedColor.value,
//                     'fontWeight': fontWeight.index,
//                     'fontStyle': fontStyle.index,
//                     'decoration': textDecoration.index,
//                     'textAlign': textAlign.index,
//                   };
                  
//                   widget.onTextAdded(text, styleData);
//                   Navigator.pop(context);
//                 }
//               },
//               child: const Text('Add Text', style: TextStyle(fontSize: 16)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildToolbarButton({
//     required IconData icon,
//     required bool isSelected,
//     required VoidCallback onPressed,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//       child: InkWell(
//         onTap: onPressed,
//         borderRadius: BorderRadius.circular(4),
//         child: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
//             borderRadius: BorderRadius.circular(4),
//           ),
//           child: Icon(
//             icon,
//             color: isSelected ? Colors.blue : Colors.black54,
//             size: 20,
//           ),
//         ),
//       ),
//     );
//   }

//   void _showColorPicker(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Select Color'),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ColorPicker(
//                   pickerColor: selectedColor,
//                   onColorChanged: (color) {
//                     setState(() {
//                       selectedColor = color;
//                     });
//                   },
//                   pickerAreaHeightPercent: 0.8,
//                   enableAlpha: true,
//                   displayThumbColor: true,
//                   showLabel: true,
//                   paletteType: PaletteType.hsv,
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         decoration: const InputDecoration(
//                           labelText: 'RGB',
//                           border: OutlineInputBorder(),
//                         ),
//                         controller: TextEditingController(
//                           text: 'R:${selectedColor.red} G:${selectedColor.green} B:${selectedColor.blue}',
//                         ),
//                         readOnly: true,
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: TextField(
//                         decoration: const InputDecoration(
//                           labelText: 'Hex',
//                           border: OutlineInputBorder(),
//                         ),
//                         controller: TextEditingController(
//                           text: '#${selectedColor.value.toRadixString(16).substring(2).toUpperCase()}',
//                         ),
//                         readOnly: true,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text('Select'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// // Helper function to show the text editor
// void showModernTextEditor(BuildContext context, Function(String, Map<String, dynamic>) onTextAdded) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) {
//       return ModernTextEditor(onTextAdded: onTextAdded);
//     },
//   );
// }

// // Example usage in your app:
// void _handleAddText() {
//   showModernTextEditor(
//     context,
//     (text, styleData) {
//       // Create a TextStyle from the style data
//       final style = TextStyle(
//         fontFamily: styleData['fontFamily'],
//         fontSize: styleData['fontSize'],
//         color: Color(styleData['color']),
//         fontWeight: FontWeight.values[styleData['fontWeight']],
//         fontStyle: FontStyle.values[styleData['fontStyle']],
//         decoration: TextDecoration.values[styleData['decoration']],
//       );
      
//       // Add the text to your canvas or wherever needed
//       setState(() {
//         textLayers.add(TextLayer(
//           text: text,
//           style: style,
//           position: const Offset(100, 100), // Default position
//           alignment: TextAlign.values[styleData['textAlign']],
//         ));
//       });
//     },
//   );
// }

// // Sample TextLayer class to store text data
// class TextLayer {
//   final String text;
//   final TextStyle style;
//   final Offset position;
//   final TextAlign alignment;

//   TextLayer({
//     required this.text,
//     required this.style,
//     required this.position,
//     required this.alignment,
//   });
// }