import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int selectedIndex = 0;
  final List<String> durations = ['One month', 'Three months', 'One year'];
  final List<int> prices = [299, 299, 299];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subscription",style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                'https://img.freepik.com/free-vector/billboard-advertisement-street-advertising-promo-poster-advantageous-proposition-gift-customer-client-attraction-passerby-cartoon-character_335657-2972.jpg', // Replace with your asset path
                height: 150,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Upgrade to premium',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            const FeaturePoint(text: 'Lorem Ipsum is simply dummy'),
            const FeaturePoint(text: 'Lorem Ipsum is simply dummy'),
            const FeaturePoint(text: 'Lorem Ipsum is simply dummy'),
            const FeaturePoint(text: 'Lorem Ipsum is simply dummy'),
            const SizedBox(height: 20),
            ...List.generate(durations.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedIndex == index ? Colors.blue : Colors.grey.shade300,
                      width: selectedIndex == index ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: selectedIndex == index ? Colors.blue.shade50 : Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(durations[index], style: const TextStyle(fontSize: 16)),
                      Text('₹${prices[index]}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
            }),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Handle subscription confirmation
                },
                child: const Text('Continue', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturePoint extends StatelessWidget {
  final String text;
  const FeaturePoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.black, size: 20),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
