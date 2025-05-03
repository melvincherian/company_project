import 'dart:io';
import 'package:company_project/views/presentation/pages/home/Logo/brand_info_screen.dart';
import 'package:company_project/views/presentation/pages/home/Logo/edit_logo2.dart';
import 'package:company_project/views/presentation/pages/home/Logo/element_screen.dart';
import 'package:company_project/views/presentation/pages/home/Logo/shape_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math' as math;

class EditLogo extends StatefulWidget {
  const EditLogo({super.key});

  @override
  State<EditLogo> createState() => _EditLogoState();
}

class _EditLogoState extends State<EditLogo> {
  File? _backgroundImage;
  final List<_EditableText> _texts = [];
  final List<_EditableShape> _shapes = [];
  final List<_EditableElement> _elements = []; // Add elements list

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
  void _addShapes(ShapeType shapeType) {
    setState(() {
      _shapes.add(_EditableShape(
        shapeType: shapeType,
        color: Colors.orange,
        size: const Size(80, 80),
        offset: const Offset(100, 100),
      ));
    });
  }

  // Adding an element to the editor
  void _addElement(IconData icon, String name) {
    setState(() {
      _elements.add(_EditableElement(
        icon: icon,
        name: name,
        color: Colors.indigo,
        size: 60.0,
        offset: const Offset(100, 100),
      ));
    });
  }

  // Method to handle element editing
  void _showEditElementPopup(_EditableElement editableElement) {
    Color selectedColor = editableElement.color;
    double selectedSize = editableElement.size;

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
                  Text('Edit ${editableElement.name}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  
                  // Color selection
                  const Text('Color:'),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _colorPicker(Colors.indigo, (color) {
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
                    max: 120,
                    divisions: 10,
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
                        editableElement.color = selectedColor;
                        editableElement.size = selectedSize;
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
                    onPressed: () {
                      // Save logic here
                    },
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

              // Center Image + Movable Text + Movable Shapes + Movable Elements
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

                      // Render elements
                      ..._elements.map((editableElement) {
                        return Positioned(
                          left: editableElement.offset.dx,
                          top: editableElement.offset.dy,
                          child: GestureDetector(
                            onTap: () {
                              _showEditElementPopup(editableElement);
                            },
                            child: Draggable(
                              feedback: Material(
                                color: Colors.transparent,
                                child: Icon(
                                  editableElement.icon,
                                  size: editableElement.size,
                                  color: editableElement.color,
                                ),
                              ),
                              childWhenDragging: Container(),
                              onDragEnd: (dragDetails) {
                                setState(() {
                                  editableElement.offset = Offset(
                                    dragDetails.offset.dx -
                                        (MediaQuery.of(context).size.width * 0.05),
                                    dragDetails.offset.dy -
                                        (MediaQuery.of(context).padding.top + 56),
                                  );
                                });
                              },
                              child: Icon(
                                editableElement.icon,
                                size: editableElement.size,
                                color: editableElement.color,
                              ),
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
                        
                        // _addShapes(shapeType);
                      },
                    ),
                  ),
                );
              },
              child: const _BottomMenuItem(icon: Icons.category, label: 'Shapes')),
            GestureDetector(
              onTap: () {
                // Navigate to ElementScreen and handle the returned element
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ElementScreen()
                  ),
                ).then((selectedElement) {
                  if (selectedElement != null) {
                    // Add selected element to the canvas
                    _addElement(
                      selectedElement['icon'],
                      selectedElement['name']
                    );
                  }
                });
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

// Helper class for storing editable shapes (existing)
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

// Helper class for storing editable elements (new)
class _EditableElement {
  IconData icon;
  String name;
  Color color;
  double size;
  Offset offset;

  _EditableElement({
    required this.icon,
    required this.name,
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