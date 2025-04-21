import 'package:company_project/features/presentation/pages/home/home_screen.dart';
import 'package:company_project/features/presentation/pages/home/navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ScreenOtp extends StatelessWidget {
  const ScreenOtp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 228, 228),
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

          // Image
          Positioned(
            top: 110,
            left: 55,
            child: Image.network(
              'https://img.freepik.com/free-vector/cyber-security-shield-with-smart-phone_78370-3595.jpg?semt=ais_hybrid&w=740',
              width: 300,
              height: 300,
            ),
          ),

          Positioned(
            bottom: -15,
            child: Container(
              height: 350,
              width: 410,
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
                            fieldHeight: 70,
                            fieldWidth: 40,
                            activeColor: Colors.grey,
                            inactiveColor: Colors.grey,
                            selectedColor: Colors.black,
                          ),
                          animationDuration: const Duration(milliseconds: 300),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>NavbarScreen()));
                        },
                        child: Text(
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
