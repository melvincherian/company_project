// import 'package:company_project/views/presentation/pages/home/poster/upload_image.dart';
// import 'package:flutter/material.dart';

// class AddImage extends StatelessWidget {
//   const AddImage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       icon: Icon(Icons.arrow_back_ios)),
//                   SizedBox(
//                     width: 210,
//                   ),
//                   Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 51, 68, 196),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: const Icon(Icons.share, color: Colors.white),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 51, 68, 196),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Icon(
//                         Icons.download_sharp,
//                         color: Colors.white,
//                       ))
//                 ],
//               ),
//               const SizedBox(
//                 height: 270,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadImage()));
//                     },
//                     icon: const Icon(Icons.add),
//                   ),
//                 ],
//               ),
//               const Text(
//                 'Add Image',
//                 style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//   type: BottomNavigationBarType.fixed,
//   backgroundColor: Colors.black,
//   selectedItemColor: Colors.white,
//   unselectedItemColor: Colors.white70,
//   selectedFontSize: 14, // Set to a more reasonable size
//   unselectedFontSize: 12, // Optional: keep consistent sizing
//   iconSize: 27,
//   items: <BottomNavigationBarItem>[
//     BottomNavigationBarItem(
//       icon: Icon(Icons.wb_incandescent_outlined),
//       label: 'Filter',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.movie_creation_outlined),
//       label: 'Animation',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.volume_up_outlined),
//       label: 'Audio',
//     ),
//   ],
// ),

//     );
//   }
// }





import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// class AddImage extends StatelessWidget {
//   const AddImage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<String> backgroundImages = List.generate(
//       15,
//       (index) =>
//           'https://via.placeholder.com/400x600/CCCCCC/808080?text=Background${index + 1}',
//     );

//     return Scaffold(
//       appBar: AppBar(title: const Text('Add Background')),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Search backgrounds',
//                       prefixIcon: const Icon(Icons.search),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // Upload from gallery logic
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Upload from gallery')),
//                     );
//                   },
//                   icon: const Icon(Icons.upload),
//                   label: const Text('Upload'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.indigo,
//                     foregroundColor: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.all(16),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 childAspectRatio: 0.75,
//               ),
//               itemCount: backgroundImages.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context, backgroundImages[index]);
//                   },
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.network(
//                       backgroundImages[index],
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



class BackGroundImage extends StatefulWidget {
  const BackGroundImage({super.key});

  @override
  State<BackGroundImage> createState() => _BackGroundImageState();
}

class _BackGroundImageState extends State<BackGroundImage> {
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  void _showPickOptionsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pick from gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPickOptionsDialog(context),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: _imageFile != null
            ? BoxDecoration(
                image: DecorationImage(
                  image: FileImage(_imageFile!),
                  fit: BoxFit.cover,
                ),
              )
            : const BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  image: NetworkImage(''), 
                  fit: BoxFit.cover,
                ),
              ),
        child: const Center(
          child: Text(
            'Select from where you want to pick up',
            style: TextStyle(color: Colors.black, fontSize: 18,),
          ),
        ),
      ),
    );
  }
}
