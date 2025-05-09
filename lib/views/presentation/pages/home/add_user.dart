// import 'package:flutter/material.dart';

// class PlanDetails extends StatelessWidget {
//   const PlanDetails({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
                        
//                       },
//                       icon: const Icon(Icons.arrow_back_ios),
//                     ),
//                     const Text(
//                       'How to Use',
//                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 _buildVideoItem(),
//                 const SizedBox(height: 12),
//                 _buildVideoItem(),
//                 const SizedBox(height: 12),
//                 _buildVideoItem(highlighted: true), 
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildVideoItem({bool highlighted = false}) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         border: highlighted
//             ? Border.all(color: Colors.blue, width: 2)
//             : Border.all(color: Colors.grey.shade300),
//         color: Colors.grey.shade200,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 AspectRatio(
//                   aspectRatio: 16 / 9,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: Colors.grey.shade400, 
//                       image: const DecorationImage(
                        
//                         image:NetworkImage('https://static.vecteezy.com/system/resources/thumbnails/031/704/768/small_2x/bright-glowing-animation-of-an-equalizer-with-sound-waves-of-particles-visualization-of-recording-and-playback-of-sound-voice-music-spectrum-waveform-audio-waveform-visualization-video.jpg'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const Icon(
//                   Icons.play_circle_filled,
//                   color: Colors.white,
//                   size: 48,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'How the app will work!',
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class PlanDetails extends StatelessWidget {
  const PlanDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text("How to Use",style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "🖼️ Poster Making Application – Overview\n",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "What is this App?\n",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "The Poster Making App is a simple and powerful tool designed to help users create personalized greeting posters for special occasions like birthdays and anniversaries. Whether you're a business wanting to send client wishes or an individual crafting messages for friends and family, this app makes it fast and easy.\n",
              ),
              SizedBox(height: 10),
              Text(
                "🎯 Key Features\n",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text("• ✅ Add & manage customer details"),
              Text("• 🎂 Select from birthday and anniversary templates"),
              Text("• ✍️ Customize messages with editable captions"),
              Text("• 🖼️ Choose and change templates with a tap"),
              Text("• 💾 Save messages using SharedPreferences"),
              Text("• 📤 Import customer data (planned feature)\n"),
              SizedBox(height: 10),
              Text(
                "👨‍🏫 How to Use the App\n",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text("1. Add Customer Details\n   Tap on “Add Customer Details” to input name, date of birth, or anniversary."),
              Text("2. Select a Template\n   Choose between templates with or without images."),
              Text("3. Customize Your Caption\n   Type a custom message and hit Save."),
              Text("4. Change Templates\n   Tap “Change Template” to browse and select a new one."),
              Text("5. Preview or Share\n   (Optional feature to be added): Download or share the final poster.\n"),
              SizedBox(height: 10),
              Text(
                "🛠️ Technology Stack\n",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text("• Flutter for UI"),
              Text("• SharedPreferences for local storage"),
              Text("• Image.network to load templates"),
              Text("• Navigation & Routing for screen transitions"),
            ],
          ),
        ),
      ),
    );
  }
}
