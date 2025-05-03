import 'dart:io';
import 'package:company_project/models/brand_data_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
// Import the data model

class EditBrand extends StatefulWidget {
  const EditBrand({super.key});

  @override
  State<EditBrand> createState() => _EditBrandState();
}

class _EditBrandState extends State<EditBrand> {
  File? _logoImage;
  File? _extraElementImage;
  
  // Text controllers for form fields
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController(text: "8051281283");
  final TextEditingController _addressController = TextEditingController(text: "KJNAK JNAN KXAJNX");
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _productsServicesController = TextEditingController();
  final TextEditingController _taglineController = TextEditingController();
  
  // Track selected social media
  final List<String> _selectedSocialMedia = [];
  
  // Social media options with their icons
  final List<Map<String, dynamic>> _socialMediaOptions = [
    {'name': 'facebook', 'icon': FontAwesomeIcons.facebook},
    {'name': 'instagram', 'icon': FontAwesomeIcons.instagram},
    {'name': 'whatsapp', 'icon': FontAwesomeIcons.whatsapp},
    {'name': 'youtube', 'icon': FontAwesomeIcons.youtube},
    {'name': 'linkedin', 'icon': FontAwesomeIcons.linkedin},
    {'name': 'twitter', 'icon': FontAwesomeIcons.xTwitter},
  ];

  @override
  void dispose() {
    // Dispose controllers
    _businessNameController.dispose();
    _mobileNumberController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _productsServicesController.dispose();
    _taglineController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(bool isLogo) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (isLogo) {
          _logoImage = File(pickedFile.path);
        } else {
          _extraElementImage = File(pickedFile.path);
        }
      });
    }
  }

  Widget _buildImagePicker(String label, bool isLogo) {
    File? imageFile = isLogo ? _logoImage : _extraElementImage;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
                image: imageFile != null
                    ? DecorationImage(
                        image: FileImage(imageFile), fit: BoxFit.cover)
                    : null,
              ),
              child: imageFile == null
                  ? const Icon(Icons.image, size: 40, color: Colors.grey)
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => _pickImage(isLogo),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(Icons.camera_alt,
                      size: 18, color: Colors.deepPurple),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildTextField(
    String hint, {
    int maxLength = 100,
    TextInputType keyboardType = TextInputType.text,
    String? initialValue,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          counterText: '',
        ),
      ),
    );
  }

  // Toggle social media selection
  void _toggleSocialMedia(String name) {
    setState(() {
      if (_selectedSocialMedia.contains(name)) {
        _selectedSocialMedia.remove(name);
      } else {
        _selectedSocialMedia.add(name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Upload Your Brand Details",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Add Your Brand Details Which Will Appear on\n Creative Design",
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildImagePicker("Upload Logo", true),
                        _buildImagePicker("Extra Elements", false),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildTextField("Business Name", controller: _businessNameController),
                    _buildTextField("Mobile Number",
                        maxLength: 20,
                        keyboardType: TextInputType.phone,
                        controller: _mobileNumberController),
                    _buildTextField("Address",
                        maxLength: 20,
                        controller: _addressController),
                    _buildTextField("Email", controller: _emailController),
                    _buildTextField("Website", controller: _websiteController),
                    _buildTextField("Products & Services", controller: _productsServicesController),
                    _buildTextField("Tagline", controller: _taglineController),
                    const SizedBox(height: 20),
                    const Text(
                      "Select Social Media Icons to Highlight \non Post",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16,
                      children: _socialMediaOptions.map((social) {
                        final isSelected = _selectedSocialMedia.contains(social['name']);
                        return GestureDetector(
                          onTap: () => _toggleSocialMedia(social['name']),
                          child: CircleAvatar(
                            backgroundColor: isSelected 
                              ? const Color(0xFF8C52FF) 
                              : Colors.grey.shade400,
                            child: FaIcon(
                              social['icon'],
                              size: 23, 
                              color: Colors.white
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6A5AE0), Color(0xFF8C52FF)],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Create brand data object
                          final brandData = BrandData(
                            logoImage: _logoImage,
                            extraElementImage: _extraElementImage,
                            businessName: _businessNameController.text,
                            mobileNumber: _mobileNumberController.text,
                            address: _addressController.text,
                            email: _emailController.text,
                            website: _websiteController.text,
                            productsServices: _productsServicesController.text,
                            tagline: _taglineController.text,
                            selectedSocialMedia: List.from(_selectedSocialMedia),
                          );
                          
                          // Return the brand data to the previous screen
                          Navigator.pop(context, brandData);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Save",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}