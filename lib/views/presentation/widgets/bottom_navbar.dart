import 'package:flutter/material.dart';

class BottomNavbaritem extends StatelessWidget {
  final IconData icon;
  final String label;

  const BottomNavbaritem({
    super.key,
    required this.icon,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}