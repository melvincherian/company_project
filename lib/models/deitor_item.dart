import 'package:flutter/material.dart';
import 'dart:math' as math;

class EditorItem {
  final String id;
  Offset position;
  double scale;
  double rotation;
  bool isSelected;

  EditorItem({
    required this.id,
    required this.position,
    this.scale = 1.0,
    this.rotation = 0.0,
    this.isSelected = false,
  });
}

class TextItem extends EditorItem {
  String text;
  Color color;
  double fontSize;
  String fontFamily;
  FontWeight fontWeight;
  TextAlign textAlign;

  TextItem({
    required super.id,
    required super.position,
    required this.text,
    this.color = Colors.black,
    this.fontSize = 20.0,
    this.fontFamily = 'Roboto',
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.center,
    super.scale,
    super.rotation,
    super.isSelected,
  });
}

class StickerItem extends EditorItem {
  final String imageUrl;

  StickerItem({
    required super.id,
    required super.position,
    required this.imageUrl,
    super.scale,
    super.rotation,
    super.isSelected,
  });
}

class ShapeItem extends EditorItem {
  final ShapeType shapeType;
  Color color;
  double width;
  double height;

  ShapeItem({
    required super.id,
    required super.position,
    required this.shapeType,
    this.color = Colors.blue,
    this.width = 100,
    this.height = 100,
    super.scale,
    super.rotation,
    super.isSelected,
  });
}

enum ShapeType { rectangle, circle, triangle, star }
