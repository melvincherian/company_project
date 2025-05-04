import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/customer_provider.dart'; // Update this path if needed

class EditCustomerScreen extends StatefulWidget {
  final Map<String, dynamic> customer;

  const EditCustomerScreen({super.key, required this.customer});

  @override
  State<EditCustomerScreen> createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;
  late TextEditingController addressController;
  late TextEditingController genderController;
  late TextEditingController dobController;
  late TextEditingController anniversaryController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.customer['name'] ?? '');
    emailController = TextEditingController(text: widget.customer['email'] ?? '');
    mobileController = TextEditingController(text: widget.customer['mobile'] ?? '');
    addressController = TextEditingController(text: widget.customer['address'] ?? '');
    genderController = TextEditingController(text: widget.customer['gender'] ?? '');
    dobController = TextEditingController(text: widget.customer['dob'] ?? '');
    anniversaryController = TextEditingController(text: widget.customer['anniversaryDate'] ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    addressController.dispose();
    genderController.dispose();
    dobController.dispose();
    anniversaryController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CreateCustomerProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Customer'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: _buildInputDecoration('Name', Icons.person),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: emailController,
                      decoration: _buildInputDecoration('Email', Icons.email),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: mobileController,
                      decoration: _buildInputDecoration('Mobile Number', Icons.phone),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: addressController,
                      decoration: _buildInputDecoration('Address', Icons.location_on),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: genderController,
                      decoration: _buildInputDecoration('Gender', Icons.wc),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: dobController,
                      decoration: _buildInputDecoration('DOB (yyyyMMdd)', Icons.calendar_today),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: anniversaryController,
                      decoration: _buildInputDecoration('Anniversary Date (yyyyMMdd)', Icons.favorite),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await provider.updateCustomer(
                    userId: 'current_user_id', // Replace with actual user ID if dynamic
                    customerId: widget.customer['_id'] ?? '',
                    name: nameController.text,
                    email: emailController.text,
                    mobile: mobileController.text,
                    address: addressController.text,
                    gender: genderController.text,
                    dob: dobController.text,
                    anniversaryDate: anniversaryController.text,
                  );

                  await provider.saveCustomersToPrefs();

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  elevation: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
