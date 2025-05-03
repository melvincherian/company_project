import 'package:company_project/providers/signup_provider.dart';
import 'package:company_project/models/signup_model.dart';
import 'package:company_project/views/presentation/pages/home/navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _marriageAnniversaryController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _dobController.dispose();
    _marriageAnniversaryController.dispose();
    super.dispose();
  }

  Future<void> _submitSignup() async {
    final signupProvider = Provider.of<SignupProvider>(context, listen: false);

    final signupModel = SignupModel(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      mobile: _mobileController.text.trim(),
      dob: _dobController.text.trim(),
      marriageAnniversary: _marriageAnniversaryController.text.trim(),
      id: ''
    );

    bool success = await signupProvider.registerUser(signupModel);

    if (success) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const NavbarScreen()));
    } else {
      final error = signupProvider.errorMessage ?? "Something went wrong.";
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignupProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Background
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

            Column(
              children: [
                const SizedBox(height: 100),
                Center(
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlWfK18STi6oUn8MLJrtGWVq9h48At_2IRv-jc1fRoEXp8w47fcFokOCHMj1_koYYujhs&usqp=CAU',
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Signup Here!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        // Name
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 20),

                        // Email
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),

                        // Mobile
                        TextField(
                          controller: _mobileController,
                          decoration: InputDecoration(
                            labelText: 'Mobile',
                            prefixIcon: const Icon(Icons.phone),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 20),

                        // DOB
                        TextField(
                            controller: _dobController,
                            decoration: InputDecoration(
                              labelText: 'DOB (YYYY-MM-DD)',
                              prefixIcon: const Icon(Icons.calendar_month),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.number),
                        const SizedBox(height: 20),

                        // Marriage Anniversary
                        TextField(
                          controller: _marriageAnniversaryController,
                          decoration: InputDecoration(
                            labelText: 'Marriage Anniversary (YYYY-MM-DD)',
                            prefixIcon: const Icon(Icons.favorite),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 30),

                        signupProvider.isLoading
                            ? const CircularProgressIndicator()
                            : SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _submitSignup,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
