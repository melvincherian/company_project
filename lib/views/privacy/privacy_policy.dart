import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SelectableText(
              '''
📅 **Effective Date:** [Insert Date]

Thank you for using our Poster Making App. Your privacy is important to us. This Privacy Policy explains how we collect, use, disclose, and protect your personal information.

---

🔍 **1. Information We Collect**
We may collect:
- **Personal Information:** Name, email address, and contact info.
- **Device Information:** Model, OS version, unique identifiers, crash logs.
- **Poster Data:** Designs you create and save.

---

🛠 **2. How We Use Your Information**
- To operate and maintain app functionality.
- To personalize and enhance your experience.
- To improve performance and fix issues.
- To communicate updates and support (with your consent).

---

🔄 **3. Data Sharing**
Your data is never sold or rented. It may be shared:
- With trusted service providers for functionality.
- As required by law or to protect our rights.

---

🔐 **4. Data Security**
We use industry-standard security practices to protect your data.

---

📦 **5. Third-Party Services**
Our app may integrate with:
- **Google Analytics**
- **Firebase**

These services may collect certain data. Review their privacy policies for details.

---

✅ **6. Your Rights**
You have the right to:
- Access/update your data.
- Request deletion.
- Withdraw consent anytime.

---

👶 **7. Children’s Privacy**
Our app is not intended for children under 13. We do not knowingly collect their data.

---

📢 **8. Policy Updates**
We may update this policy. Changes will appear in the app with the effective date.

---

📞 **9. Contact Us**
If you have any questions, contact us at:

**Pixelmindsolution**  
✉️ Email: pixelmind@gmail.com  
📞 Phone: 123456789

---

By using our app, you agree to this Privacy Policy.
              ''',
              style: TextStyle(fontSize: 15.0, height: 1.7),
            ),
          ),
        ),
      ),
    );
  }
}
