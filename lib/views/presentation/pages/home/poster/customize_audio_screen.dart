import 'package:flutter/material.dart';

class CustomAudioScreen extends StatelessWidget {
  const CustomAudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                const Text(
                  'Customized Audio',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Text(
                  'Language:',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 50,
                ),
                Container(
                  width: 230,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton<String>(
                      value: 'Hindi',
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: ['Hindi', 'English', 'Tamil'].map((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                      onChanged: (value) {}),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Select Artist',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return const ArtistCard();
                    })),
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B2DFF), Color(0xFF6C63FF)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Generate Audio And Apply',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class ArtistCard extends StatelessWidget {
  const ArtistCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://s3-alpha-sig.figma.com/img/28af/ccba/2bec79207b4fa4f0c3fab9ac5ce88ab4?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Z809NDvJNNd-iRDp6YTI~4bD2NsWEIoaL8Dq7KhxRF9SRFoiw4Mvadn0CUosj5UEMakeplmjFzdksq-zsKKv8iwCTLnSsIZqVACxlPiEuZi11bP13fvM-km0uE8CgTSzh6gjpV7aCRurqAeen-bdPcpT8lnZi3eaUt2EwKHhMnkBXvAru~8bVUHe1uiYWPNrPMXbG10QXz2VxczmnGpQe1i9J0XJmzCn8KYp5WbAGQ0OI~dzK8xnDOVhyaVXhN5ArPqdZlISDe-KBN1QJ68Mup1WbaPEl8j8Zl3SxbuiAjB4rVdIAAww2SbiuM-OAGcMnHOk1knZPbO21WPec06mcQ__'), // Replace with your asset
            radius: 25,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Manoj kumar",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.play_circle, color: Colors.deepPurple),
                    const SizedBox(width: 4),
                    const Text("00:30"),
                    const SizedBox(width: 65),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF4E5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.cabin, size: 16, color: Colors.orange),
                          SizedBox(width: 6),
                          Text(
                            "Premium",
                            style: TextStyle(color: Colors.orange),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Checkbox(
            value: false,
            onChanged: null,
            checkColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
