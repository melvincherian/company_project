// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class PartnerScreen extends StatelessWidget {
  const PartnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partner With Us'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPartnerCard(
                  context: context,
                  title: 'Join Us As A\nContent Creator',
                  image: Image.network(
                    'https://st4.depositphotos.com/15870672/40068/v/1600/depositphotos_400680060-stock-illustration-cartoon-illustration-two-businessman-shaking.jpg', // Replace with your actual asset path
                    height: 70,
                  ),
                  onContactPressed: () {
               
                    print('Contact Content Creator');
                  },
                ),
                _buildPartnerCard(
                  context: context,
                  title: 'Join Us As A\nProduct Dealer',
                  image: Image.network(
                    'https://media.istockphoto.com/id/1208313447/vector/teamwork-concept-with-building-puzzle-people-working-together-with-giant-puzzle-elements.jpg?s=612x612&w=0&k=20&c=sqwpXzJOmHc0bUHBqRSuzVsj_wdNFl-uoBVjRleWYx0=', // Replace with your actual asset path
                    height: 90,
                    width: 90,
                  ),
                  onContactPressed: () {
                    // Handle contact us for product dealer
                    print('Contact Product Dealer');
                  },
                ),
              ],
            ),
            // You can add more rows of partner options here if needed
          ],
        ),
      ),
    );
  }

  Widget _buildPartnerCard({
    required BuildContext context,
    required String title,
    required Widget image,
    required VoidCallback onContactPressed,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10, width: 60, child: image),
          const SizedBox(height: 15),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onContactPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade100,
                foregroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text(
                'Contact Us',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}