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

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CreateCustomerProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Customer'),
        
        // backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: mobileController,
              decoration: const InputDecoration(labelText: 'Mobile Number'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: genderController,
              decoration: const InputDecoration(labelText: 'Gender'),
            ),
            TextField(
              controller: dobController,
              decoration: const InputDecoration(labelText: 'DOB (yyyyMMdd)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: anniversaryController,
              decoration: const InputDecoration(labelText: 'Anniversary Date (yyyyMMdd)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
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
              // icon: const Icon(Icons.save),
              label: const Text('Save Changes',style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
