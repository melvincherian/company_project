// import 'package:flutter/material.dart';

// class AddElementScreen extends StatelessWidget {
//   const AddElementScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3, // Number of tabs
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: const Icon(Icons.arrow_back_ios),
//           ),
//           title: const Text(
//             'Elements',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           elevation: 0,
//           bottom: const TabBar(
//             indicatorColor: Color(0xFF7F56D9),
//             labelColor: Color(0xFF7F56D9),
//             unselectedLabelColor: Colors.black,
//             labelStyle: TextStyle(fontWeight: FontWeight.w500),
//             tabs: [
//               Tab(text: 'Pick Your Own'),
//               Tab(text: 'Footer Icons'),
//               Tab(text: 'Extra Elements'),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             ElementPickerTab(),
//             FooterIconsTab(),
//             ExtraElementsTab(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ElementPickerTab extends StatelessWidget {
//   const ElementPickerTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('Image',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               _dottedOption(icon: Icons.photo_library, label: 'Gallery'),
//               const SizedBox(width: 12),
//               _dottedOption(icon: Icons.camera_alt, label: 'Camera'),
//             ],
//           ),
//           const SizedBox(height: 16),
//           const Divider(),
//           const Text('Video',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               _dottedOption(icon: Icons.video_library, label: 'Gallery'),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget _dottedOption({required IconData icon, required String label}) {
//     return Container(
//       width: 100,
//       height: 100,
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.black,
//           style: BorderStyle.solid,
//           width: 1,
//         ),
//         borderRadius: BorderRadius.circular(12),
//         shape: BoxShape.rectangle,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const CircleAvatar(
//             backgroundColor: Color(0xFF7F56D9),
//             radius: 20,
//             child: Icon(Icons.photo, color: Colors.white),
//           ),
//           const SizedBox(height: 8),
//           Text(label),
//         ],
//       ),
//     );
//   }
// }

// class FooterIconsTab extends StatelessWidget {
//   const FooterIconsTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GridView.count(
//         crossAxisCount: 6, 
//         shrinkWrap:
//             true, 
//         physics:
//             const NeverScrollableScrollPhysics(), 
//         children: const <Widget>[
       

//           IconWidget(
//               iconUrl:
//                   'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/WhatsApp.svg/2048px-WhatsApp.svg.png'),
//           IconWidget(
//               iconUrl:
//                   'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Instagram_logo_2016.svg/2048px-Instagram_logo_2016.svg.png'),
//           IconWidget(
//               iconUrl:
//                   'https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Telegram_logo.svg/2048px-Telegram_logo.svg.png'),
//           IconWidget(
//               iconUrl:
//                   'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/YouTube_full-color_icon_%282017%29.svg/2560px-YouTube_full-color_icon_%282017%29.svg.png'),
//           IconWidget(
//               iconUrl:
//                   'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/LinkedIn_logo_initials.png/600px-LinkedIn_logo_initials.png'),
//           IconWidget(
//               iconUrl:
//                   'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Instagram_logo_2016.svg/2048px-Instagram_logo_2016.svg.png'),
//           IconWidget(
//               iconUrl:
//                   'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Logo_of_Twitter.svg/512px-Logo_of_Twitter.svg.png'),
//           IconWidget(
//               iconUrl:
//                   'https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Telegram_logo.svg/2048px-Telegram_logo.svg.png'),
       
//           IconWidget(
//               iconUrl:
//                   'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Facebook_icon_2013.svg/1024px-Facebook_icon_2013.svg.png'),
//           IconWidget(
//               iconUrl:
//                   'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Logo_of_Twitter.svg/512px-Logo_of_Twitter.svg.png'),
//           IconWidget(
//               iconUrl:
//                   'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/LinkedIn_logo_initials.png/600px-LinkedIn_logo_initials.png'),
//           IconWidget(
//               iconUrl:
//                   'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/YouTube_full-color_icon_%282017%29.svg/2560px-YouTube_full-color_icon_%282017%29.svg.png'),
         
       
//           IconWidget(
//               iconUrl:
//                   'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/WhatsApp.svg/2048px-WhatsApp.svg.png'),
//           IconWidget(
//               iconUrl:
//                   'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Instagram_logo_2016.svg/2048px-Instagram_logo_2016.svg.png'),
//         ],
//       ),
//     );
//   }
// }

// class IconWidget extends StatelessWidget {
//   final String iconUrl;

//   const IconWidget({super.key, required this.iconUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Image.network(
//         iconUrl,
//         height: 30,
//         width: 30,
//         fit: BoxFit.contain,
//       ),
//     );
//   }
// }

// class ExtraElementsTab extends StatelessWidget {
//   const ExtraElementsTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(child: Text('Extra Elements content here'));
//   }
// }






import 'package:flutter/material.dart';

class AddElementScreen extends StatelessWidget {
  const AddElementScreen({super.key});

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
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Add Element')),
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
