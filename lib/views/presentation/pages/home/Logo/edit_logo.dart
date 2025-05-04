import 'dart:io';

import 'package:company_project/views/presentation/pages/home/Logo/element_screen.dart';
import 'package:company_project/views/presentation/pages/home/poster/edit_brand.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math' as math;

class EditLogo extends StatefulWidget {
  const EditLogo({super.key});

  @override
  State<EditLogo> createState() => _EditLogoState();
}

class _EditLogoState extends State<EditLogo> {
  // Replace the single background image with a list of editable images
  final List<_EditableImage> _images = [];
  final List<_EditableText> _texts = [];
  final List<_EditableShape> _shapes = [];
  final List<_EditableElement> _elements = [];

  // Track selected items for deletion
  _EditableText? _selectedText;
  _EditableShape? _selectedShape;
  _EditableElement? _selectedElement;
  _EditableImage? _selectedImage; // Add tracking for selected image

  // Picking image
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        // Add as an editable image at the center of the canvas
        _images.add(_EditableImage(
          imageFile: File(pickedFile.path),
          offset: const Offset(100, 100), // Initial position
          size: const Size(150, 150), // Initial size
        ));
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

  // Adding an element to the editor
  void _addElement(Map<String, dynamic> elementData) {
    setState(() {
      _elements.add(_EditableElement(
        icon: elementData['icon'],
        name: elementData['name'],
        color: Colors.indigo,
        size: const Size(60, 60),
        offset: const Offset(100, 100),
      ));
    });
  }

  // Delete selected item
  void _deleteSelectedItem() {
    setState(() {
      if (_selectedText != null) {
        _texts.remove(_selectedText);
        _selectedText = null;
      }

      if (_selectedShape != null) {
        _shapes.remove(_selectedShape);
        _selectedShape = null;
      }

      if (_selectedElement != null) {
        _elements.remove(_selectedElement);
        _selectedElement = null;
      }

      if (_selectedImage != null) {
        _images.remove(_selectedImage);
        _selectedImage = null;
      }
    });
  }

  // Select or deselect text
  void _selectText(_EditableText text) {
    setState(() {
      if (_selectedText == text) {
        _selectedText = null; // Deselect if tapping the same text
      } else {
        _selectedText = text;
        _selectedShape = null;
        _selectedElement = null;
        _selectedImage = null; // Deselect any selected image
      }
    });
  }

  // Select or deselect shape
  void _selectShape(_EditableShape shape) {
    setState(() {
      if (_selectedShape == shape) {
        _selectedShape = null; // Deselect if tapping the same shape
      } else {
        _selectedShape = shape;
        _selectedText = null;
        _selectedElement = null;
        _selectedImage = null; // Deselect any selected image
      }
    });
  }

  // Select or deselect element
  void _selectElement(_EditableElement element) {
    setState(() {
      if (_selectedElement == element) {
        _selectedElement = null; // Deselect if tapping the same element
      } else {
        _selectedElement = element;
        _selectedText = null;
        _selectedShape = null;
        _selectedImage = null; // Deselect any selected image
      }
    });
  }

  // Select or deselect image
  void _selectImage(_EditableImage image) {
    setState(() {
      if (_selectedImage == image) {
        _selectedImage = null; // Deselect if tapping the same image
      } else {
        _selectedImage = image;
        _selectedText = null;
        _selectedShape = null;
        _selectedElement = null;
      }
    });
  }

  // Deselect all items
  void _deselectAll() {
    setState(() {
      _selectedText = null;
      _selectedShape = null;
      _selectedElement = null;
      _selectedImage = null; // Deselect any selected image
    });
  }

