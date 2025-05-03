// ignore_for_file: use_super_parameters

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:company_project/providers/story_provider.dart';

class AddStoryWidget extends StatefulWidget {
  final String userId;
  final VoidCallback onStoryAdded;

  const AddStoryWidget({
    Key? key,
    required this.userId,
    required this.onStoryAdded,
  }) : super(key: key);

  @override
  State<AddStoryWidget> createState() => _AddStoryWidgetState();
}

class _AddStoryWidgetState extends State<AddStoryWidget> {
  File? _imageFile;
  final TextEditingController _captionController = TextEditingController();
  bool _isUploading = false;

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  // Function to pick an image from gallery or camera
  Future<File?> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 85);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  // Show bottom sheet for selecting image source (Gallery or Camera)
  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                final pickedFile = await pickImage(ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    _imageFile = pickedFile;
                  });
                }
                Navigator.pop(context); // Close the bottom sheet
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                final pickedFile = await pickImage(ImageSource.camera);
                if (pickedFile != null) {
                  setState(() {
                    _imageFile = pickedFile;
                  });
                }
                Navigator.pop(context); // Close the bottom sheet
              },
            ),
          ],
        ),
      ),
    );
  }

  // Submit the story
  Future<void> _submitStory() async {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    final storyProvider = Provider.of<StoryProvider>(context, listen: false);
    final caption = _captionController.text.isEmpty ? 'This is my story!' : _captionController.text;

    final success = await storyProvider.postStory(_imageFile!, caption, widget.userId);

    setState(() {
      _isUploading = false;
    });

    if (success) {
      widget.onStoryAdded();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(storyProvider.error ?? 'Failed to upload story')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Story'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _isUploading ? null : _submitStory,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _showImageSourceOptions,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: _imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          _imageFile!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                            SizedBox(height: 8),
                            Text('Tap to add photo'),
                          ],
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _captionController,
              decoration: const InputDecoration(
                hintText: 'Add a caption...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            if (_isUploading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
