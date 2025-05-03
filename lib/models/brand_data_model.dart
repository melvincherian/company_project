// lib/models/brand_data_model.dart

import 'dart:io';

class BrandData {
  final File? logoImage;
  final File? extraElementImage;
  final String? businessName;
  final String? mobileNumber;
  final String? address;
  final String? email;
  final String? website;
  final String? productsServices;
  final String? tagline;
  final List<String> selectedSocialMedia;

  BrandData({
    this.logoImage,
    this.extraElementImage,
    this.businessName,
    this.mobileNumber,
    this.address,
    this.email,
    this.website,
    this.productsServices,
    this.tagline,
    this.selectedSocialMedia = const [],
  });
}