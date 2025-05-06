import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:company_project/views/add_customer_screen.dart';

class BirthdayGreetingScreen extends StatefulWidget {
  const BirthdayGreetingScreen({super.key});

  @override
  State<BirthdayGreetingScreen> createState() => _BirthdayGreetingScreenState();
}

class _BirthdayGreetingScreenState extends State<BirthdayGreetingScreen> {
  final TextEditingController _captionController = TextEditingController();
  static const String _captionKey = 'birthday_caption';

  String? selectedImageWithImage;
  String? selectedImageWithoutImage;

  @override
  void initState() {
    super.initState();
    _loadCaption();
  }

  Future<void> _loadCaption() async {
    final prefs = await SharedPreferences.getInstance();
    _captionController.text = prefs.getString(_captionKey) ??
        "We are thinking of you on this important day and we hope success and happiness keeps coming your way. Wishing you many joyous years ahead. Happy Birthday.";
  }

  Future<void> _saveCaption() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_captionKey, _captionController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Caption saved successfully")),
    );
  }

  Future<void> _selectTemplate(bool isWithImage) async {
    final selected = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TemplateSelectionScreen()),
    );
    if (selected != null && mounted) {
      setState(() {
        if (isWithImage) {
          selectedImageWithImage = selected;
        } else {
          selectedImageWithoutImage = selected;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("B'day Anniversary Greetings",
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://media.istockphoto.com/id/1490695895/vector/big-set-of-stickers-with-hand-drawn-birthday-clipart-for-planners-notebooks-ready-for-print.jpg?s=612x612&w=0&k=20&c=xYQaRpgYkX9lDljWGTOZBUDOI7x100c3KHbBbJpOS_I=',
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddCustomerScreen()));
                  },
                  child: _iconCard("Add Customer\nDetails", Icons.person_add),
                ),
              ),
              Expanded(
                child: _iconCard("Import Customer\nDetails", Icons.file_upload),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text("Select Birthday Templates",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _templateCard(
                    "With Images",
                    selectedImageWithImage ??
                        "https://marketplace.canva.com/EAFzUFg0qh4/1/0/1131w/canva-blue-and-red-illustrative-happy-birthday-flyer-_vKLUF1a0i0.jpg",
                    () => _selectTemplate(true)),
              ),
              Expanded(
                child: _templateCard(
                    "Without Images",
                    selectedImageWithoutImage ??
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9mYMh7n4kml5hEMSlfjsNXb6lfJs4bBl9Hw&s",
                    () => _selectTemplate(false)),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text("Birthday Captions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _captionBox(_captionController, _saveCaption, Icons.cake),
          const SizedBox(height: 30),
          const Text("Select Anniversary Templates",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _templateCard(
                    "With Images",
                    selectedImageWithImage ??
                        "https://i.pinimg.com/564x/33/06/1b/33061bdef353e4e344a4f52c90fc56b4.jpg",
                    () => _selectTemplate(true)),
              ),
              Expanded(
                child: _templateCard(
                    "Without Images",
                    selectedImageWithoutImage ??
                        "https://roopvibes.com/wp-content/uploads/2024/06/Happy-anniversary-greetings-card.jpg",
                    () => _selectTemplate(false)),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text("Anniversary Captions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _captionBox(_captionController, _saveCaption, Icons.favorite),
        ],
      ),
    );
  }

  Widget _iconCard(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.black),
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _templateCard(
      String label, String imagePath, VoidCallback onChange) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imagePath, height: 130, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onChange,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
            child: const Text("Change Template",
                style: TextStyle(color: Colors.black)),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _captionBox(
      TextEditingController controller, VoidCallback onSave, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon),
              const SizedBox(width: 10),
              const Text("This message will be sent with your image.",
                  style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            maxLines: 4,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter your message",
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: onSave,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              child:
                  const Text("Save", style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}

class TemplateSelectionScreen extends StatelessWidget {
  final List<String> imageUrls = [
    'https://img.freepik.com/free-photo/happy-birthday-card-with-flowers-assortment_23-2149077342.jpg',
    'https://img.freepik.com/free-photo/happy-birthday-card-with-flowers-assortment_23-2149077342.jpg',
    'https://img.freepik.com/free-photo/happy-birthday-card-with-flowers-assortment_23-2149077342.jpg',
    'https://img.freepik.com/free-photo/happy-birthday-card-with-flowers-assortment_23-2149077342.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Template"),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.pop(context, imageUrls[index]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(imageUrls[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
