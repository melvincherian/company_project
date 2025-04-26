import 'package:company_project/views/presentation/pages/home/main_category.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ScreenOtp extends StatefulWidget {
  const ScreenOtp({super.key});

  @override
  _ScreenOtpState createState() => _ScreenOtpState();
}

class _ScreenOtpState extends State<ScreenOtp> {
  String enteredPin = ''; // Variable to store entered PIN

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 228, 228),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -screenHeight * 0.4,
            left: -screenWidth * 0.48,
            child: Container(
              width: screenWidth * 2,
              height: screenWidth * 2,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFCE00),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.10,
            left: screenWidth * 0.15,
            child: Image.network(
              'https://img.freepik.com/free-vector/cyber-security-shield-with-smart-phone_78370-3595.jpg?semt=ais_hybrid&w=740',
              width: screenWidth * 0.7,
              height: screenHeight * 0.4,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: -15,
            child: Container(
              height: screenHeight * 0.42,
              width: screenWidth,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 243, 243, 243),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(60),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'OTP verification',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'We have sent a verification code to\n99999999 to help keep your account\nsecure. Enter it below to log in.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: PinCodeTextField(
                          appContext: context,
                          length: 4,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            fieldHeight: screenHeight * 0.08,
                            fieldWidth: screenWidth * 0.1,
                            activeColor: Colors.grey,
                            inactiveColor: Colors.grey,
                            selectedColor: Colors.black,
                          ),
                          animationDuration: const Duration(milliseconds: 300),
                          onChanged: (value) {
                            setState(() {
                              enteredPin = value; 
                            });
                          },
                          onCompleted: (value) {
                            if (value == '1234') { 
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BusinessIndustryScreen(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Invalid OTP')),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => const NavbarScreen()),
                          // );
                        },
                        child: const Text(
                          "Resend OTP",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
