import 'package:company_project/helper/storage_helper.dart';
import 'package:company_project/views/presentation/pages/auth/register_screen.dart';
import 'package:company_project/views/presentation/pages/home/navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:company_project/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    // Give splash screen time to display
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;
    
    // Initialize the auth provider
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.initialize();
    
    // Check if user is logged in
    final isLoggedIn = await AuthPreferences.isLoggedIn();
    
    if (!mounted) return;
    
    // Navigate to appropriate screen
    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>  const NavbarScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const RegisterScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png', // Make sure to add this asset to your pubspec.yaml
              width: 150,
              height: 150,
             
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFFCE00),
                  ),
                  child: const Icon(
                    Icons.store,
                    size: 80,
                    color: Colors.black,
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFCE00)),
            ),
          ],
        ),
      ),
    );
  }
}