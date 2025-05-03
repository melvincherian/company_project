import 'dart:io';

import 'package:company_project/views/presentation/pages/home/Logo/brand_info_screen.dart';
import 'package:company_project/views/presentation/pages/home/Logo/element_screen.dart';
import 'package:company_project/views/presentation/pages/home/Logo/shape_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math' as math;

class EditLogotwo extends StatefulWidget {
  const EditLogotwo({super.key});

  @override
  State<EditLogotwo> createState() => _EditLogoState();
}

class _EditLogoState extends State<EditLogotwo> {
  File? _backgroundImage;
  final List<_EditableText> _texts = [];
  final List<_EditableShape> _shapes = []; // Add shapes list

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

  // Adding a shape to the editor
  void _addShape(ShapeType shapeType) {
    setState(() {
      _shapes.add(_EditableShape(
        shapeType: shapeType,
        color: Colors.orange,
        size: const Size(80, 80),
        offset: const Offset(100, 100),
      ));
    });
  }

  void _addElements(){

  }

  // Method to handle shape editing
  void _showEditShapePopup(_EditableShape editableShape) {
    Color selectedColor = editableShape.color;
    double selectedSize = editableShape.size.width;

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Edit Shape', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  
                  // Color selection
                  const Text('Color:'),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _colorPicker(Colors.blue, (color) {
                        setModalState(() => selectedColor = color);
                      }),
                      _colorPicker(Colors.red, (color) {
                        setModalState(() => selectedColor = color);
                      }),
                      _colorPicker(Colors.green, (color) {
                        setModalState(() => selectedColor = color);
                      }),
                      _colorPicker(Colors.orange, (color) {
                        setModalState(() => selectedColor = color);
                      }),
                      _colorPicker(Colors.purple, (color) {
                        setModalState(() => selectedColor = color);
                      }),
                    ],
                  ),
                  
                  // Size slider
                  const SizedBox(height: 16),
                  const Text('Size:'),
                  Slider(
                    value: selectedSize,
                    min: 20,
                    max: 200,
                    divisions: 18,
                    label: selectedSize.round().toString(),
                    onChanged: (value) {
                      setModalState(() {
                        selectedSize = value;
                      });
                    },
                  ),
                  
                  // Save button
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        editableShape.color = selectedColor;
                        editableShape.size = Size(selectedSize, selectedSize);
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Save Changes'),
                  ),
                ],
              ),
            );
          }
        );
      },
    );
  }

  // Text methods remain the same...
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

  void _showEditTextPopup(_EditableText editableText) {
    // Existing implementation...
    final TextEditingController _textController = TextEditingController(text: editableText.text);
    Color selectedColor = editableText.color;

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
                decoration: const InputDecoration(labelText: 'Edit Text'),
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
                   _colorPicker(Colors.teal, (color) {
                    selectedColor = color;
                  }),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  if (_textController.text.isNotEmpty) {
                    setState(() {
                      editableText.text = _textController.text;
                      editableText.color = selectedColor;
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save Changes'),
              ),
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
                  // const Icon(Icons.layers),
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

              // Center Image + Movable Text + Movable Shapes
              Expanded(
                child: GestureDetector(
                  onTap: _pickBackgroundImage,
                  child: Stack(
                    children: [
                      Center(
                        child: _backgroundImage != null
                            ? Image.file(_backgroundImage!)
                            : Image.network(
                                'https://s3-alpha-sig.figma.com/img/749a/63d6/9697825d9370d3aa37338c6f45d73082?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=mFNw~oFq2My~ihdJhfvWb8GCWkTTzACoj6tA8dmFUfU7-59sEAFf-IIv6z7HDwUwSjXM34kQ9e-5-OR4b5L9xS2ll~1a5a-qU8bgvMxqbdSK01qm1ddjaIK0oPAX4JWFKCdv8jOIxS2Rh6ibUh9Fc7pJg~KlRdADVS6CNaA05ddCFTGxHDHlY~WdcakYhVi--rdIZ8z~H7k-9BX6ntzBD-cOCQ-Xc0QWz6hIBVRneKzkUZ5DmmFrLIkclljxNijLsHpOCOYH5-wODw8eDpzWEAOO~LaHmyKGRrTNtulGndSk-z~R4vm1LGe6eBDpIJTmWijTPu1-Z3eiF~wq0lKZuQ__',
                              ),
                      ),
                      
                      // Render shapes
                      ..._shapes.map((editableShape) {
                        return Positioned(
                          left: editableShape.offset.dx,
                          top: editableShape.offset.dy,
                          child: GestureDetector(
                            onTap: () {
                              _showEditShapePopup(editableShape);
                            },
                            child: Draggable(
                              feedback: Material(
                                color: Colors.transparent,
                                child: _buildShapeWidget(editableShape),
                              ),
                              childWhenDragging: Container(),
                              onDragEnd: (dragDetails) {
                                setState(() {
                                  editableShape.offset = Offset(
                                    dragDetails.offset.dx -
                                        (MediaQuery.of(context).size.width * 0.05),
                                    dragDetails.offset.dy -
                                        (MediaQuery.of(context).padding.top + 56),
                                  );
                                });
                              },
                              child: _buildShapeWidget(editableShape),
                            ),
                          ),
                        );
                      }).toList(),
                      
                      // Render texts (existing)
                      ..._texts.map((editableText) {
                        return Positioned(
                          left: editableText.offset.dx,
                          top: editableText.offset.dy,
                          child: GestureDetector(
                            onTap: () {
                              _showEditTextPopup(editableText);
                            },
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
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BrandInfoScreen()));
              },
              child: const _BottomMenuItem(icon: Icons.info, label: 'Brand Info')),
            GestureDetector(
              onTap: () {
                // Updated to navigate to ShapeScreen and handle returning selection
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => ShapeSelectionScreen(
                      onShapeSelected: (shapeType) {
                        _addShape(shapeType);
                      },
                    ),
                  ),
                );
              },
              child: const _BottomMenuItem(icon: Icons.category, label: 'Shapes')),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const ElementScreen()));
              },
              child: const _BottomMenuItem(icon: Icons.extension, label: 'Elements')),
          ],
        ),
      ),
    );
  }
  
  // Helper method to build shape widget based on type
  Widget _buildShapeWidget(_EditableShape shape) {
    final size = shape.size;
    final color = shape.color;
    
    switch (shape.shapeType) {
      case ShapeType.circle:
        return Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        );
      case ShapeType.square:
        return Container(
          width: size.width,
          height: size.height,
          color: color,
        );
      case ShapeType.rectangle:
        return Container(
          width: size.width * 2,
          height: size.height,
          color: color,
        );
      case ShapeType.triangle:
        return SizedBox(
          width: size.width,
          height: size.height,
          child: CustomPaint(
            painter: _TrianglePainter(color: color),
            child: Container(),
          ),
        );
      case ShapeType.star:
        return SizedBox(
          width: size.width,
          height: size.height,
          child: CustomPaint(
            painter: _StarPainter(color: color),
            child: Container(),
          ),
        );
    }
  }
}

