import 'package:company_project/views/presentation/pages/home/my_profile.dart';
import 'package:flutter/material.dart';

class BrandMallScreen extends StatelessWidget {
  const BrandMallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
            // Handle back button press
          },
        ),
        title: const Text(
          'Brand Mall',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: 2, //  two cards
          separatorBuilder: (context, index) => const SizedBox(height: 16), // Space between cards
          itemBuilder: (context, index) {
            return const LogoDesignCard();
          },
        ),
      ),
      backgroundColor: const Color(0xFFf0f4f8), //soft background color
    );
  }
}

class LogoDesignCard extends StatelessWidget {
  const LogoDesignCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 50, 
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFCC80),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0), // Adjust padding as needed
                      child: Image.network(
                        'https://i.pinimg.com/736x/80/b6/c0/80b6c0b23faee9f687399182c0ea750f.jpg', // Replace with your image asset
                        width: 40, // Adjusted size to fit within the circle
                        height: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                const Expanded( //Use expanded to take up available space
                  child:  Text(
                    'Design Your\n Business Logo',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF424242),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Text(
                  '₹1499', // Original price
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '₹999', // Discounted price
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:  Color(0xFFF57C00),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Pack of 3 Concepts',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyProfile()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7E57C2), // Purple button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'View More',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
