



// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:company_project/providers/story_provider.dart';

// class AddStoryWidget extends StatefulWidget {
//   final String userId;
//   final VoidCallback onStoryAdded;

//   const AddStoryWidget({
//     Key? key,
//     required this.userId,
//     required this.onStoryAdded,
//   }) : super(key: key);

//   @override
//   State<AddStoryWidget> createState() => _AddStoryWidgetState();
// }

// class _AddStoryWidgetState extends State<AddStoryWidget> {
//   File? _imageFile;
//   final TextEditingController _captionController = TextEditingController();
//   bool _isUploading = false;

//   @override
//   void initState() {
//     super.initState();
//     // Check if user already has an active story
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _checkForActiveStory();
//     });
//   }

//   void _checkForActiveStory() {
//     final storyProvider = Provider.of<StoryProvider>(context, listen: false);
//     if (storyProvider.hasActiveStory()) {
//       // Show a dialog and navigate back if user already has a story
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => AlertDialog(
//           title: const Text('Story Already Exists'),
//           content: const Text(
//             'You already have an active story. You can add a new story once your current story expires (after 24 hours).'
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close dialog
//                 Navigator.pop(context); // Go back to previous screen
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _captionController.dispose();
//     super.dispose();
//   }

//   // Function to pick an image from gallery or camera
//   Future<File?> pickImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source, imageQuality: 85);

//     if (pickedFile != null) {
//       return File(pickedFile.path);
//     } else {
//       return null;
//     }
//   }

//   // Show bottom sheet for selecting image source (Gallery or Camera)
//   void _showImageSourceOptions() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => SafeArea(
//         child: Wrap(
//           children: [
//             ListTile(
//               leading: const Icon(Icons.photo_library),
//               title: const Text('Gallery'),
//               onTap: () async {
//                 final pickedFile = await pickImage(ImageSource.gallery);
//                 if (pickedFile != null) {
//                   setState(() {
//                     _imageFile = pickedFile;
//                   });
//                 }
//                 Navigator.pop(context); // Close the bottom sheet
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.camera_alt),
//               title: const Text('Camera'),
//               onTap: () async {
//                 final pickedFile = await pickImage(ImageSource.camera);
//                 if (pickedFile != null) {
//                   setState(() {
//                     _imageFile = pickedFile;
//                   });
//                 }
//                 Navigator.pop(context); // Close the bottom sheet
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Submit the story
//   Future<void> _submitStory() async {
//     if (_imageFile == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select an image')),
//       );
//       return;
//     }

//     setState(() {
//       _isUploading = true;
//     });

//     final storyProvider = Provider.of<StoryProvider>(context, listen: false);
//     final caption = _captionController.text.isEmpty ? 'This is my story!' : _captionController.text;

//     final success = await storyProvider.postStory(_imageFile!, caption, widget.userId);

//     setState(() {
//       _isUploading = false;
//     });

//     if (success) {
//       widget.onStoryAdded();
//       Navigator.pop(context);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(storyProvider.error ?? 'Failed to upload story')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Story'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.check),
//             onPressed: _isUploading ? null : _submitStory,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             GestureDetector(
//               onTap: _showImageSourceOptions,
//               child: Container(
//                 height: 300,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//                 child: _imageFile != null
//                     ? ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.file(
//                           _imageFile!,
//                           fit: BoxFit.cover,
//                         ),
//                       )
//                     : const Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
//                             SizedBox(height: 8),
//                             Text('Tap to add photo'),
//                           ],
//                         ),
//                       ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _captionController,
//               decoration: const InputDecoration(
//                 hintText: 'Add a caption...',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 3,
//             ),
//             const SizedBox(height: 16),
//             if (_isUploading)
//               const Center(
//                 child: CircularProgressIndicator(),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'dart:io';

import 'package:company_project/providers/story_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddStoryScreen extends StatefulWidget {
  final VoidCallback onStoryAdded;

  const AddStoryScreen({
    Key? key,
    required this.onStoryAdded,
  }) : super(key: key);

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  File? _image;
  final TextEditingController _captionController = TextEditingController();
  bool _isUploading = false;

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final storyProvider = Provider.of<StoryProvider>(context, listen: false);
    final pickedFile = await storyProvider.pickImage(source);

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  Future<void> _uploadStory() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh${_image}");
      final storyProvider = Provider.of<StoryProvider>(context, listen: false);
      final success = await storyProvider.postStory(
        _image!,
        _captionController.text.trim(),
      );

      if (success) {
        widget.onStoryAdded();
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(storyProvider.error ?? 'Failed to upload story')),
        );
      }
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Story'),
        actions: [
          if (_image != null)
            TextButton(
              onPressed: _isUploading ? null : _uploadStory,
              child: _isUploading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Share',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
        ],
      ),
      body: Column(
        children: [
          if (_image == null)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Add a photo to your story',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSourceButton(
                          icon: Icons.photo_library,
                          label: 'Gallery',
                          onTap: () => _pickImage(ImageSource.gallery),
                        ),
                        const SizedBox(width: 40),
                        _buildSourceButton(
                          icon: Icons.camera_alt,
                          label: 'Camera',
                          onTap: () => _pickImage(ImageSource.camera),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: Stack(
                children: [
                  // Image preview
                  Positioned.fill(
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Caption input at bottom
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: TextField(
                        controller: _captionController,
                        style: const TextStyle(color: Colors.white),
                        maxLines: 3,
                        minLines: 1,
                        decoration: const InputDecoration(
                          hintText: 'Add a caption...',
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
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

  Widget _buildSourceButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 30,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}