import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms & Conditions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              const Text(
                'Effective Date: [Insert Date]',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to our Poster Making App!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'By accessing or using our application, you agree to be bound by the following terms and conditions:',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              
              // Terms Section
              _buildSectionTitle('1. Acceptance of Terms'),
              const Text(
                'By downloading, installing, or using our app, you agree to comply with and be legally bound by these Terms and Conditions.',
                style: TextStyle(fontSize: 14),
              ),
              const Divider(color: Colors.grey, thickness: 1),
              
              _buildSectionTitle('2. Use of the Application'),
              const Text(
                '- You must use the app in accordance with all applicable laws and regulations.\n'
                '- You are solely responsible for the content you create using the app.',
                style: TextStyle(fontSize: 14),
              ),
              const Divider(color: Colors.grey, thickness: 1),
              
              _buildSectionTitle('3. Intellectual Property'),
              const Text(
                '- All trademarks, logos, and content within the app are the property of Pixelmindsolution or its licensors.\n'
                '- You may not reproduce, modify, or distribute any content from the app without permission.',
                style: TextStyle(fontSize: 14),
              ),
              const Divider(color: Colors.grey, thickness: 1),
              
              _buildSectionTitle('4. Prohibited Conduct'),
              const Text(
                'You agree not to:\n'
                '- Misuse the app for illegal purposes.\n'
                '- Upload or share harmful, defamatory, or offensive content.\n'
                '- Attempt to hack, reverse engineer, or exploit any part of the app.',
                style: TextStyle(fontSize: 14),
              ),
              const Divider(color: Colors.grey, thickness: 1),
              
              _buildSectionTitle('5. Third-Party Services'),
              const Text(
                'Our app may use third-party services. We are not responsible for the terms or policies of these external services.',
                style: TextStyle(fontSize: 14),
              ),
              const Divider(color: Colors.grey, thickness: 1),
              
              _buildSectionTitle('6. Termination'),
              const Text(
                'We reserve the right to suspend or terminate your access if you violate these terms.',
                style: TextStyle(fontSize: 14),
              ),
              const Divider(color: Colors.grey, thickness: 1),
              
              _buildSectionTitle('7. Disclaimer'),
              const Text(
                'The app is provided “as is.” We do not guarantee it will be error-free or uninterrupted.',
                style: TextStyle(fontSize: 14),
              ),
              const Divider(color: Colors.grey, thickness: 1),
              
              _buildSectionTitle('8. Changes to Terms'),
              const Text(
                'We may update these terms at any time. Continued use of the app after updates implies acceptance of the revised terms.',
                style: TextStyle(fontSize: 14),
              ),
              const Divider(color: Colors.grey, thickness: 1),
              
              _buildSectionTitle('9. Contact Us'),
              const Text(
                'If you have any questions about these Terms and Conditions, contact us at:\n'
                'Pixelmindsolution\n'
                'Email: pixelmind@gmail.com\n'
                'Phone: 123456789',
                style: TextStyle(fontSize: 14),
              ),
              const Divider(color: Colors.grey, thickness: 1),
              
              const SizedBox(height: 20),
              const Text(
                'By using our app, you acknowledge that you have read, understood, and agreed to these Terms and Conditions.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
