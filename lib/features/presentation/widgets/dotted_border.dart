import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

Widget DottedBorderDecoration() {
  return DottedBorder(
    borderType: BorderType.RRect,
    radius: const Radius.circular(16),
    dashPattern: [8, 4],
    color: Colors.orange,
    strokeWidth: 1.5,
    child: const SizedBox(
      height: 140,
      width: 140,
    ),
  );
}
