import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -300,
              left: -185,
              child: Container(
                width: 790,
                height: 790,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 42, 130, 45),
                ),
              )
              ),
             Positioned(
            top: 100,
            right: 20,
            left: 20,
            child: Container(
              width: 150,
              height: 240,
              decoration: BoxDecoration(
                  // color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Colors.black)),
            ),
          ),

          ],
        )
    );
  }
}