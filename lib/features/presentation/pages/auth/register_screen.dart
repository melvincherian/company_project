import 'package:company_project/features/presentation/pages/auth/signup_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
         
          Positioned(
            top: -300,
            left: -185,
            child: Container(
              width: 790,
              height: 790,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFCE00),
              ),
            ),
          ),

         
          Positioned(
            top: 110,
            left: MediaQuery.of(context).size.width / 2 - 150,
            child: Image.network(
              'https://img.freepik.com/free-vector/cyber-security-shield-with-smart-phone_78370-3595.jpg?semt=ais_hybrid&w=740',
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),

          // Title
          Positioned(
            left: 20,
            right: 20,
            bottom: 300,
            child: Text(
              'Register with Mobile Number',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Phone Input Field
          Positioned(
            left: 20,
            right: 20,
            bottom: 230,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  DropdownButton<String>(
                    value: '+91',
                    items: const [
                      DropdownMenuItem(value: '+91', child: Text('🇮🇳 +91')),
                      DropdownMenuItem(value: '+1', child: Text('🇺🇸 +1')),
                      DropdownMenuItem(value: '+44', child: Text('🇬🇧 +44')),
                    ],
                    onChanged: (value) {},
                    underline: const SizedBox(),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Enter phone number',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Continue Button
          Positioned(
            left: 20,
            right: 20,
            bottom: 160,
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFCE00),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
         
          
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: Column(
              children: [
                const Text(
                  'Or',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialIcon(
                        'https://cdn-icons-png.flaticon.com/512/2991/2991148.png',
                        onPressed: () {
                          
                        }),
                    const SizedBox(width: 16),
                    _buildSocialIcon(
                        'https://img.freepik.com/premium-vector/x-new-social-network-black-app-icon-twitter-rebranded-as-x-twitter-s-logo-was-changed_277909-568.jpg?semt=ais_hybrid&w=740',
                        onPressed: () {
                         
                        }),
                    const SizedBox(width: 16),
                    _buildSocialIcon(
                        'https://cdn-icons-png.flaticon.com/512/5968/5968764.png',
                        onPressed: () {
                          
                        }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(String imageUrl, {required VoidCallback onPressed}) {
    return CircleAvatar(
      backgroundColor: const Color.fromARGB(255, 255, 251, 251),
      radius: 25,
      child: IconButton(
        onPressed: onPressed,
        icon: Image.network(
          imageUrl,
          width: 28,
          height: 28,
        ),
      ),
    );
  }
}
