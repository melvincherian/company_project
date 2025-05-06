// import 'dart:convert';
// import 'dart:io';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:path/path.dart' as path;

// class BrandDataModel {
//   final File? logoImage;
//   final File? extraElementImage;
//   final String businessName;
//   final String mobileNumber;
//   final String address;
//   final String email;
//   final String website;
//   final List<String> selectedSocialMedia;

//   BrandDataModel({
//     required this.logoImage,
//     required this.extraElementImage,
//     required this.businessName,
//     required this.mobileNumber,
//     required this.address,
//     required this.email,
//     required this.website,
//     required this.selectedSocialMedia,
//   });

//   static const _prefsKey = 'brandData';

//   Map<String, dynamic> toJson() => {
//         'logoImagePath': logoImage?.path,
//         'extraElementImagePath': extraElementImage?.path,
//         'businessName': businessName,
//         'mobileNumber': mobileNumber,
//         'address': address,
//         'email': email,
//         'website': website,
//         'selectedSocialMedia': selectedSocialMedia,
//       };

//   static Future<BrandDataModel?> loadFromPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getString(_prefsKey);
//     if (data == null) return null;

//     final jsonData = jsonDecode(data);

//     File? _loadFile(String? filePath) {
//       if (filePath == null) return null;
//       final file = File(filePath);
//       return file.existsSync() ? file : null;
//     }

//     return BrandDataModel(
//       logoImage: _loadFile(jsonData['logoImagePath']),
//       extraElementImage: _loadFile(jsonData['extraElementImagePath']),
//       businessName: jsonData['businessName'] ?? '',
//       mobileNumber: jsonData['mobileNumber'] ?? '',
//       address: jsonData['address'] ?? '',
//       email: jsonData['email'] ?? '',
//       website: jsonData['website'] ?? '',
//       selectedSocialMedia:
//           List<String>.from(jsonData['selectedSocialMedia'] ?? []),
//     );
//   }

//   Future<void> saveToPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_prefsKey, jsonEncode(toJson()));
//   }
// }







import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class BrandDataModel {
  final File? logoImage;
  final File? extraElementImage;
  final String businessName;
  final String mobileNumber;
  final String address;
  final String email;
  final String website;

  BrandDataModel({
    this.logoImage,
    this.extraElementImage,
    required this.businessName,
    required this.mobileNumber,
    required this.address,
    required this.email,
    required this.website,
  });

  // Convert model to JSON map
  Map<String, dynamic> toJson() => {
        'logoImage': logoImage?.path,
        'extraElementImage': extraElementImage?.path,
        'businessName': businessName,
        'mobileNumber': mobileNumber,
        'address': address,
        'email': email,
        'website': website,
       
      };

  // Create model from JSON map
  factory BrandDataModel.fromJson(Map<String, dynamic> json) {
    return BrandDataModel(
      logoImage: json['logoImage'] != null ? File(json['logoImage']) : null,
      extraElementImage:
          json['extraElementImage'] != null ? File(json['extraElementImage']) : null,
      businessName: json['businessName'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      website: json['website'] ?? '',
    
    );
  }

  // Save to SharedPreferences
  Future<void> saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(toJson());
    await prefs.setString('brand_data', jsonString);
  }

  // Load from SharedPreferences
  static Future<BrandDataModel?> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('brand_data');
    if (jsonString == null) return null;

    final jsonData = jsonDecode(jsonString);
    return BrandDataModel.fromJson(jsonData);
  }
}
