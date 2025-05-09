// ignore_for_file: use_super_parameters

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:company_project/views/remove_background_premium.dart';

class RemoveBackgroundScreen extends StatefulWidget {
  const RemoveBackgroundScreen({Key? key}) : super(key: key);

  @override
  State<RemoveBackgroundScreen> createState() => _RemoveBackgroundScreenState();
}

class _RemoveBackgroundScreenState extends State<RemoveBackgroundScreen> {
  final List<File> _selectedImages = [];

  @override
  void initState() {
    super.initState();
    _loadSavedImages(); // Load saved image paths on startup
  }

  // Load saved image paths from SharedPreferences
  Future<void> _loadSavedImages() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPaths = prefs.getStringList('selected_images') ?? [];
    setState(() {
      _selectedImages.clear();
      _selectedImages.addAll(savedPaths.map((path) => File(path)));
    });
  }

  // Save image paths to SharedPreferences
  Future<void> _saveImagesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final paths = _selectedImages.map((file) => file.path).toList();
    await prefs.setStringList('selected_images', paths);
  }

  // Pick image from gallery and save
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
      await _saveImagesToPrefs(); // Save updated list
    }
  }

  // Remove an image and update storage
  Future<void> _removeImage(int index) async {
    setState(() {
      _selectedImages.removeAt(index);
    });
    await _saveImagesToPrefs(); // Save updated list after deletion
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
          'Buy BG-Removal Credits',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.yellow[700],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_cart),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RemoveBackgroundPremium(),
                      ),
                    );
                  },
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Promo Banner
          Stack(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/assets/1641620950s-background-removing-landing-page-banner-design.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              "**Background Removal Credits are valid for lifetime",
              style: TextStyle(color: Colors.blue, fontSize: 12),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Background Removal Credits plans",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(
            "Your Images",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _selectedImages.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: FileImage(_selectedImages[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.add_photo_alternate),
                      onPressed: _pickImage,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeImage(index),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                "Add Image",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                elevation: 5,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
