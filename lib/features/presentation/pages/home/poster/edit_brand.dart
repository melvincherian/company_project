import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditBrand extends StatelessWidget {
  const EditBrand({super.key});

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
                        _buildImagePicker("Upload Logo"),
                        _buildImagePicker("Extra Elements"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildTextField("Business Name"),
                    _buildTextField("Mobile Number",
                        maxLength: 20,
                        keyboardType: TextInputType.phone,
                        initialValue: "76597587565"),
                    _buildTextField("Address",
                        maxLength: 20, initialValue: "KJNAK JNAN KXAJNX"),
                    _buildTextField("Email"),
                    _buildTextField("Website"),
                    _buildTextField("Products & Services"),
                    _buildTextField("Tagline"),
                    const SizedBox(height: 20),
                    const Text(
                      "Select Social Media Icons to Highlight \non Post",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFF8C52FF),
                          child: FaIcon(FontAwesomeIcons.facebook,
                              size: 23, color: Colors.white),
                        ),
                        CircleAvatar(
                          backgroundColor: Color(0xFF8C52FF),
                          child: FaIcon(FontAwesomeIcons.instagram,
                              size: 23, color: Colors.white),
                        ),
                        CircleAvatar(
                          backgroundColor: Color(0xFF8C52FF),
                          child: FaIcon(FontAwesomeIcons.whatsapp,
                              size: 23, color: Colors.white),
                        ),
                        CircleAvatar(
                          backgroundColor: Color(0xFF8C52FF),
                          child: FaIcon(FontAwesomeIcons.youtube,
                              size: 23, color: Colors.white),
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          
                          children: [
                           
                            CircleAvatar(
                              backgroundColor: Color(0xFF8C52FF),
                              child: FaIcon(FontAwesomeIcons.linkedin,
                                  size: 23, color: Colors.white),
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            CircleAvatar(
                              backgroundColor: Color(0xFF8C52FF),
                              child: FaIcon(FontAwesomeIcons.xTwitter,
                                  size: 23, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
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
                        onPressed: () {},
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

  Widget _buildImagePicker(String label) {
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
              ),
              child: const Icon(Icons.image, size: 40, color: Colors.grey),
            ),
            Positioned(
              bottom: 0,
              right: 0,
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
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        initialValue: initialValue,
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
}
