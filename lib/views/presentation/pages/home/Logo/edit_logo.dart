import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditLogo extends StatefulWidget {
  const EditLogo({super.key});

  @override
  State<EditLogo> createState() => _EditLogoState();
}

class _EditLogoState extends State<EditLogo> {
  File? _backgroundImage;
  final List<_EditableText> _texts = [];

  // Picking image
  Future<void> _pickBackgroundImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _backgroundImage = File(pickedFile.path);
      });
    }
  }

  // Adding text
  void _showAddTextPopup() {
    final TextEditingController _textController = TextEditingController();
    Color selectedColor = Colors.white;

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textController,
                decoration: const InputDecoration(labelText: 'Enter Text'),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _colorPicker(Colors.white, (color) {
                    selectedColor = color;
                  }),
                  _colorPicker(Colors.black, (color) {
                    selectedColor = color;
                  }),
                  _colorPicker(Colors.red, (color) {
                    selectedColor = color;
                  }),
                  _colorPicker(Colors.blue, (color) {
                    selectedColor = color;
                  }),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  if (_textController.text.isNotEmpty) {
                    setState(() {
                      _texts.add(_EditableText(
                        text: _textController.text,
                        color: selectedColor,
                        offset: const Offset(100, 100),
                      ));
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Text'),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _colorPicker(Color color, void Function(Color) onTap) {
    return GestureDetector(
      onTap: () => onTap(color),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Top Row
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Icon(Icons.layers),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 84, 61, 231),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Save',
                      style:
                          TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              // Center Image + Movable Text
              Expanded(
                child: GestureDetector(
                  onTap: _pickBackgroundImage,
                  child: Stack(
                    children: [
                      Center(
                        child: _backgroundImage != null
                            ? Image.file(_backgroundImage!)
                            : Image.network(
                                'https://s3-alpha-sig.figma.com/img/4e71/f25b/9da2a00e2c56e397c0aab306442e3108?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=bXabt491VjIxVWXU4BwFOpRQ0~dptbneilGiT0gLdaKzX1SjMqGtvvfCpkQG~RWVPnkq11fJt8JmQJ5af5eZY3ng~K-gfxAjE117qFSPH-Hms5MkgfGBrDbcWrI3yZCNDM2G4gje4blA-m3jaRn9ZqRM8qobMkHHK5huEGvljuXC5aFsKaZq3VXT82fLc-em0wuVfGsEy~5TtzK5i7AqD7N~jD2ZT3C4xzKbSBXi0OFqwQUIs03A3I0wv7BxDbBq3g50CQs9rVXd77dNpPoAq4KYz2ZzsmyXgUlJhXAmugo4uIOssMg-uxiTATfvprOVsXRMhAfcrcT9XKu9lFpYkA__',
                              ),
                      ),
                      ..._texts.map((editableText) {
                        return Positioned(
                          left: editableText.offset.dx,
                          top: editableText.offset.dy,
                          child: Draggable(
                            feedback: Material(
                              color: Colors.transparent,
                              child: Text(
                                editableText.text,
                                style: TextStyle(
                                  color: editableText.color,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            childWhenDragging: Container(),
                            onDragEnd: (dragDetails) {
                              setState(() {
                                editableText.offset = Offset(
                                  dragDetails.offset.dx -
                                      (MediaQuery.of(context).size.width * 0.05),
                                  dragDetails.offset.dy -
                                      (MediaQuery.of(context).padding.top + 56),
                                );
                              });
                            },
                            child: Text(
                              editableText.text,
                              style: TextStyle(
                                color: editableText.color,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom menu
      bottomNavigationBar: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: _showAddTextPopup,
              child: const _BottomMenuItem(icon: Icons.text_fields, label: 'Text'),
            ),
            const _BottomMenuItem(icon: Icons.work, label: 'Brand Info'),
            const _BottomMenuItem(icon: Icons.change_history, label: 'Shapes'),
            const _BottomMenuItem(icon: Icons.image, label: 'Elements'),
          ],
        ),
      ),
    );
  }
}

// Custom widget for bottom item
class _BottomMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BottomMenuItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}

// Helper class for storing editable texts
class _EditableText {
  String text;
  Color color;
  Offset offset;

  _EditableText({required this.text, required this.color, required this.offset});
}
