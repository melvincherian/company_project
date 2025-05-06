// import 'dart:io';
// import 'package:company_project/models/brand_data_model.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// // Import the data model

// class EditBrand extends StatefulWidget {
//   const EditBrand({super.key});

//   @override
//   State<EditBrand> createState() => _EditBrandState();
// }

// class _EditBrandState extends State<EditBrand> {
//   File? _logoImage;
//   File? _extraElementImage;
  
//   // Text controllers for form fields
//   final TextEditingController _businessNameController = TextEditingController();
//   final TextEditingController _mobileNumberController = TextEditingController(text: "8051281283");
//   final TextEditingController _addressController = TextEditingController(text: "KJNAK JNAN KXAJNX");
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _websiteController = TextEditingController();
//   // final TextEditingController _productsServicesController = TextEditingController();
//   // final TextEditingController _taglineController = TextEditingController();
  
//   // Track selected social media
//   final List<String> _selectedSocialMedia = [];
  
//   // Social media options with their icons
//   final List<Map<String, dynamic>> _socialMediaOptions = [
//     {'name': 'facebook', 'icon': FontAwesomeIcons.facebook},
//     {'name': 'instagram', 'icon': FontAwesomeIcons.instagram},
//     {'name': 'whatsapp', 'icon': FontAwesomeIcons.whatsapp},
//     {'name': 'youtube', 'icon': FontAwesomeIcons.youtube},
//     {'name': 'linkedin', 'icon': FontAwesomeIcons.linkedin},
//     {'name': 'twitter', 'icon': FontAwesomeIcons.xTwitter},
//   ];

//   @override
//   void dispose() {
//     // Dispose controllers
//     _businessNameController.dispose();
//     _mobileNumberController.dispose();
//     _addressController.dispose();
//     _emailController.dispose();
//     _websiteController.dispose();
//     // _productsServicesController.dispose();
//     // _taglineController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImage(bool isLogo) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         if (isLogo) {
//           _logoImage = File(pickedFile.path);
//         } else {
//           _extraElementImage = File(pickedFile.path);
//         }
//       });
//     }
//   }

//   Widget _buildImagePicker(String label, bool isLogo) {
//     File? imageFile = isLogo ? _logoImage : _extraElementImage;

//     return Column(
//       children: [
//         Stack(
//           children: [
//             Container(
//               width: 80,
//               height: 80,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade300),
//                 borderRadius: BorderRadius.circular(10),
//                 image: imageFile != null
//                     ? DecorationImage(
//                         image: FileImage(imageFile), fit: BoxFit.cover)
//                     : null,
//               ),
//               child: imageFile == null
//                   ? const Icon(Icons.image, size: 40, color: Colors.grey)
//                   : null,
//             ),
//             Positioned(
//               bottom: 0,
//               right: 0,
//               child: GestureDetector(
//                 onTap: () => _pickImage(isLogo),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                     border: Border.all(color: Colors.grey.shade300),
//                   ),
//                   padding: const EdgeInsets.all(4),
//                   child: const Icon(Icons.camera_alt,
//                       size: 18, color: Colors.deepPurple),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Text(label, style: const TextStyle(fontSize: 12)),
//       ],
//     );
//   }

//   Widget _buildTextField(
//     String hint, {
//     int maxLength = 100,
//     TextInputType keyboardType = TextInputType.text,
//     String? initialValue,
//     TextEditingController? controller,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: TextFormField(
//         controller: controller,
//         maxLength: maxLength,
//         keyboardType: keyboardType,
//         decoration: InputDecoration(
//           labelText: hint,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//           counterText: '',
//         ),
//       ),
//     );
//   }

