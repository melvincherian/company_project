
// ignore_for_file: use_build_context_synchronously

import 'package:company_project/controller/auth_controller.dart';
import 'package:company_project/helper/storage_helper.dart';
import 'package:company_project/views/presentation/pages/auth/otp_screen.dart';
import 'package:company_project/views/presentation/pages/auth/signup_screen.dart';
import 'package:company_project/views/presentation/pages/home/navbar_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final phoneController = TextEditingController();
    final AuthController controller = AuthController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
           
            final yellowCircleHeight = constraints.maxHeight * 0.5;
            
            return Stack(
              children: [
               
                Positioned(
                  top: -constraints.maxHeight * 0.4,
                  left: -screenWidth * 0.5,
                  child: Container(
                    width: screenWidth * 2,
                    height: screenWidth * 2,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFCE00),
                    ),
                  ),
                ),
                
                Column(
                  children: [
                    // Image Section - Fixed height with AnimatedContainer for smooth resizing
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: MediaQuery.of(context).viewInsets.bottom > 0 
                          ? yellowCircleHeight * 0.6  // Reduced size when keyboard is open
                          : yellowCircleHeight,
                      child: Center(
                        child: Image.network(
                          'https://img.freepik.com/free-vector/cyber-security-shield-with-smart-phone_78370-3595.jpg?semt=ais_hybrid&w=740',
                          width: screenWidth * 0.8,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 50,),
                    // Lower content area (scrollable for keyboard)
                    Expanded(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        physics: const ClampingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const Text(
                                'Register with Mobile Number',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Phone Input
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color.fromARGB(255, 0, 0, 0),),
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
                                    Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.phone,
                                        decoration: const InputDecoration(
                                          hintText: 'Enter phone number',
                                          border: InputBorder.none,
                                        ),
                                        controller: phoneController,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Continue Button with black border
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final mobile = phoneController.text;
                                    if (mobile.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text("Please enter a mobile number")),
                                      );
                                      return;
                                    }
                                    
                                    // Show loading indicator
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => const Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFCE00)),
                                        ),
                                      ),
                                    );
                                    
                                    final isSuccess = await controller.loginUser(context, mobile);
                                    
                                    Navigator.pop(context);
                                    
                                    if (isSuccess) {
                                      final isVerified = await AuthPreferences.isUserVerified();
                                      
                                      if (isVerified) {
                                   
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(builder: (context) =>const NavbarScreen()),
                                          (route) => false,
                                        );
                                      } else {
                                       
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const ScreenOtp()),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text("Login Failed")),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFCE00),
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(color: Colors.black),
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

                              // Social login section wrapped in Visibility widget
                              // This ensures it stays at the bottom and doesn't move up with keyboard
                              Visibility(
                                // Only show social login section when keyboard is NOT visible
                                visible: MediaQuery.of(context).viewInsets.bottom == 0,
                                maintainSize: false,
                                maintainAnimation: true,
                                maintainState: true,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 30),
                                    const Text(
                                      'Or',
                                      style: TextStyle(fontSize: 16, color: Colors.grey),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                     const Text("Don't Have an account?"),
                                      TextButton(onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignupScreen()));
                                      }, child:const Text('SignUp'))
                                    ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        _buildSocialIcon(
                                          'https://cdn-icons-png.flaticon.com/512/2991/2991148.png',
                                          onPressed: () {},
                                        ),
                                        const SizedBox(width: 16),
                                        _buildSocialIcon(
                                          'https://img.freepik.com/premium-vector/x-new-social-network-black-app-icon-twitter-rebranded-as-x-twitter-s-logo-was-changed_277909-568.jpg?semt=ais_hybrid&w=740',
                                          onPressed: () {},
                                        ),
                                        const SizedBox(width: 16),
                                        _buildSocialIcon(
                                          'https://cdn-icons-png.flaticon.com/512/5968/5968764.png',
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
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