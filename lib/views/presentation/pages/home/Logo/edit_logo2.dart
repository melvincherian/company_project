import 'package:flutter/material.dart';

class EditLogotwo extends StatelessWidget {
  const EditLogotwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Top Row
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Icon(Icons.layers),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 84, 61, 231),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              // Center Image
              Expanded(
                child: Center(
                  child: Image.network(
                      'https://s3-alpha-sig.figma.com/img/749a/63d6/9697825d9370d3aa37338c6f45d73082?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=mFNw~oFq2My~ihdJhfvWb8GCWkTTzACoj6tA8dmFUfU7-59sEAFf-IIv6z7HDwUwSjXM34kQ9e-5-OR4b5L9xS2ll~1a5a-qU8bgvMxqbdSK01qm1ddjaIK0oPAX4JWFKCdv8jOIxS2Rh6ibUh9Fc7pJg~KlRdADVS6CNaA05ddCFTGxHDHlY~WdcakYhVi--rdIZ8z~H7k-9BX6ntzBD-cOCQ-Xc0QWz6hIBVRneKzkUZ5DmmFrLIkclljxNijLsHpOCOYH5-wODw8eDpzWEAOO~LaHmyKGRrTNtulGndSk-z~R4vm1LGe6eBDpIJTmWijTPu1-Z3eiF~wq0lKZuQ__'),
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom menu
      bottomNavigationBar: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _BottomMenuItem(icon: Icons.text_fields, label: 'Text'),
            _BottomMenuItem(icon: Icons.work, label: 'Brand Info'),
            _BottomMenuItem(icon: Icons.change_history, label: 'Shapes'),
            _BottomMenuItem(icon: Icons.image, label: 'Elements'),
          ],
        ),
      ),
    );
  }
}

// Custom widget for bottom item
class _BottomMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BottomMenuItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
