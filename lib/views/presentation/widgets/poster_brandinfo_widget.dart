import 'package:company_project/providers/brand_info_provider.dart';
import 'package:company_project/views/presentation/pages/home/poster/create_poster_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrandInfo extends StatefulWidget {
  @override
  _BrandInfoState createState() => _BrandInfoState();
}

class _BrandInfoState extends State<BrandInfo> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _siteController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<BrandInfoProvider>(context);
    _emailController.text = provider.email;
    _siteController.text = provider.siteName;
    _phoneController.text = provider.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BrandInfoProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Business Information')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Enter your business details to display on the poster'),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _siteController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Website',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final email = _emailController.text;
                  final site = _siteController.text;
                  final phone = _phoneController.text;

                  if (email.isNotEmpty && site.isNotEmpty && phone.isNotEmpty) {
                    await provider.saveUserData(
                      email: email,
                      phone: phone,
                      siteName: site
                    );

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => PosterEditor(
                    //       email: email,
                    //       phoneNumber: phone,
                    //       sitename: site,
                    //     ),
                    //   ),
                    // );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill in all fields')),
                    );
                  }
                },
                child: const Text('Create Poster'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