//   // Toggle social media selection
//   void _toggleSocialMedia(String name) {
//     setState(() {
//       if (_selectedSocialMedia.contains(name)) {
//         _selectedSocialMedia.remove(name);
//       } else {
//         _selectedSocialMedia.add(name);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   children: [
//                     const Text(
//                       "Upload Your Brand Details",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 5),
//                     const Text(
//                       "Add Your Brand Details Which Will Appear on\n Creative Design",
//                       style: TextStyle(fontSize: 12, color: Colors.black87),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         _buildImagePicker("Upload Logo", true),
//                         _buildImagePicker("Extra Elements", false),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     _buildTextField("Business Name", controller: _businessNameController),
//                     _buildTextField("Mobile Number",
//                         maxLength: 20,
//                         keyboardType: TextInputType.phone,
//                         controller: _mobileNumberController),
//                     _buildTextField("Address",
//                         maxLength: 20,
//                         controller: _addressController),
//                     _buildTextField("Email", controller: _emailController),
//                     _buildTextField("Website", controller: _websiteController),
//                     // _buildTextField("Products & Services", controller: _productsServicesController),
//                     // _buildTextField("Tagline", controller: _taglineController),
//                     const SizedBox(height: 20),
//                     const Text(
//                       "Select Social Media Icons to Highlight \non Post",
//                       style:
//                           TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 10),
//                     Wrap(
//                       alignment: WrapAlignment.center,
//                       spacing: 16,
//                       children: _socialMediaOptions.map((social) {
//                         final isSelected = _selectedSocialMedia.contains(social['name']);
//                         return GestureDetector(
//                           onTap: () => _toggleSocialMedia(social['name']),
//                           child: CircleAvatar(
//                             backgroundColor: isSelected 
//                               ? const Color(0xFF8C52FF) 
//                               : Colors.grey.shade400,
//                             child: FaIcon(
//                               social['icon'],
//                               size: 23, 
//                               color: Colors.white
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                     const SizedBox(height: 30),
//                     Container(
//                       width: double.infinity,
//                       height: 48,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF6A5AE0), Color(0xFF8C52FF)],
//                         ),
//                       ),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Create brand data object
//                           final brandData = BrandData(
//                             logoImage: _logoImage,
//                             extraElementImage: _extraElementImage,
//                             businessName: _businessNameController.text,
//                             mobileNumber: _mobileNumberController.text,
//                             address: _addressController.text,
//                             email: _emailController.text,
//                             website: _websiteController.text,
//                             // productsServices: _productsServicesController.text,
//                             // tagline: _taglineController.text,
//                             selectedSocialMedia: List.from(_selectedSocialMedia),
//                           );
                          
//                           // Return the brand data to the previous screen
//                           Navigator.pop(context, brandData);
//                         },
//                         style: ElevatedButton.styleFrom(
//                           elevation: 0,
//                           backgroundColor: Colors.transparent,
//                           shadowColor: Colors.transparent,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Text("Save",
//                             style:
//                                 TextStyle(fontSize: 16, color: Colors.white)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }







