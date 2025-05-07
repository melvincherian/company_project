import 'package:flutter/material.dart';

class RemoveBackgroundPremium extends StatelessWidget {
  const RemoveBackgroundPremium({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.amber[700],
        title: const Text(
          "Unlock access to\nUnlimited Premium & Trendy\nBranding Posts & Videos",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 120,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Features section
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "What you'll get with this Premium?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _featureCard("2Lac+", "Event Posters", Icons.event_note),
                _featureCard(
                    "2000+", "WhatsApp Stickers", Icons.emoji_emotions),
                _featureCard("1000+", "Audio Jingles", Icons.music_note),
              ],
            ),

            // Premium Plans section
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Premium Plans",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: Wrap(
                spacing: 12,
                runSpacing: 16,
                children: [
                  _planCard(
                    title: "Yearly Limited Plan",
                    price: "₹2247",
                    oldPrice: "₹3247",
                    save: "₹1000",
                    validity: "Validity: 1 Year",
                    bgColor: Colors.red[700],
                  ),
                  _planCard(
                    title: "Brand Booster Plan",
                    price: "₹3497",
                    oldPrice: "₹4997",
                    save: "₹1500",
                    validity: "Validity: 12 Months",
                    bgColor: Colors.blue[800],
                    // isRecommended: true,
                  ),
                  _planCard(
                    title: "Quarterly Plan",
                    price: "₹897",
                    oldPrice: "₹1247",
                    save: "₹350",
                    validity: "Validity: 3 Months",
                    bgColor: Colors.red[700],
                  ),
                  _planCard(
                    title: "Mega Booster Plan",
                    price: "₹9997",
                    oldPrice: "₹14997",
                    save: "₹5000",
                    validity: "Validity: Lifetime",
                    bgColor: Colors.blue[800],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureCard(String count, String title, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.amber[200],
          child: Icon(icon, color: Colors.black),
        ),
        const SizedBox(height: 4),
        Text(count, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(title, textAlign: TextAlign.center),
      ],
    );
  }

  Widget _planCard({
    required String title,
    required String price,
    required String oldPrice,
    required String save,
    required String validity,
    required Color? bgColor,
    // bool isRecommended = false,
  }) {
    return Stack(
      children: [
        Container(
          width: 170,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor?.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                oldPrice,
                style: const TextStyle(
                  color: Colors.white70,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Text(
                price,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text("Save: $save", style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 4),
              Text(validity, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
        // if (isRecommended)
        //   Positioned(
        //     top: -8,
        //     right: -8,
        //     child: Container(
        //       padding:
        //           const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
        //       decoration: BoxDecoration(
        //         color: Colors.yellow[700],
        //         borderRadius: BorderRadius.circular(8),
        //       ),
        //       child: const Text(
        //         "Recommended",
        //         style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        //       ),
        //     ),
        //   )
      ],
    );
  }
}
