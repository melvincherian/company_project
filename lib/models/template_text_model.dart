import 'package:flutter/material.dart';

class TemplateTextItem {
  final String text;
  final Offset position;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final Color bgColor;
  final AnimationTypr? animationType;
  
  TemplateTextItem({
    required this.text,
    required this.position,
    required this.fontSize,
    required this.fontWeight,
    required this.textColor,
    this.bgColor = Colors.transparent,
    this.animationType,
  });
}

mixin AnimationTypr {
}