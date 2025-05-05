import 'dart:io';

import 'package:company_project/models/template_text_model.dart';
import 'package:flutter/material.dart';

class PosterTemplate {
  final String name;
  final File? backgroundImage;
  final Color? backgroundColor;
  final List<TemplateTextItem> textItems;
  
  PosterTemplate({
    required this.name,
    this.backgroundImage,
    this.backgroundColor,
    required this.textItems,
  });
}