import 'dart:io';
import 'package:company_project/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

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
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  
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
  void initState() {
    super.initState();
    _loadSavedBrandData();
  }

  Future<void> _loadSavedBrandData() async {
    final savedData = await BrandDataModel.loadFromPrefs();
    if (savedData != null) {
      setState(() {
        _logoImage = savedData.logoImage;
        _extraElementImage = savedData.extraElementImage;
        _businessNameController.text = savedData.businessName;
        _mobileNumberController.text = savedData.mobileNumber;
        _addressController.text = savedData.address;
        _emailController.text = savedData.email;
        _websiteController.text = savedData.website;
        _selectedSocialMedia.clear();
        _selectedSocialMedia.addAll(savedData.selectedSocialMedia);
      });
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    _businessNameController.dispose();
    _mobileNumberController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
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
                        onPressed: () async {
                          // Create brand data object
                          final brandData = BrandDataModel(
                            logoImage: _logoImage,
                            extraElementImage: _extraElementImage,
                            businessName: _businessNameController.text,
                            mobileNumber: _mobileNumberController.text,
                            address: _addressController.text,
                            email: _emailController.text,
                            website: _websiteController.text,
                            selectedSocialMedia: List.from(_selectedSocialMedia),
                          );
                          
                          // Save to shared preferences
                          await brandData.saveToPrefs();

                           ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("Brand info saved successfully"),
                              duration: Duration(seconds: 2),
                            ),
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







// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class EditBrandScreen extends StatefulWidget {
//   const EditBrandScreen({super.key});

//   @override
//   State<EditBrandScreen> createState() => _EditBrandScreenState();
// }

// class _EditBrandScreenState extends State<EditBrandScreen> {
//   File? _logoImage;
//   File? _extraElementImage;
//   final TextEditingController _businessNameController = TextEditingController();
//   final TextEditingController _mobileNumberController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _websiteController = TextEditingController();

//   final List<String> _socialMediaOptions = ['Instagram', 'WhatsApp', 'Facebook', 'LinkedIn'];
//   final List<String> _selectedSocialMedia = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadSavedData();
//   }

//   Future<void> _loadSavedData() async {
//     final prefs = await SharedPreferences.getInstance();
//     _businessNameController.text = prefs.getString('businessName') ?? '';
//     _mobileNumberController.text = prefs.getString('mobileNumber') ?? '';
//     _addressController.text = prefs.getString('address') ?? '';
//     _emailController.text = prefs.getString('email') ?? '';
//     _websiteController.text = prefs.getString('website') ?? '';
//     _selectedSocialMedia.addAll(json.decode(prefs.getString('socialMedia') ?? '[]').cast<String>());

//     final logoPath = prefs.getString('logoImage');
//     final extraPath = prefs.getString('extraElementImage');
//     if (logoPath != null) _logoImage = File(logoPath);
//     if (extraPath != null) _extraElementImage = File(extraPath);
//     setState(() {});
//   }

//   Future<void> _pickImage(bool isLogo) async {
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       setState(() {
//         if (isLogo) {
//           _logoImage = File(picked.path);
//         } else {
//           _extraElementImage = File(picked.path);
//         }
//       });
//     }
//   }

//   Future<void> _saveData() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('businessName', _businessNameController.text);
//     await prefs.setString('mobileNumber', _mobileNumberController.text);
//     await prefs.setString('address', _addressController.text);
//     await prefs.setString('email', _emailController.text);
//     await prefs.setString('website', _websiteController.text);
//     await prefs.setString('socialMedia', json.encode(_selectedSocialMedia));
//     if (_logoImage != null) await prefs.setString('logoImage', _logoImage!.path);
//     if (_extraElementImage != null) await prefs.setString('extraElementImage', _extraElementImage!.path);

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         backgroundColor: Colors.green,
//         content: Text('Brand data saved successfully')),
//     );
//   }

//   Widget _buildImageUpload(String label, File? image, bool isLogo) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 8),
//         GestureDetector(
//           onTap: () => _pickImage(isLogo),
//           child: Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               color: Colors.grey[100],
//             ),
//             child: image != null
//                 ? Image.file(image, fit: BoxFit.cover)
//                 : const Icon(Icons.add_a_photo),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTextField(String label, TextEditingController controller, {TextInputType? inputType}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 6),
//         TextField(
//           controller: controller,
//           keyboardType: inputType,
//           decoration: const InputDecoration(
//             border: OutlineInputBorder(),
//             isDense: true,
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget _buildCheckbox(String label) {
//     return CheckboxListTile(
//       title: Text(label),
//       value: _selectedSocialMedia.contains(label),
//       onChanged: (bool? value) {
//         setState(() {
//           if (value == true) {
//             _selectedSocialMedia.add(label);
//           } else {
//             _selectedSocialMedia.remove(label);
//           }
//         });
//       },
//       controlAffinity: ListTileControlAffinity.leading,
//     );
//   }

//   @override
//   void dispose() {
//     _businessNameController.dispose();
//     _mobileNumberController.dispose();
//     _addressController.dispose();
//     _emailController.dispose();
//     _websiteController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Brand',style: TextStyle(fontWeight: FontWeight.bold),)),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildImageUpload('Upload Logo', _logoImage, true),
//                 const SizedBox(width: 20),
//                 _buildImageUpload('Upload Extra Element', _extraElementImage, false),
//               ],
//             ),
//             const SizedBox(height: 20),
//             _buildTextField("Business Name", _businessNameController),
//             _buildTextField("Mobile Number", _mobileNumberController, inputType: TextInputType.phone),
//             _buildTextField("Address", _addressController),
//             _buildTextField("Email", _emailController, inputType: TextInputType.emailAddress),
//             _buildTextField("Website", _websiteController),
//             const Text("Social Media", style: TextStyle(fontWeight: FontWeight.bold)),
//             ..._socialMediaOptions.map(_buildCheckbox).toList(),
//             const SizedBox(height: 24),
//             Center(
//               child: ElevatedButton(
//                 onPressed: _saveData,
//                 child: const Text('Save'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
