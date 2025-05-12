import 'package:flutter/material.dart';

class AutoProductScreen extends StatefulWidget {
  const AutoProductScreen({super.key});

  @override
  State<AutoProductScreen> createState() => _AutoProductScreenState();
}

class _AutoProductScreenState extends State<AutoProductScreen> {
   bool _visible = false;

     
     @override
  void initState() {
    super.initState();
    // Delay the animation slightly
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _visible = true;
      });
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body: Center(
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutBack,
          offset: _visible ? Offset.zero : const Offset(0, 1),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            opacity: _visible ? 1.0 : 0.0,
            child:const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.construction_rounded, size: 100, color: Colors.teal),
                 SizedBox(height: 20),
                 Text(
                  'Coming Soon',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'We\'re working hard to bring this feature to you!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}