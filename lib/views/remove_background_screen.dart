import 'package:company_project/views/remove_background_premium.dart';
import 'package:flutter/material.dart';

class RemoveBackgroundScreen extends StatefulWidget {
  const RemoveBackgroundScreen({Key? key}) : super(key: key);

  @override
  State<RemoveBackgroundScreen> createState() => _RemoveBackgroundScreenState();
}

class _RemoveBackgroundScreenState extends State<RemoveBackgroundScreen> {
  int _selectedCredits = 10;

  final List<Map<String, dynamic>> creditPlans = [
    {"credits": 1000, "price": 1500},
    {"credits": 500, "price": 1000},
    {"credits": 100, "price": 250},
    {"credits": 25, "price": 100},
    {"credits": 10, "price": 50},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text(
          'Buy BG-Removal Credits',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.yellow[700],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Icon(Icons.shopping_cart),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const RemoveBackgroundPremium()));
                  },
                  child: Text(
                    "Buy Now",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Promo Banner
          Stack(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage('assets/assets/1641620950s-background-removing-landing-page-banner-design.jpg'), // Replace with your asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text("Credit left: 2"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              "**Background Removal Credits are valid for lifetime",
              style: TextStyle(color: Colors.blue, fontSize: 12),
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            "Background Removal Credits plans",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // Credit Plans
          ...creditPlans.map((plan) {
            return RadioListTile(
              title: Text("${plan['credits']} Credits"),
              value: plan['credits'],
              groupValue: _selectedCredits,
              onChanged: (value) {
                setState(() {
                  _selectedCredits = value as int;
                });
              },
              secondary: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "₹ ${plan['price']}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
