import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _whatsappController = TextEditingController();
  final _nameController = TextEditingController();
  final _dobDayController = TextEditingController();
  final _dobMonthController = TextEditingController();
  final _annivDayController = TextEditingController();
  final _annivMonthController = TextEditingController();

  File? _imageFile;

  @override
  void initState() {
    super.initState();
    loadCustomerData();
  }

  @override
  void dispose() {
    _whatsappController.dispose();
    _nameController.dispose();
    _dobDayController.dispose();
    _dobMonthController.dispose();
    _annivDayController.dispose();
    _annivMonthController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 75);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context,
      TextEditingController dayCtrl, TextEditingController monthCtrl) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      dayCtrl.text = picked.day.toString().padLeft(2, '0');
      monthCtrl.text = picked.month.toString().padLeft(2, '0');
    }
  }

  Future<void> saveCustomerData() async {
    final prefs = await SharedPreferences.getInstance();

    final whatsappNumber = _whatsappController.text.trim();
    final name = _nameController.text.trim();
    final birthDate =
        "${_dobDayController.text.padLeft(2, '0')}-${_dobMonthController.text.padLeft(2, '0')}";
    final anniversaryDate =
        "${_annivDayController.text.padLeft(2, '0')}-${_annivMonthController.text.padLeft(2, '0')}";

    String? imagePath;
    if (_imageFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = _imageFile!.path.split('/').last;
      final savedImage = await _imageFile!.copy('${appDir.path}/$fileName');
      imagePath = savedImage.path;
    }

    await prefs.setString('whatsapp', whatsappNumber);
    await prefs.setString('name', name);
    await prefs.setString('birthdate', birthDate);
    await prefs.setString('anniversary', anniversaryDate);
    if (imagePath != null) {
      await prefs.setString('profile_image', imagePath);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Customer data saved Successfully")),
    );
  }

  Future<void> loadCustomerData() async {
    final prefs = await SharedPreferences.getInstance();

    _whatsappController.text = prefs.getString('whatsapp') ?? '';
    _nameController.text = prefs.getString('name') ?? '';

    final birthDate = prefs.getString('birthdate') ?? '';
    if (birthDate.contains('-')) {
      final parts = birthDate.split('-');
      if (parts.length == 2) {
        _dobDayController.text = parts[0];
        _dobMonthController.text = parts[1];
      }
    }

    final anniversaryDate = prefs.getString('anniversary') ?? '';
    if (anniversaryDate.contains('-')) {
      final parts = anniversaryDate.split('-');
      if (parts.length == 2) {
        _annivDayController.text = parts[0];
        _annivMonthController.text = parts[1];
      }
    }

    final imagePath = prefs.getString('profile_image');
    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() {
        _imageFile = File(imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Customer',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _whatsappController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'WhatsApp Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            _buildDateRow(
                'BirthDate', _dobDayController, _dobMonthController),
            const SizedBox(height: 16),
            _buildDateRow(
                'Anniversary Date', _annivDayController, _annivMonthController),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _pickImage,
              child: DottedBorderContainer(imageFile: _imageFile),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700],
                foregroundColor: Colors.black,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                saveCustomerData();
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRow(String label, TextEditingController dayCtrl,
      TextEditingController monthCtrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: dayCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'DD'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: monthCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'MM'),
              ),
            ),
            const SizedBox(width: 12),
            InkWell(
              onTap: () {
                _selectDate(context, dayCtrl, monthCtrl);
              },
              child: const Icon(Icons.calendar_today, size: 24),
            ),
          ],
        ),
      ],
    );
  }
}

class DottedBorderContainer extends StatelessWidget {
  final File? imageFile;
  const DottedBorderContainer({super.key, this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: imageFile != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(imageFile!, fit: BoxFit.cover))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.cloud_upload, size: 30, color: Colors.grey),
                SizedBox(height: 8),
                Text("Upload Profile Photo",
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
    );
  }
}
