// ignore_for_file: use_build_context_synchronously

import 'package:company_project/providers/auth_provider.dart';
import 'package:company_project/views/birthday_greeting_screen.dart';
import 'package:company_project/views/change_industry_screen.dart';
import 'package:company_project/views/cutomers/add_customers.dart';
import 'package:company_project/views/cutomers/create_invoice_screen.dart';
import 'package:company_project/views/cutomers/subscription_screen.dart';
import 'package:company_project/views/presentation/pages/auth/register_screen.dart';
import 'package:company_project/views/presentation/pages/home/add_user.dart';
import 'package:company_project/views/presentation/pages/home/brand_mall_screen.dart';
import 'package:company_project/views/presentation/pages/home/my_profile.dart';
import 'package:company_project/views/presentation/pages/home/partner_screen.dart';
import 'package:company_project/views/presentation/pages/home/poster/edit_brand.dart';
import 'package:company_project/views/presentation/pages/home/refer_earn_screen.dart';
import 'package:company_project/views/presentation/pages/home/settings_screen.dart';
import 'package:company_project/views/privacy/privacy_policy.dart';
import 'package:company_project/views/privacy/terms_and_conditions.dart';
import 'package:company_project/views/remove_background_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaningDetailsScreen extends StatelessWidget {
  const PlaningDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        automaticallyImplyLeading: false,
      ),
      body: Row(
        children: [
          Container(
            width: 80,
            color: Colors.grey[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BirthdayGreetingScreen()));
                    },
                    child: _iconTile(Icons.cake, "B'day\nGreetings")),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditBrand()));
                    },
                    child: _iconTile(Icons.info, "Brand\nInfo")),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RemoveBackgroundScreen()));
                    },
                    child: _iconTile(Icons.layers_clear, "Remove\nBG")),
                _iconTile(Icons.text_fields, "Caption"),
                _iconTile(Icons.sticky_note_2, "WhatsApp\nSticker"),
                _iconTile(Icons.sticky_note_2, "Auto\nProduct Ad"),
              ],
            ),
          ),

          // Right side content
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  // Plan details
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Plan Details",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _infoText("Login Number:", "+8051281283", color: Colors.blue),
                  const SizedBox(height: 10),
                  _infoText("Current Plan:", "Trail Plan", color: Colors.blue),
                  const SizedBox(height: 10),
                  _infoText("Media Credits:", "100", color: Colors.blue),
                  const SizedBox(height: 10),
                  _infoText("Expires on:", "Lifetime", color: Colors.blue),
                  const Divider(),

                  // Menu options
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PlanDetails()));
                      },
                      child: _menuTile(Icons.help_outline, "How To Use")),
                  const Divider(),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ChangeIndustryScreen()));
                      },
                      child: _menuTile(Icons.business, "Change Industry")),
                  const Divider(),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ReferEarnScreen()));
                      },
                      child: _menuTile(Icons.share, "Refer & Earn")),
                  // const Divider(),
                  // GestureDetector(
                  //     onTap: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => const BrandMallScreen()));
                  //     },
                  //     child: _menuTile(Icons.store, "Brand Mall")),
                  const Divider(),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyProfile()));
                      },
                      child: _menuTile(Icons.person, "Profile")),
                  const Divider(),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingsScreen()));
                      },
                      child: _menuTile(Icons.settings, "Settings")),

                  const Divider(),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddCustomers()));
                      },
                      child: _menuTile(Icons.person_2, "Add Customer")),

                  const Divider(),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SubscriptionScreen()));
                      },
                      child: _menuTile(Icons.subscript, "Subscription")),

                  const Divider(),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CreateInvoiceScreen()));
                      },
                      child: _menuTile(
                          Icons.receipt_long_outlined, "Create Invoice")),

                  const Divider(),
                  _menuTile(Icons.mail, "Contact Us"),
                  const Divider(),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PartnerScreen()));
                      },
                      child: _menuTile(Icons.handshake, "Partner With Us")),
                  const Divider(),
                  _menuTile(Icons.star_rate, "Rate App"),
                  const Divider(),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>const PrivacyPolicy()));
                      },
                      child: _menuTile(Icons.description, "Policies")),
                  const Divider(),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TermsAndConditions()));
                      },
                      child: _menuTile(Icons.policy, "Terms and Conditions")),
                  const Divider(),
                  GestureDetector(
                      onTap: () async {
                        final authProvider =
                            Provider.of<AuthProvider>(context, listen: false);
                        await authProvider.logout();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()),
                          (route) => false,
                        );
                      },
                      child: _menuTile(Icons.logout, "Logout")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconTile(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.blue[100],
            child: Icon(icon, color: Colors.black),
          ),
          const SizedBox(height: 5),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _infoText(String title, String value, {Color color = Colors.black}) {
    return Row(
      children: [
        Text("$title ", style: const TextStyle(fontWeight: FontWeight.w500)),
        Text(value, style: TextStyle(color: color)),
      ],
    );
  }

  Widget _menuTile(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    );
  }
}
