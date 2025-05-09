import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class AddUserData extends StatefulWidget {
  const AddUserData({super.key});

  @override
  State<AddUserData> createState() => _AddUserDataState();
}

class _AddUserDataState extends State<AddUserData> {
  final _formKey = GlobalKey<FormState>();
  File? _imageFile;
  final picker = ImagePicker();

  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = basename(pickedFile.path);
      final savedImage =
          await File(pickedFile.path).copy('${directory.path}/$fileName');

      setState(() {
        _imageFile = savedImage;
      });
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('businessName', businessNameController.text);
    await prefs.setString('mobile', mobileController.text);
    await prefs.setString('email', emailController.text);
    if (_imageFile != null) {
      await prefs.setString('imagePath', _imageFile!.path);
    }
  }
  
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    businessNameController.text = prefs.getString('businessName') ?? '';
    mobileController.text = prefs.getString('mobile') ?? '';
    emailController.text = prefs.getString('email') ?? '';
    final imagePath = prefs.getString('imagePath');
    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() {
        _imageFile = File(imagePath);
      });
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderSide:const BorderSide(color: Colors.teal, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon:const Icon(Icons.arrow_back_ios)),
        title: const Text("Add User Data",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: const Color.fromARGB(255, 137, 198, 248),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.teal.shade100,
                  backgroundImage:
                      _imageFile != null ? FileImage(_imageFile!) : null,
                  child: _imageFile == null
                      ? const Icon(Icons.camera_alt, size: 30, color: Colors.teal)
                      : null,
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: businessNameController,
                decoration: _inputDecoration('Business Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter business name' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: mobileController,
                decoration: _inputDecoration('Mobile Number'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter mobile number' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: emailController,
                decoration: _inputDecoration('Email ID'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter email ID' : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveData();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('User data saved successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    }
                  },
                  // icon: const Icon(Icons.save),
                  label: const Text("Save",style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: const Color.fromARGB(255, 137, 198, 248),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
