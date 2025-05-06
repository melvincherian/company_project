// ignore_for_file: unused_field

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:company_project/views/presentation/pages/home/business/payment_screen.dart';

class AddBusiness extends StatefulWidget {
  const AddBusiness({super.key});

  @override
  State<AddBusiness> createState() => _AddBusinessState();
}

class _AddBusinessState extends State<AddBusiness> {
  final _businessNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _contactController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();

  File? _imageFile;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _loadBusinessData();
  }

  Future<void> _loadBusinessData() async {
    final prefs = await SharedPreferences.getInstance();

    _businessNameController.text = prefs.getString('business_name') ?? '';
    _ownerNameController.text = prefs.getString('owner_name') ?? '';
    _contactController.text = prefs.getString('contact_number') ?? '';
    _whatsappController.text = prefs.getString('whatsapp_number') ?? '';
    _addressController.text = prefs.getString('address') ?? '';
    _emailController.text = prefs.getString('email') ?? '';
    _websiteController.text = prefs.getString('website') ?? '';

    final imageBase64 = prefs.getString('business_image') ?? '';
    if (imageBase64.isNotEmpty) {
      setState(() {
        _imageBytes = base64Decode(imageBase64);
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

    final imageBase64 = _imageBytes != null ? base64Encode(_imageBytes!) : '';

    await prefs.setString('business_name', _businessNameController.text);
    await prefs.setString('owner_name', _ownerNameController.text);
    await prefs.setString('contact_number', _contactController.text);
    await prefs.setString('whatsapp_number', _whatsappController.text);
    await prefs.setString('address', _addressController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('website', _websiteController.text);
    await prefs.setString('business_image', imageBase64);

    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const PaymentScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Business Details',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 74, 71, 248)),
                onPressed: _saveBusinessData,
                child: const Text('Save and Next',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _imageBytes != null
                ? CircleAvatar(
                    radius: 32,
                    backgroundImage: MemoryImage(_imageBytes!),
                  )
                : const CircleAvatar(
                    radius: 32,
                    child: Icon(Icons.camera_alt_outlined),
                  ),
            const SizedBox(height: 8),
            const Text("Logo Name",
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                    child: Text("Don't have brand logo? Choose from library.",
                        style: TextStyle(color: Colors.black54))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