  // Method to handle image editing
  void _showEditImagePopup(_EditableImage editableImage) {
    double selectedSize = editableImage.size.width;

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return StatefulBuilder(builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Edit Image',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),

                // Size slider
                const Text('Size:'),
                Slider(
                  value: selectedSize,
                  min: 50,
                  max: 300,
                  divisions: 25,
                  label: selectedSize.round().toString(),
                  onChanged: (value) {
                    setModalState(() {
                      selectedSize = value;
                    });
                  },
                ),

                // Save and Delete buttons row
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _images.remove(editableImage);
                          _selectedImage = null;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Delete Image'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          editableImage.size = Size(selectedSize, selectedSize);
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Save Changes'),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
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
        return StatefulBuilder(builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Edit Shape',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

                // Save and Delete buttons row
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _shapes.remove(editableShape);
                          _selectedShape = null;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Delete Shape'),
                    ),
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
              ],
            ),
          );
        });
      },
    );
  }

  // Method to handle element editing
  void _showEditElementPopup(_EditableElement editableElement) {
    Color selectedColor = editableElement.color;
    double selectedSize = editableElement.size.width;

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return StatefulBuilder(builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Edit ${editableElement.name}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
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
                    _colorPicker(Colors.indigo, (color) {
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

                // Save and Delete buttons row
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _elements.remove(editableElement);
                          _selectedElement = null;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Delete Element'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          editableElement.color = selectedColor;
                          editableElement.size =
                              Size(selectedSize, selectedSize);
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Save Changes'),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    );
  }

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
    final TextEditingController _textController =
        TextEditingController(text: editableText.text);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _texts.remove(editableText);
                        _selectedText = null;
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Delete Text'),
                  ),
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
                  // Delete button - only visible when something is selected
                  if (_selectedText != null ||
                      _selectedShape != null ||
                      _selectedElement != null ||
                      _selectedImage != null)
                    IconButton(
                      onPressed: _deleteSelectedItem,
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 84, 61, 231),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              // Center Image + Movable Text + Movable Shapes + Movable Elements
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _deselectAll(); // Deselect when tapping background
                  },
                  child: Stack(
                    children: [
                      // Default background (displayed when no image is added)
                      if (_images.isEmpty)
                        Center(
                          child: Image.network(
                            'https://s3-alpha-sig.figma.com/img/4e71/f25b/9da2a00e2c56e397c0aab306442e3108?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=bXabt491VjIxVWXU4BwFOpRQ0~dptbneilGiT0gLdaKzX1SjMqGtvvfCpkQG~RWVPnkq11fJt8JmQJ5af5eZY3ng~K-gfxAjE117qFSPH-Hms5MkgfGBrDbcWrI3yZCNDM2G4gje4blA-m3jaRn9ZqRM8qobMkHHK5huEGvljuXC5aFsKaZq3VXT82fLc-em0wuVfGsEy~5TtzK5i7AqD7N~jD2ZT3C4xzKbSBXi0OFqwQUIs03A3I0wv7BxDbBq3g50CQs9rVXd77dNpPoAq4KYz2ZzsmyXgUlJhXAmugo4uIOssMg-uxiTATfvprOVsXRMhAfcrcT9XKu9lFpYkA__',
                          ),
                        ),

                      // Render movable images
                      ..._images.map((editableImage) {
                        final isSelected = editableImage == _selectedImage;
                        return Positioned(
                          left: editableImage.offset.dx,
                          top: editableImage.offset.dy,
                          child: GestureDetector(
                            onTap: () {
                              _selectImage(editableImage);
                            },
                            onDoubleTap: () {
                              _showEditImagePopup(editableImage);
                            },
                            child: Draggable(
                              feedback: Material(
                                color: Colors.transparent,
                                child: SizedBox(
                                  width: editableImage.size.width,
                                  height: editableImage.size.height,
                                  child: Image.file(
                                    editableImage.imageFile,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              childWhenDragging: Container(),
                              onDragEnd: (dragDetails) {
                                setState(() {
                                  editableImage.offset = Offset(
                                    dragDetails.offset.dx -
                                        (MediaQuery.of(context).size.width * 0.05),
                                    dragDetails.offset.dy -
                                        (MediaQuery.of(context).padding.top + 56),
                                  );
                                });
                              },
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: editableImage.size.width,
                                    height: editableImage.size.height,
                                    child: Image.file(
                                      editableImage.imageFile,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  if (isSelected)
                                    Positioned(
                                      right: -10,
                                      top: -10,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.highlight,
                                          color: Colors.blue,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),

                      // Render shapes
                      ..._shapes.map((editableShape) {
                        final isSelected = editableShape == _selectedShape;
                        return Positioned(
                          left: editableShape.offset.dx,
                          top: editableShape.offset.dy,
                          child: GestureDetector(
                            onTap: () {
                              _selectShape(editableShape);
                            },
                            onDoubleTap: () {
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
                                        (MediaQuery.of(context).size.width *
                                            0.05),
                                    dragDetails.offset.dy -
                                        (MediaQuery.of(context).padding.top +
                                            56),
                                  );
                                });
                              },
                              child: Stack(
                                children: [
                                  _buildShapeWidget(editableShape),
                                  if (isSelected)
                                    Positioned(
                                      right: -10,
                                      top: -10,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.highlight,
                                          color: Colors.blue,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),

                      // Render elements
                      ..._elements.map((editableElement) {
                        final isSelected = editableElement == _selectedElement;
                        return Positioned(
                          left: editableElement.offset.dx,
                          top: editableElement.offset.dy,
                          child: GestureDetector(
                            onTap: () {
                              _selectElement(editableElement);
                            },
                            onDoubleTap: () {
                              _showEditElementPopup(editableElement);
                            },
                            child: Draggable(
                              feedback: Material(
                                color: Colors.transparent,
                                child: Icon(
                                  editableElement.icon,
                                  color: editableElement.color,
                                  size: editableElement.size.width,
                                ),
                              ),
                              childWhenDragging: Container(),
                              onDragEnd: (dragDetails) {
                                setState(() {
                                  editableElement.offset = Offset(
                                    dragDetails.offset.dx -
                                        (MediaQuery.of(context).size.width *
                                            0.05),
                                    dragDetails.offset.dy -
                                        (MediaQuery.of(context).padding.top +
                                            56),
                                  );
                                });
                              },
                              child: Stack(
                                children: [
                                  Icon(
                                    editableElement.icon,
                                    color: editableElement.color,
                                    size: editableElement.size.width,
                                  ),
                                  if (isSelected)
                                    Positioned(
                                      right: -10,
                                      top: -10,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.highlight,
                                          color: Colors.blue,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),

                      // Render texts
                      ..._texts.map((editableText) {
                        final isSelected = editableText == _selectedText;
                        return Positioned(
                          left: editableText.offset.dx,
                          top: editableText.offset.dy,
                          child: GestureDetector(
                            onTap: () {
                              _selectText(editableText);
                            },
                            onDoubleTap: () {
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
                                        (MediaQuery.of(context).size.width *
                                            0.05),
                                    dragDetails.offset.dy -
                                        (MediaQuery.of(context).padding.top +
                                            56),
                                  );
                                });
                              },
                              child: Stack(
                                children: [
                                  Text(
                                    editableText.text,
                                    style: TextStyle(
                                      color: editableText.color,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (isSelected)
                                    Positioned(
                                      right: -10,
                                      top: -10,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.highlight,
                                          color: Colors.blue,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                ],
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
              child:
                  const _BottomMenuItem(icon: Icons.text_fields, label: 'Text'),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditBrand()));
                },
                child: const _BottomMenuItem(
                    icon: Icons.info, label: 'Brand Info')),
          //  GestureDetector(
          //       onTap: () {
          //         // Updated to navigate to ShapeScreen and handle returning selection
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => const ShapeScreen())
          //         ).then((selectedShape) {
          //           if (selectedShape != null) {
          //             _addShape(selectedShape);
          //           }
          //         });
          //       },
          //       child: const _BottomMenuItem(icon: Icons.category, label: 'Shape'),
          //     ),
              GestureDetector(
                onTap: () {
                  // Navigate to ElementScreen and handle returning selection
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ElementScreen())
                  ).then((selectedElement) {
                    if (selectedElement != null) {
                      _addElement(selectedElement);
                    }
                  });
                },
                child: const _BottomMenuItem(icon: Icons.category, label: 'Shape'),
              ),
              GestureDetector(
                onTap: _pickImage,
                child: const _BottomMenuItem(icon: Icons.add_a_photo, label: 'Add Logo'),
              ),
            ],
          ),
        ),
      );

  }

  // Helper method to build shape widgets based on shape type
  Widget _buildShapeWidget(_EditableShape shape) {
    switch (shape.shapeType) {
      case ShapeType.circle:
        return Container(
          width: shape.size.width,
          height: shape.size.height,
          decoration: BoxDecoration(
            color: shape.color,
            shape: BoxShape.circle,
          ),
        );
      case ShapeType.square:
        return Container(
          width: shape.size.width,
          height: shape.size.height,
          color: shape.color,
        );
      case ShapeType.rectangle:
        return Container(
          width: shape.size.width * 1.5,
          height: shape.size.height,
          color: shape.color,
        );
      case ShapeType.triangle:
        return CustomPaint(
          size: shape.size,
          painter: _TrianglePainter(color: shape.color),
        );
      case ShapeType.pentagon:
        return CustomPaint(
          size: shape.size,
          painter: _PentagonPainter(color: shape.color),
        );
      case ShapeType.hexagon:
        return CustomPaint(
          size: shape.size,
          painter: _HexagonPainter(color: shape.color),
        );
      default:
        return Container(
          width: shape.size.width,
          height: shape.size.height,
          color: shape.color,
        );
    }
  }
}

// Custom painter for triangle shape
class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Custom painter for pentagon shape
class _PentagonPainter extends CustomPainter {
  final Color color;

  _PentagonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;

    for (int i = 0; i < 5; i++) {
      final angle = (i * 2 * math.pi / 5) - math.pi / 2;
      final x = centerX + radius * math.cos(angle);
      final y = centerY + radius * math.sin(angle);

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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Custom painter for hexagon shape
class _HexagonPainter extends CustomPainter {
  final Color color;

  _HexagonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;

    for (int i = 0; i < 6; i++) {
      final angle = (i * 2 * math.pi / 6) - math.pi / 2;
      final x = centerX + radius * math.cos(angle);
      final y = centerY + radius * math.sin(angle);

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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Bottom menu item
class _BottomMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BottomMenuItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}

// Class to represent an editable text
class _EditableText {
  String text;
  Color color;
  Offset offset;

  _EditableText({
    required this.text,
    required this.color,
    required this.offset,
  });
}

// Enum for shape types
enum ShapeType { circle, square, rectangle, triangle, pentagon, hexagon }

// Class to represent an editable shape
class _EditableShape {
  ShapeType shapeType;
  Color color;
  Size size;
  Offset offset;

  _EditableShape({
    required this.shapeType,
    required this.color,
    required this.size,
    required this.offset,
  });
}

// Class to represent an editable element
class _EditableElement {
  IconData icon;
  String name;
  Color color;
  Size size;
  Offset offset;

  _EditableElement({
    required this.icon,
    required this.name,
    required this.color,
    required this.size,
    required this.offset,
  });
}

// Class to represent an editable image
class _EditableImage {
  File imageFile;
  Offset offset;
  Size size;

  _EditableImage({
    required this.imageFile,
    required this.offset,
    required this.size,
  });
}