// Custom widget for bottom item (existing)
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

// Helper class for storing editable texts (existing)
class _EditableText {
  String text;
  Color color;
  Offset offset;

  _EditableText({required this.text, required this.color, required this.offset});
}

// Helper class for storing editable shapes (new)
class _EditableShape {
  ShapeType shapeType;
  Color color;
  Size size;
  Offset offset;

  _EditableShape({
    required this.shapeType, 
    required this.color, 
    required this.size, 
    required this.offset
  });
}

// Enum for shape types
enum ShapeType {
  circle,
  square,
  rectangle,
  triangle,
  star,
}

// Modified CustomPainters to accept color parameter
class _TrianglePainter extends CustomPainter {
  final Color color;
  
  _TrianglePainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _StarPainter extends CustomPainter {
  final Color color;
  
  _StarPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    final double r = size.width / 2;
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    for (int i = 0; i < 5; i++) {
      double angle = (i * 72) * 3.1415926 / 180;
      double x = cx + r * math.cos(angle);
      double y = cy + r * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// New modified shape selection screen
class ShapeSelectionScreen extends StatelessWidget {
  final Function(ShapeType) onShapeSelected;
  
  const ShapeSelectionScreen({super.key, required this.onShapeSelected});

  @override
  Widget build(BuildContext context) {
    final shapes = [
      ShapeItem('Circle', const CircleShape(), ShapeType.circle),
      ShapeItem('Square', const SquareShape(), ShapeType.square),
      ShapeItem('Rectangle', const RectangleShape(), ShapeType.rectangle),
      ShapeItem('Triangle', const TriangleShape(), ShapeType.triangle),
      ShapeItem('Star', const StarShape(), ShapeType.star),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Select a Shape')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: shapes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final shape = shapes[index];
            return GestureDetector(
              onTap: () {
                // Pass the selected shape back to the editor
                onShapeSelected(shape.shapeType);
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: shape.widget),
                    const SizedBox(height: 4),
                    Text(shape.name),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


class ShapeItem {
  final String name;
  final Widget widget;
  final ShapeType shapeType;

  ShapeItem(this.name, this.widget, this.shapeType);
}