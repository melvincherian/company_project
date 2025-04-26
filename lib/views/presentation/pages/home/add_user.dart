import 'package:flutter/material.dart';

class PlanDetails extends StatelessWidget {
  const PlanDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ReferEarnScreen()));
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    const Text(
                      'How to Use',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildVideoItem(),
                const SizedBox(height: 12),
                _buildVideoItem(),
                const SizedBox(height: 12),
                _buildVideoItem(highlighted: true), 
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoItem({bool highlighted = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: highlighted
            ? Border.all(color: Colors.blue, width: 2)
            : Border.all(color: Colors.grey.shade300),
        color: Colors.grey.shade200,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade400, 
                      image: const DecorationImage(
                        
                        image:NetworkImage('https://static.vecteezy.com/system/resources/thumbnails/031/704/768/small_2x/bright-glowing-animation-of-an-equalizer-with-sound-waves-of-particles-visualization-of-recording-and-playback-of-sound-voice-music-spectrum-waveform-audio-waveform-visualization-video.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Icon(
                  Icons.play_circle_filled,
                  color: Colors.white,
                  size: 48,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'How the app will work!',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}