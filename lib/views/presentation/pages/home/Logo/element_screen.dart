import 'package:flutter/material.dart';

class ElementScreen extends StatelessWidget {
  const ElementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> elements = [
  {'name': 'Arrow', 'icon': Icons.arrow_forward},
  {'name': 'Star', 'icon': Icons.star},
  {'name': 'Heart', 'icon': Icons.favorite},
  {'name': 'Speech Bubble', 'icon': Icons.chat_bubble_outline},
  {'name': 'Cloud', 'icon': Icons.cloud},
  {'name': 'Lightning', 'icon': Icons.flash_on},
  {'name': 'Trophy', 'icon': Icons.emoji_events},
  {'name': 'Tag', 'icon': Icons.local_offer},
  {'name': 'Bell', 'icon': Icons.notifications},
  {'name': 'Flag', 'icon': Icons.flag},
  {'name': 'Gift', 'icon': Icons.card_giftcard},
  {'name': 'Location', 'icon': Icons.location_on},

  // New professional icons
  {'name': 'Document', 'icon': Icons.description},
  {'name': 'Calendar', 'icon': Icons.calendar_today},
  {'name': 'User', 'icon': Icons.person},
  {'name': 'Briefcase', 'icon': Icons.work},
  {'name': 'Settings', 'icon': Icons.settings},
  {'name': 'Chart', 'icon': Icons.bar_chart},
  {'name': 'Lock', 'icon': Icons.lock},
  {'name': 'Camera', 'icon': Icons.camera_alt},
  {'name': 'Phone', 'icon': Icons.phone},
  {'name': 'Mail', 'icon': Icons.mail},
  {'name': 'Time', 'icon': Icons.access_time},
  {'name': 'Download', 'icon': Icons.download},
];


    return Scaffold(
      appBar: AppBar(title: const Text('Add Shape', style: TextStyle(fontWeight: FontWeight.bold))),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: elements.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Return the selected element back to EditLogo screen
              Navigator.pop(context, elements[index]);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    elements[index]['icon'],
                    size: 40,
                    color: Colors.indigo,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    elements[index]['name'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}