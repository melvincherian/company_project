// ignore_for_file: unused_local_variable

import 'package:company_project/views/presentation/pages/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key});

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  bool _agreeToTerms = false;

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms & Conditions'),
        content: const Text('Please agree to the terms and conditions before continuing.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
          const Center(
            child: Text(
              'Create Your Own Posters',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontFamily: 'poppins'),
            ),
          ),
          Positioned(
            top: 100,
            right: 20,
            left: 20,
            child: Container(
              width: 150,
              height: 240,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Colors.black)),
            ),
          ),
          Positioned(
            top: 101,
            right: 19,
            left: 19,
            child: Container(
              width: 150,
              height: 239,
              decoration: BoxDecoration(
                  color: const Color(0xFFFFCE00),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(120),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  border: Border.all(width: 2, color: Colors.black)),
            ),
          ),
          Positioned(
              top: 110,
              left: 100,
              child: Lottie.asset('assets/lottie/lottie1.json', width: 210))
        ],
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 150,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (bool? value) {
                      setState(() {
                        _agreeToTerms = value ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      ' Agree to Terms & Conditions',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFCE00), Color(0xFF997C00)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10)),
                child: GestureDetector(
                  onTap: () {
                    if (_agreeToTerms) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()));
                    } else {
                      _showAlertDialog(context);
                    }
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
