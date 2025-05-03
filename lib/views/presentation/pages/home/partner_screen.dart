// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class PartnerScreen extends StatelessWidget {
  const PartnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width * 0.42;

    return Scaffold(
      appBar: AppBar(
        title:const  Text('Partner With Us',style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPartnerCard(
                  context: context,
                  width: cardWidth,
                  title: 'Join Us As A\nContent Creator',
                  imageUrl: 'https://st4.depositphotos.com/15870672/40068/v/1600/depositphotos_400680060-stock-illustration-cartoon-illustration-two-businessman-shaking.jpg',
                  onContactPressed: () {
                    print('Contact Content Creator');
                  },
                ),
                _buildPartnerCard(
                  context: context,
                  width: cardWidth,
                  title: 'Join Us As A\nProduct Dealer',
                  imageUrl: 'https://media.istockphoto.com/id/1208313447/vector/teamwork-concept-with-building-puzzle-people-working-together-with-giant-puzzle-elements.jpg?s=612x612&w=0&k=20&c=sqwpXzJOmHc0bUHBqRSuzVsj_wdNFl-uoBVjRleWYx0=',
                  onContactPressed: () {
                    print('Contact Product Dealer');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }

  Widget _buildPartnerCard({
    required BuildContext context,
    required double width,
    required String title,
    required String imageUrl,
    required VoidCallback onContactPressed,
  }) {
    return Container(
      width: width,
      height: 280, // Fixed height for all cards
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onContactPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: 3,
              ),
              child: const Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
