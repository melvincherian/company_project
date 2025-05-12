import 'dart:math';

import 'package:company_project/models/category_modell.dart';
import 'package:company_project/models/poster_size_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';
import 'package:media_store_plus/media_store_plus.dart';
// Added packages for enhanced functionality
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:photofilters/photofilters.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;

class PosterMakerApp extends StatelessWidget {
  final dynamic poster;
  final dynamic posterSize;
  final bool isCustom;

  const PosterMakerApp({
    super.key,
    this.poster,
    this.posterSize,
    this.isCustom = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poster Maker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PosterMakerScreen(
          poster: poster, isCustom: isCustom, posterSize: posterSize),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PosterMakerScreen extends StatefulWidget {
  final dynamic poster;
  final bool isCustom;
  final PosterSize? posterSize;

  const PosterMakerScreen({
    super.key,
    this.poster,
    this.isCustom = false,
    this.posterSize,
  });

  @override
  _PosterMakerScreenState createState() => _PosterMakerScreenState();
}

class _PosterMakerScreenState extends State<PosterMakerScreen>
    with TickerProviderStateMixin {
  final GlobalKey _posterKey = GlobalKey();
  File? _posterImage;
  File? _logoImage;
  File? _picImage;
  final TextEditingController _contactInfoController = TextEditingController(
    text: 'info@example.com | www.example.com | 1234567890',
  );

  // Lists for different elements
  List<DraggableItem> socialIcons = [];
  List<DraggableTextItem> textItems = [];
  List<DraggableStickerItem> stickerItems = [];

  // Items for fixed elements
  DraggableItem? logoItem;
  DraggableItem? picItem;
  DraggableTextItem? contactInfoItem;
  late File file;

  // Background color and gradient properties
  Color _backgroundColor = Colors.white;
  bool _useGradient = false;
  List<Color> _gradientColors = [Colors.white, Colors.blue.shade100];

  // Animation controllers for animated elements
  Map<String, AnimationController> _animationControllers = {};

  // Selected item for editing
  String? _selectedItemId;
  String? _selectedItemType;

  // Effect applied to background image
  // Filter? _appliedFilter;
  // double _brightness = 0.0;
  // double _contrast = 1.0;
  // double _saturation = 1.0;

  List<FilterOption> _filterOptions = [];
  FilterOption? _appliedFilter;
  double _brightness = 0.0;
  double _contrast = 1.0;
  double _saturation = 1.0;

  List<double> multiplyColorMatrices(List<double> a, List<double> b) {
    List<double> result = List.filled(20, 0.0);

    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 5; col++) {
        result[row * 5 + col] = a[row * 5 + 0] * b[0 * 5 + col] +
            a[row * 5 + 1] * b[1 * 5 + col] +
            a[row * 5 + 2] * b[2 * 5 + col] +
            a[row * 5 + 3] * b[3 * 5 + col];
        if (col == 4) {
          // bias (last column)
          result[row * 5 + col] += a[row * 5 + 4];
        }
      }
    }

    return result;
  }

  @override
  void initState() {
    super.initState();
    _loadDefaultSocialIcons();
    _initializeFilters();
    
    // Initialize contact info text item
    contactInfoItem = DraggableTextItem(
      id: 'contact_info',
      text: _contactInfoController.text,
      position: const Offset(20, 0),
      fontSize: 14,
      fontWeight: FontWeight.normal,
      textColor: Colors.black,
      bgColor: Colors.transparent,
      rotation: 0,
      isAnimated: false,
      animationType: 'none',
      onPositionChanged: (Offset newPosition) {
        setState(() {
          contactInfoItem?.position = newPosition;
        });
      },
    );

    // Load the passed poster if available
    _loadPassedPoster();
  }

  @override
  void dispose() {
    // Dispose all animation controllers
    _animationControllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  void _loadPassedPoster() {
    
    if (widget.poster != null) {
      // Handle different types of poster objects
      if (widget.poster is File) {
        setState(() {
          _posterImage = widget.poster.images[0];
          
        });
      } else if (widget.poster is String &&
          widget.poster.toString().startsWith('http')) {
        Future<void> urlToFile(dynamic url) async {
          // 1. Fetch image data
          final uri = Uri.parse(url);
          final response = await http.get(uri);
          if (response.statusCode != 200) {
            throw Exception('Failed to download image: ${response.statusCode}');
          }
          final bytes = response.bodyBytes;

          // 2. Get a temporary directory
          final tempDir = await getTemporaryDirectory();

          // 3. Create a unique filename
          final fileName = uri.pathSegments.isNotEmpty
              ? uri.pathSegments.last
              : DateTime.now().millisecondsSinceEpoch.toString();

          final file = File('${tempDir.path}/$fileName');

          // 4. Write the bytes to the file
          await file.writeAsBytes(bytes, flush: true);

          _posterImage = file;

          print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$_posterImage');
        }

        urlToFile(widget.poster.images[0]);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Loading poster from URL...')),
        );
      } else if (widget.poster is Map) {
        // If poster is a Map or other complex object
        // Extract image path or data as needed for your specific implementation
        if (widget.poster['imagePath'] != null) {
          setState(() {
            _posterImage = File(widget.poster['imagePath']);
          });
        }
      }
    }else{
      print('Poster is null');
    }
  }

  void _initializeFilters() {
    _filterOptions = [
      FilterOption(
        name: 'Normal',
        filter: const ColorFilter.mode(Colors.transparent, BlendMode.srcOver),
        matrix: [
          1,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ],
      ),
      FilterOption(
        name: 'Sepia',
        filter: ColorFilter.matrix([
          0.393,
          0.769,
          0.189,
          0,
          0,
          0.349,
          0.686,
          0.168,
          0,
          0,
          0.272,
          0.534,
          0.131,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]),
        matrix: [
          0.393,
          0.769,
          0.189,
          0,
          0,
          0.349,
          0.686,
          0.168,
          0,
          0,
          0.272,
          0.534,
          0.131,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ],
      ),
      FilterOption(
        name: 'Grayscale',
        filter: ColorFilter.matrix([
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]),
        matrix: [
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ],
      ),
      FilterOption(
        name: 'Vintage',
        filter: ColorFilter.matrix([
          0.9,
          0.5,
          0.1,
          0,
          0,
          0.3,
          0.8,
          0.1,
          0,
          0,
          0.2,
          0.3,
          0.5,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]),
        matrix: [
          0.9,
          0.5,
          0.1,
          0,
          0,
          0.3,
          0.8,
          0.1,
          0,
          0,
          0.2,
          0.3,
          0.5,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ],
      ),
      FilterOption(
        name: 'Cold',
        filter: ColorFilter.matrix([
          1,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
          0,
          0,
          0,
          0.5,
          1,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]),
        matrix: [
          1,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
          0,
          0,
          0,
          0.5,
          1,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ],
      ),
      FilterOption(
        name: 'Warm',
        filter: ColorFilter.matrix([
          1.1,
          0,
          0,
          0,
          10,
          0,
          1.0,
          0,
          0,
          0,
          0,
          0,
          0.9,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]),
        matrix: [
          1.1,
          0,
          0,
          0,
          10,
          0,
          1.0,
          0,
          0,
          0,
          0,
          0,
          0.9,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ],
      ),
    ];
  }

  Future<void> _loadDefaultSocialIcons() async {
    // This would typically load actual icons, but we'll create placeholders for this example
    setState(() {
      socialIcons = [
        DraggableItem(
          id: 'facebook',
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.facebook, color: Colors.white),
          ),
          position: const Offset(10, 10),
          rotation: 0,
          scale: 1.0,
          isAnimated: false,
          animationType: 'none',
          onPositionChanged: (Offset newPosition) {
            setState(() {
              final index =
                  socialIcons.indexWhere((item) => item.id == 'facebook');
              if (index != -1) {
                socialIcons[index].position = newPosition;
              }
            });
          },
        ),
        DraggableItem(
          id: 'instagram',
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.pink, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.camera_alt, color: Colors.white),
          ),
          position: const Offset(60, 10),
          rotation: 0,
          scale: 1.0,
          isAnimated: false,
          animationType: 'none',
          onPositionChanged: (Offset newPosition) {
            setState(() {
              final index =
                  socialIcons.indexWhere((item) => item.id == 'instagram');
              if (index != -1) {
                socialIcons[index].position = newPosition;
              }
            });
          },
        ),
        DraggableItem(
          id: 'whatsapp',
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.chat, color: Colors.white),
          ),
          position: const Offset(110, 10),
          rotation: 0,
          scale: 1.0,
          isAnimated: false,
          animationType: 'none',
          onPositionChanged: (Offset newPosition) {
            setState(() {
              final index =
                  socialIcons.indexWhere((item) => item.id == 'whatsapp');
              if (index != -1) {
                socialIcons[index].position = newPosition;
              }
            });
          },
        ),
      ];
    });
  }

  Future<void> _pickPosterImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _posterImage = File(image.path);
        // Reset filters when new image is selected
        _brightness = 0.0;
        _contrast = 1.0;
        _saturation = 1.0;
        _appliedFilter = null;
      });
    }
  }

  Future<void> _pickLogoImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final File logoFile = File(image.path);

      // Preserve the current position and scale if updating an existing logo
      final Offset position = logoItem?.position ?? const Offset(250, 10);
      final double scale = logoItem?.scale ?? 1.0;

      setState(() {
        _logoImage = logoFile;
        logoItem = DraggableItem(
          id: 'logo',
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(logoFile),
                fit: BoxFit.contain,
              ),
            ),
          ),
          position: position,
          rotation: 0,
          scale: scale,
          isAnimated: false,
          animationType: 'none',
          onPositionChanged: (Offset newPosition) {
            setState(() {
              logoItem?.position = newPosition;
            });
          },
        );
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final File picFile = File(image.path);

      // Preserve the current position and scale if updating an existing logo
      final Offset position = picItem?.position ?? const Offset(250, 10);
      final double scale = picItem?.scale ?? 1.0;

      setState(() {
        _picImage = picFile;
        picItem = DraggableItem(
          id: 'pic',
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(picFile),
                fit: BoxFit.contain,
              ),
            ),
          ),
          position: position,
          rotation: 0,
          scale: scale,
          isAnimated: false,
          animationType: 'none',
          onPositionChanged: (Offset newPosition) {
            setState(() {
              picItem?.position = newPosition;
            });
          },
        );
      });
    }
  }

  void _showLogoOptions() {
    if (_selectedItemType == 'logo' && _selectedItemId == logoItem?.id) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Change Logo'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickLogoImage();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Remove Logo'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      logoItem = null;
                      _logoImage = null;
                      _selectedItemId = '';
                      _selectedItemType = '';
                    });
                  },
                ),
                ListTile(
                  leading: Icon(Icons.zoom_in),
                  title: Text('Resize Logo'),
                  subtitle: Text('Drag the blue handle to resize'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }

  void _showPicOptions() {
    if (_selectedItemType == 'pic' && _selectedItemId == picItem?.id) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Change Pic'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Remove Pic'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      picItem = null;
                      _picImage = null;
                      _selectedItemId = '';
                      _selectedItemType = '';
                    });
                  },
                ),
                ListTile(
                  leading: Icon(Icons.zoom_in),
                  title: Text('Resize Pic'),
                  subtitle: Text('Drag the blue handle to resize'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }

  // TEXT MANAGEMENT METHODS
  void _addNewText() {
    final TextEditingController controller =
        TextEditingController(text: 'New Text');
    Color textColor = Colors.black;
    Color bgColor = Colors.transparent;
    double fontSize = 20;
    FontWeight fontWeight = FontWeight.normal;
    bool isAnimated = false;
    String animationType = 'none';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setDialogState) {
        return AlertDialog(
          title: const Text('Add Text'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration:
                      const InputDecoration(hintText: 'Enter your text'),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text('Size: '),
                    Expanded(
                      child: Slider(
                        value: fontSize,
                        min: 10,
                        max: 40,
                        divisions: 30,
                        label: fontSize.round().toString(),
                        onChanged: (value) {
                          setDialogState(() {
                            fontSize = value;
                          });
                        },
                      ),
                    ),
                    Text('${fontSize.round()}'),
                  ],
                ),
                Row(
                  children: [
                    const Text('Bold: '),
                    Switch(
                      value: fontWeight == FontWeight.bold,
                      onChanged: (value) {
                        setDialogState(() {
                          fontWeight =
                              value ? FontWeight.bold : FontWeight.normal;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Text Color: '),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Pick a color'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: textColor,
                                  onColorChanged: (color) {
                                    setDialogState(() {
                                      textColor = color;
                                    });
                                  },
                                  pickerAreaHeightPercent: 0.8,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Done'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: textColor,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text('Background: '),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Pick a background color'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: bgColor,
                                  onColorChanged: (color) {
                                    setDialogState(() {
                                      bgColor = color;
                                    });
                                  },
                                  pickerAreaHeightPercent: 0.8,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Done'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: bgColor,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Animated: '),
                    Switch(
                      value: isAnimated,
                      onChanged: (value) {
                        setDialogState(() {
                          isAnimated = value;
                        });
                      },
                    ),
                  ],
                ),
                if (isAnimated)
                  DropdownButton<String>(
                    value: animationType,
                    items: const [
                      DropdownMenuItem(value: 'none', child: Text('None')),
                      DropdownMenuItem(value: 'bounce', child: Text('Bounce')),
                      DropdownMenuItem(value: 'fade', child: Text('Fade')),
                      DropdownMenuItem(value: 'shake', child: Text('Shake')),
                      DropdownMenuItem(value: 'scale', child: Text('Scale')),
                    ],
                    onChanged: (value) {
                      setDialogState(() {
                        animationType = value!;
                      });
                    },
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final String newId =
                    'text_${DateTime.now().millisecondsSinceEpoch}';
                final newTextItem = DraggableTextItem(
                  id: newId,
                  text: controller.text,
                  position: Offset(
                    MediaQuery.of(context).size.width / 2 - 50,
                    MediaQuery.of(context).size.height / 2 - 50,
                  ),
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  textColor: textColor,
                  bgColor: bgColor,
                  rotation: 0,
                  isAnimated: isAnimated,
                  animationType: animationType,
                  onPositionChanged: (Offset newPosition) {
                    setState(() {
                      final index =
                          textItems.indexWhere((item) => item.id == newId);
                      if (index != -1) {
                        textItems[index].position = newPosition;
                      }
                    });
                  },
                );

                setState(() {
                  textItems.add(newTextItem);

                  // Create animation controller if needed
                  if (isAnimated && animationType != 'none') {
                    _createAnimationController(newId, animationType);
                  }
                });

                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      }),
    );
  }

  void _editTextItem(DraggableTextItem item) {
    final TextEditingController controller =
        TextEditingController(text: item.text);
    Color textColor = item.textColor;
    Color bgColor = item.bgColor;
    double fontSize = item.fontSize;
    FontWeight fontWeight = item.fontWeight;
    bool isAnimated = item.isAnimated;
    String animationType = item.animationType;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setDialogState) {
        return AlertDialog(
          title: const Text('Edit Text'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration:
                      const InputDecoration(hintText: 'Enter your text'),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text('Size: '),
                    Expanded(
                      child: Slider(
                        value: fontSize,
                        min: 10,
                        max: 40,
                        divisions: 30,
                        label: fontSize.round().toString(),
                        onChanged: (value) {
                          setDialogState(() {
                            fontSize = value;
                          });
                        },
                      ),
                    ),
                    Text('${fontSize.round()}'),
                  ],
                ),
                Row(
                  children: [
                    const Text('Bold: '),
                    Switch(
                      value: fontWeight == FontWeight.bold,
                      onChanged: (value) {
                        setDialogState(() {
                          fontWeight =
                              value ? FontWeight.bold : FontWeight.normal;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Text Color: '),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Pick a color'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: textColor,
                                  onColorChanged: (color) {
                                    setDialogState(() {
                                      textColor = color;
                                    });
                                  },
                                  pickerAreaHeightPercent: 0.8,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Done'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: textColor,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text('Background: '),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Pick a background color'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: bgColor,
                                  onColorChanged: (color) {
                                    setDialogState(() {
                                      bgColor = color;
                                    });
                                  },
                                  pickerAreaHeightPercent: 0.8,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Done'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: bgColor,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Animated: '),
                    Switch(
                      value: isAnimated,
                      onChanged: (value) {
                        setDialogState(() {
                          isAnimated = value;
                        });
                      },
                    ),
                  ],
                ),
                if (isAnimated)
                  DropdownButton<String>(
                    value: animationType,
                    items: const [
                      DropdownMenuItem(value: 'none', child: Text('None')),
                      DropdownMenuItem(value: 'bounce', child: Text('Bounce')),
                      DropdownMenuItem(value: 'fade', child: Text('Fade')),
                      DropdownMenuItem(value: 'shake', child: Text('Shake')),
                      DropdownMenuItem(value: 'scale', child: Text('Scale')),
                    ],
                    onChanged: (value) {
                      setDialogState(() {
                        animationType = value!;
                      });
                    },
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Text'),
                    content: const Text(
                        'Are you sure you want to delete this text element?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            textItems.removeWhere(
                                (element) => element.id == item.id);

                            // Remove animation controller if it exists
                            if (_animationControllers.containsKey(item.id)) {
                              _animationControllers[item.id]?.dispose();
                              _animationControllers.remove(item.id);
                            }
                          });

                          Navigator.pop(context); // Close delete dialog
                          Navigator.pop(context); // Close edit dialog
                        },
                        child: const Text('Delete',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  final index =
                      textItems.indexWhere((element) => element.id == item.id);
                  if (index != -1) {
                    textItems[index].text = controller.text;
                    textItems[index].fontSize = fontSize;
                    textItems[index].fontWeight = fontWeight;
                    textItems[index].textColor = textColor;
                    textItems[index].bgColor = bgColor;
                    textItems[index].isAnimated = isAnimated;
                    textItems[index].animationType = animationType;

                    // Update animation if needed
                    if (isAnimated && animationType != 'none') {
                      _createAnimationController(item.id, animationType);
                    } else {
                      // Remove animation controller if it exists
                      if (_animationControllers.containsKey(item.id)) {
                        _animationControllers[item.id]?.dispose();
                        _animationControllers.remove(item.id);
                      }
                    }
                  }
                });

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      }),
    );
  }

  // STICKER METHODS
  void _addSticker() {
    // 150 varied and attractive sticker options
    final List<Map<String, dynamic>> stickerOptions = [
      // Emoji & Expressions
      {
        'name': 'Heart Eyes',
        'icon': Icons.emoji_emotions,
        'color': Colors.amber[500]
      },
      {
        'name': 'Cool Face',
        'icon': Icons.face_retouching_natural,
        'color': Colors.blue[400]
      },
      {
        'name': 'Wink',
        'icon': Icons.sentiment_satisfied_alt,
        'color': Colors.yellow[600]
      },
      {'name': 'Laugh Tears', 'icon': Icons.mood, 'color': Colors.amber[400]},
      {
        'name': 'Mind Blown',
        'icon': Icons.psychology,
        'color': Colors.red[400]
      },
      {
        'name': 'Shocked',
        'icon': Icons.face_retouching_natural,
        'color': Colors.purple[300]
      },
      {'name': 'Thinking', 'icon': Icons.psychology, 'color': Colors.blue[300]},
      {
        'name': 'Love Struck',
        'icon': Icons.favorite,
        'color': Colors.pink[400]
      },
      {
        'name': 'Party Face',
        'icon': Icons.celebration,
        'color': Colors.orange[400]
      },
      {
        'name': 'Sleepy',
        'icon': Icons.nights_stay,
        'color': Colors.indigo[300]
      },

      // Animals
      {'name': 'Cat', 'icon': Icons.pets, 'color': Colors.grey[500]},
      {'name': 'Dog', 'icon': Icons.pets, 'color': Colors.brown[300]},
      {'name': 'Dolphin', 'icon': Icons.water, 'color': Colors.cyan[300]},
      {'name': 'Lion', 'icon': Icons.face, 'color': Colors.amber[800]},
      {
        'name': 'Flamingo',
        'icon': Icons.filter_vintage,
        'color': Colors.pink[300]
      },
      {'name': 'Panda', 'icon': Icons.pets, 'color': Colors.grey[900]},
      {'name': 'Koala', 'icon': Icons.pets, 'color': Colors.grey[400]},
      {'name': 'Owl', 'icon': Icons.visibility, 'color': Colors.brown[500]},
      {
        'name': 'Butterfly',
        'icon': Icons.flutter_dash,
        'color': Colors.teal[300]
      },
      {'name': 'Elephant', 'icon': Icons.pets, 'color': Colors.grey[600]},
      {'name': 'Fox', 'icon': Icons.pets, 'color': Colors.orange[500]},
      {
        'name': 'Penguin',
        'icon': Icons.back_hand,
        'color': Colors.blueGrey[800]
      },
      {'name': 'Bee', 'icon': Icons.flutter_dash, 'color': Colors.amber[400]},
      {'name': 'Monkey', 'icon': Icons.face, 'color': Colors.brown[400]},
      {'name': 'Turtle', 'icon': Icons.shield, 'color': Colors.green[800]},

      // Fantasy & Magical
      {
        'name': 'Unicorn',
        'icon': Icons.auto_awesome,
        'color': Colors.purple[300]
      },
      {
        'name': 'Magic Wand',
        'icon': Icons.auto_fix_high,
        'color': Colors.indigo[400]
      },
      {
        'name': 'Dragon',
        'icon': Icons.whatshot,
        'color': Colors.deepOrange[700]
      },
      {
        'name': 'Crystal Ball',
        'icon': Icons.lens,
        'color': Colors.lightBlue[200]
      },
      {
        'name': 'Wizard Hat',
        'icon': Icons.auto_awesome,
        'color': Colors.deepPurple[800]
      },
      {'name': 'Fairy', 'icon': Icons.all_inclusive, 'color': Colors.pink[200]},
      {'name': 'Phoenix', 'icon': Icons.whatshot, 'color': Colors.red[500]},
      {'name': 'Castle', 'icon': Icons.castle, 'color': Colors.blueGrey[700]},
      {'name': 'Mermaid', 'icon': Icons.waves, 'color': Colors.cyan[400]},
      {
        'name': 'Potion',
        'icon': Icons.local_drink,
        'color': Colors.purple[500]
      },

      // Food & Drinks
      {'name': 'Pizza', 'icon': Icons.local_pizza, 'color': Colors.orange[400]},
      {
        'name': 'Burger',
        'icon': Icons.lunch_dining,
        'color': Colors.brown[600]
      },
      {'name': 'Taco', 'icon': Icons.lunch_dining, 'color': Colors.orange[300]},
      {'name': 'Sushi', 'icon': Icons.set_meal, 'color': Colors.red[200]},
      {'name': 'Ice Cream', 'icon': Icons.icecream, 'color': Colors.pink[100]},
      {'name': 'Donut', 'icon': Icons.donut_large, 'color': Colors.pink[400]},
      {'name': 'Avocado', 'icon': Icons.spa, 'color': Colors.green[600]},
      {'name': 'Coffee', 'icon': Icons.coffee, 'color': Colors.brown[500]},
      {'name': 'Cake', 'icon': Icons.cake, 'color': Colors.pink[300]},
      {'name': 'Watermelon', 'icon': Icons.circle, 'color': Colors.green[600]},
      {'name': 'Cupcake', 'icon': Icons.cake, 'color': Colors.pink[200]},
      {
        'name': 'Lemonade',
        'icon': Icons.local_drink,
        'color': Colors.yellow[400]
      },
      {
        'name': 'Pretzel',
        'icon': Icons.bakery_dining,
        'color': Colors.amber[700]
      },
      {
        'name': 'Croissant',
        'icon': Icons.bakery_dining,
        'color': Colors.amber[500]
      },
      {
        'name': 'Boba Tea',
        'icon': Icons.emoji_food_beverage,
        'color': Colors.brown[300]
      },

      // Nature & Plants
      {
        'name': 'Flower',
        'icon': Icons.local_florist,
        'color': Colors.pink[300]
      },
      {'name': 'Palm Tree', 'icon': Icons.park, 'color': Colors.green[700]},
      {'name': 'Cactus', 'icon': Icons.grass, 'color': Colors.lightGreen[700]},
      {'name': 'Leaf', 'icon': Icons.eco, 'color': Colors.green[500]},
      {
        'name': 'Four Leaf Clover',
        'icon': Icons.spa,
        'color': Colors.green[400]
      },
      {
        'name': 'Cherry Blossom',
        'icon': Icons.filter_vintage,
        'color': Colors.pink[100]
      },
      {
        'name': 'Sunflower',
        'icon': Icons.wb_sunny,
        'color': Colors.yellow[600]
      },
      {'name': 'Mushroom', 'icon': Icons.umbrella, 'color': Colors.brown[200]},
      {'name': 'Rose', 'icon': Icons.local_florist, 'color': Colors.red[500]},
      {'name': 'Bamboo', 'icon': Icons.grass, 'color': Colors.green[500]},

      // Weather & Celestial
      {'name': 'Sun', 'icon': Icons.wb_sunny, 'color': Colors.amber[500]},
      {
        'name': 'Moon',
        'icon': Icons.nightlight_round,
        'color': Colors.indigo[300]
      },
      {'name': 'Cloud', 'icon': Icons.cloud, 'color': Colors.blue[300]},
      {
        'name': 'Rainbow',
        'icon': Icons.filter_drama,
        'color': Colors.purple[300]
      },
      {
        'name': 'Snowflake',
        'icon': Icons.ac_unit,
        'color': Colors.lightBlue[200]
      },
      {'name': 'Lightning', 'icon': Icons.bolt, 'color': Colors.amber[400]},
      {'name': 'Tornado', 'icon': Icons.air, 'color': Colors.blueGrey[500]},
      {'name': 'Star', 'icon': Icons.star, 'color': Colors.amber[300]},
      {'name': 'Comet', 'icon': Icons.flash_on, 'color': Colors.blue[400]},
      {'name': 'Aurora', 'icon': Icons.waves, 'color': Colors.green[200]},

      // Space & Sci-Fi
      {'name': 'Rocket', 'icon': Icons.rocket_launch, 'color': Colors.red[600]},
      {'name': 'Alien', 'icon': Icons.android, 'color': Colors.green[400]},
      {'name': 'Planet', 'icon': Icons.public, 'color': Colors.blue[700]},
      {
        'name': 'Satellite',
        'icon': Icons.satellite_alt,
        'color': Colors.grey[400]
      },
      {
        'name': 'UFO',
        'icon': Icons.airplanemode_active,
        'color': Colors.purple[600]
      },
      {
        'name': 'Telescope',
        'icon': Icons.visibility,
        'color': Colors.indigo[800]
      },
      {'name': 'Astronaut', 'icon': Icons.person, 'color': Colors.white},
      {
        'name': 'Black Hole',
        'icon': Icons.blur_circular,
        'color': Colors.black
      },
      {
        'name': 'Galaxy',
        'icon': Icons.blur_on,
        'color': Colors.deepPurple[400]
      },
      {
        'name': 'Space Station',
        'icon': Icons.settings_input_antenna,
        'color': Colors.grey[500]
      },

      // Tech & Gaming
      {
        'name': 'Game Controller',
        'icon': Icons.sports_esports,
        'color': Colors.blue[700]
      },
      {'name': 'Headphones', 'icon': Icons.headphones, 'color': Colors.black87},
      {
        'name': 'VR Headset',
        'icon': Icons.view_in_ar,
        'color': Colors.indigo[600]
      },
      {'name': 'Laptop', 'icon': Icons.laptop, 'color': Colors.grey[800]},
      {'name': 'Smartphone', 'icon': Icons.smartphone, 'color': Colors.black},
      {'name': 'Robot', 'icon': Icons.smart_toy, 'color': Colors.blue[500]},
      {'name': 'Joystick', 'icon': Icons.gamepad, 'color': Colors.purple[500]},
      {'name': 'Camera', 'icon': Icons.camera_alt, 'color': Colors.grey[700]},
      {
        'name': 'Bitcoin',
        'icon': Icons.currency_bitcoin,
        'color': Colors.amber[500]
      },
      {'name': 'Pixel Heart', 'icon': Icons.favorite, 'color': Colors.red[600]},

      // Transportation
      {'name': 'Car', 'icon': Icons.directions_car, 'color': Colors.red[500]},
      {'name': 'Airplane', 'icon': Icons.flight, 'color': Colors.blue[500]},
      {
        'name': 'Bicycle',
        'icon': Icons.directions_bike,
        'color': Colors.green[500]
      },
      {'name': 'Hot Air Balloon', 'icon': Icons.air, 'color': Colors.red[300]},
      {
        'name': 'Sailboat',
        'icon': Icons.sailing,
        'color': Colors.lightBlue[500]
      },
      {
        'name': 'Submarine',
        'icon': Icons.directions_boat,
        'color': Colors.yellow[700]
      },
      {
        'name': 'Helicopter',
        'icon': Icons.airplanemode_active,
        'color': Colors.black54
      },
      {'name': 'Train', 'icon': Icons.train, 'color': Colors.red[700]},
      {'name': 'Motorcycle', 'icon': Icons.motorcycle, 'color': Colors.black},
      {'name': 'Taxi', 'icon': Icons.local_taxi, 'color': Colors.yellow[600]},

      // Sports & Activities
      {
        'name': 'Basketball',
        'icon': Icons.sports_basketball,
        'color': Colors.orange[600]
      },
      {
        'name': 'Football',
        'icon': Icons.sports_football,
        'color': Colors.brown[500]
      },
      {'name': 'Soccer', 'icon': Icons.sports_soccer, 'color': Colors.black},
      {
        'name': 'Tennis',
        'icon': Icons.sports_tennis,
        'color': Colors.lime[500]
      },
      {
        'name': 'Baseball',
        'icon': Icons.sports_baseball,
        'color': Colors.white
      },
      {'name': 'Surfboard', 'icon': Icons.surfing, 'color': Colors.blue[300]},
      {'name': 'Ski', 'icon': Icons.downhill_skiing, 'color': Colors.blue[700]},
      {'name': 'Golf', 'icon': Icons.sports_golf, 'color': Colors.green[500]},
      {
        'name': 'Skateboard',
        'icon': Icons.skateboarding,
        'color': Colors.blueGrey[600]
      },
      {
        'name': 'Yoga',
        'icon': Icons.self_improvement,
        'color': Colors.teal[400]
      },

      // Music & Arts
      {
        'name': 'Music Note',
        'icon': Icons.music_note,
        'color': Colors.pink[500]
      },
      {'name': 'Guitar', 'icon': Icons.audiotrack, 'color': Colors.brown[600]},
      {'name': 'Microphone', 'icon': Icons.mic, 'color': Colors.red[600]},
      {'name': 'Vinyl Record', 'icon': Icons.album, 'color': Colors.black},
      {
        'name': 'Paintbrush',
        'icon': Icons.brush,
        'color': Colors.deepOrange[400]
      },
      {'name': 'Piano', 'icon': Icons.piano, 'color': Colors.grey[900]},
      {
        'name': 'Theater Mask',
        'icon': Icons.theater_comedy,
        'color': Colors.amber[600]
      },
      {'name': 'Drum', 'icon': Icons.music_note, 'color': Colors.red[400]},
      {
        'name': 'Saxophone',
        'icon': Icons.music_note,
        'color': Colors.amber[700]
      },
      {'name': 'Palette', 'icon': Icons.palette, 'color': Colors.purple[400]},

      // Seasonal & Holiday
      {
        'name': 'Pumpkin',
        'icon': Icons.emoji_food_beverage,
        'color': Colors.orange[800]
      },
      {'name': 'Firework', 'icon': Icons.flare, 'color': Colors.purple[400]},
      {
        'name': 'Snowman',
        'icon': Icons.ac_unit,
        'color': Colors.lightBlue[100]
      },
      {
        'name': 'Christmas Tree',
        'icon': Icons.park,
        'color': Colors.green[800]
      },
      {'name': 'Gift', 'icon': Icons.card_giftcard, 'color': Colors.red[500]},
      {'name': 'Easter Egg', 'icon': Icons.egg, 'color': Colors.pink[200]},
      {
        'name': 'Candy Cane',
        'icon': Icons.rounded_corner,
        'color': Colors.red[500]
      },
      {
        'name': 'Valentine Heart',
        'icon': Icons.favorite,
        'color': Colors.pink[500]
      },
      {
        'name': 'New Year',
        'icon': Icons.celebration,
        'color': Colors.amber[300]
      },
      {
        'name': 'Beach Umbrella',
        'icon': Icons.beach_access,
        'color': Colors.orange[500]
      },

      // Objects & Items
      {'name': 'Diamond', 'icon': Icons.diamond, 'color': Colors.cyan[300]},
      {
        'name': 'Crown',
        'icon': Icons.brightness_auto,
        'color': Colors.amber[500]
      },
      {
        'name': 'Light Bulb',
        'icon': Icons.lightbulb,
        'color': Colors.yellow[600]
      },
      {'name': 'Key', 'icon': Icons.key, 'color': Colors.amber[700]},
      {'name': 'Lock', 'icon': Icons.lock, 'color': Colors.blueGrey[700]},
      {'name': 'Glasses', 'icon': Icons.visibility, 'color': Colors.black54},
      {'name': 'Watch', 'icon': Icons.watch, 'color': Colors.brown[600]},
      {
        'name': 'Backpack',
        'icon': Icons.backpack,
        'color': Colors.deepPurple[500]
      },
      {'name': 'Book', 'icon': Icons.book, 'color': Colors.blue[800]},
      {'name': 'Umbrella', 'icon': Icons.umbrella, 'color': Colors.indigo[500]},

      // Places & Landmarks
      {
        'name': 'Eiffel Tower',
        'icon': Icons.location_city,
        'color': Colors.grey[600]
      },
      {
        'name': 'Statue of Liberty',
        'icon': Icons.account_balance,
        'color': Colors.teal[500]
      },
      {
        'name': 'Pyramid',
        'icon': Icons.change_history,
        'color': Colors.amber[800]
      },
      {
        'name': 'Pagoda',
        'icon': Icons.account_balance,
        'color': Colors.red[800]
      },
      {
        'name': 'Colosseum',
        'icon': Icons.maps_home_work,
        'color': Colors.brown[400]
      },
      {
        'name': 'Mount Fuji',
        'icon': Icons.landscape,
        'color': Colors.indigo[400]
      },
      {'name': 'Great Wall', 'icon': Icons.fence, 'color': Colors.grey[600]},
      {
        'name': 'Taj Mahal',
        'icon': Icons.account_balance,
        'color': Colors.white
      },
      {
        'name': 'Skyscraper',
        'icon': Icons.apartment,
        'color': Colors.blue[700]
      },

      // Mystical & Spiritual
      {
        'name': 'Yin Yang',
        'icon': Icons.brightness_medium,
        'color': Colors.black
      },
      {
        'name': 'Om Symbol',
        'icon': Icons.all_inclusive,
        'color': Colors.orange[600]
      },
      {'name': 'Lotus', 'icon': Icons.spa, 'color': Colors.pink[200]},
      {
        'name': 'Meditation',
        'icon': Icons.self_improvement,
        'color': Colors.indigo[400]
      },
      {
        'name': 'Dreamcatcher',
        'icon': Icons.stream,
        'color': Colors.purple[300]
      },
      {
        'name': 'Chakra',
        'icon': Icons.change_circle,
        'color': Colors.teal[400]
      },
      {'name': 'Mandala', 'icon': Icons.flare, 'color': Colors.amber[400]},
      {'name': 'Zen Stone', 'icon': Icons.grain, 'color': Colors.grey[500]},
      {
        'name': 'Evil Eye',
        'icon': Icons.remove_red_eye,
        'color': Colors.blue[500]
      },
      {'name': 'Incense', 'icon': Icons.waves, 'color': Colors.brown[300]},
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Sticker'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: stickerOptions.length,
            itemBuilder: (context, index) {
              final sticker = stickerOptions[index];
              return InkWell(
                onTap: () {
                  final String newId =
                      'sticker_${DateTime.now().millisecondsSinceEpoch}';

                  final newStickerItem = DraggableStickerItem(
                    id: newId,
                    stickerType: sticker['name'],
                    icon: sticker['icon'],
                    color: sticker['color'],
                    position: Offset(
                      MediaQuery.of(context).size.width / 2 - 25,
                      MediaQuery.of(context).size.height / 2 - 25,
                    ),
                    size: 50,
                    rotation: 0,
                    isAnimated: false,
                    animationType: 'none',
                    onPositionChanged: (Offset newPosition) {
                      setState(() {
                        final index =
                            stickerItems.indexWhere((item) => item.id == newId);
                        if (index != -1) {
                          stickerItems[index].position = newPosition;
                        }
                      });
                    },
                  );

                  setState(() {
                    stickerItems.add(newStickerItem);
                  });

                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    sticker['icon'],
                    color: sticker['color'],
                    size: 30,
                  ),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _editStickerItem(DraggableStickerItem item) {
    double size = item.size;
    bool isAnimated = item.isAnimated;
    String animationType = item.animationType;
    Color color = item.color;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setDialogState) {
        return AlertDialog(
          title: const Text('Edit Sticker'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Icon(
                    item.icon,
                    color: color,
                    size: size,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text('Size: '),
                    Expanded(
                      child: Slider(
                        value: size,
                        min: 30,
                        max: 100,
                        divisions: 14,
                        label: size.round().toString(),
                        onChanged: (value) {
                          setDialogState(() {
                            size = value;
                          });
                        },
                      ),
                    ),
                    Text('${size.round()}'),
                  ],
                ),
                Row(
                  children: [
                    const Text('Color: '),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Pick a color'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: color,
                                  onColorChanged: (newColor) {
                                    setDialogState(() {
                                      color = newColor;
                                    });
                                  },
                                  enableAlpha:
                                      false, // Optional: disables opacity slider
                                  displayThumbColor:
                                      true, // Optional: shows thumb color
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Done'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: color,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Animated: '),
                    Switch(
                      value: isAnimated,
                      onChanged: (value) {
                        setDialogState(() {
                          isAnimated = value;
                        });
                      },
                    ),
                  ],
                ),
                if (isAnimated)
                  DropdownButton<String>(
                    value: animationType,
                    items: const [
                      DropdownMenuItem(value: 'none', child: Text('None')),
                      DropdownMenuItem(value: 'bounce', child: Text('Bounce')),
                      DropdownMenuItem(value: 'fade', child: Text('Fade')),
                      DropdownMenuItem(value: 'rotate', child: Text('Rotate')),
                      DropdownMenuItem(value: 'scale', child: Text('Scale')),
                    ],
                    onChanged: (value) {
                      setDialogState(() {
                        animationType = value!;
                      });
                    },
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Sticker'),
                    content: const Text(
                        'Are you sure you want to delete this sticker?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            stickerItems.removeWhere(
                                (element) => element.id == item.id);

                            // Remove animation controller if it exists
                            if (_animationControllers.containsKey(item.id)) {
                              _animationControllers[item.id]?.dispose();
                              _animationControllers.remove(item.id);
                            }
                          });

                          Navigator.pop(context); // Close delete dialog
                          Navigator.pop(context); // Close edit dialog
                        },
                        child: const Text('Delete',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  final index = stickerItems
                      .indexWhere((element) => element.id == item.id);
                  if (index != -1) {
                    stickerItems[index].size = size;
                    stickerItems[index].color = color;
                    stickerItems[index].isAnimated = isAnimated;
                    stickerItems[index].animationType = animationType;

                    // Update animation if needed
                    if (isAnimated && animationType != 'none') {
                      _createAnimationController(item.id, animationType);
                    } else {
                      // Remove animation controller if it exists
                      if (_animationControllers.containsKey(item.id)) {
                        _animationControllers[item.id]?.dispose();
                        _animationControllers.remove(item.id);
                      }
                    }
                  }
                });

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      }),
    );
  }

  // ANIMATION METHODS
  void _createAnimationController(String itemId, String animationType) {
    // Dispose of existing controller if it exists
    if (_animationControllers.containsKey(itemId)) {
      _animationControllers[itemId]?.dispose();
      _animationControllers.remove(itemId);
    }

    // Create a new controller based on animation type
    AnimationController controller;
    switch (animationType) {
      case 'bounce':
        controller = AnimationController(
          vsync: this,
          duration: const Duration(seconds: 1),
          reverseDuration: const Duration(seconds: 1),
        )..repeat(reverse: true);
        break;
      case 'fade':
        controller = AnimationController(
          vsync: this,
          duration: const Duration(seconds: 2),
        )..repeat(reverse: true);
        break;
      case 'shake':
        controller = AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 500),
        )..repeat(reverse: true);
        break;
      case 'scale':
        controller = AnimationController(
          vsync: this,
          duration: const Duration(seconds: 1),
        )..repeat(reverse: true);
        break;
      case 'rotate':
        controller = AnimationController(
          vsync: this,
          duration: const Duration(seconds: 2),
        )..repeat();
        break;
      default:
        return; // No animation
    }

    _animationControllers[itemId] = controller;
  }

  Widget _applyAnimation(Widget child, String itemId, String animationType) {
    if (!_animationControllers.containsKey(itemId) || animationType == 'none') {
      return child;
    }

    final controller = _animationControllers[itemId]!;

    switch (animationType) {
      case 'bounce':
        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, sin(controller.value * pi) * 10),
              child: child,
            );
          },
          child: child,
        );
      case 'fade':
        return FadeTransition(
          opacity: Tween(begin: 0.5, end: 1.0).animate(controller),
          child: child,
        );
      case 'shake':
        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(sin(controller.value * pi * 2) * 5, 0),
              child: child,
            );
          },
          child: child,
        );
      case 'scale':
        return ScaleTransition(
          scale: Tween(begin: 0.8, end: 1.2).animate(controller),
          child: child,
        );
      case 'rotate':
        return RotationTransition(
          turns: controller,
          child: child,
        );
      default:
        return child;
    }
  }

  // IMAGE FILTER METHODS

  void _applyImageFilter() {
    if (_posterImage == null && widget.poster.images[0] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a poster image first.')),
      );
      return;
    }
    file = File(widget.poster.images[0]);
    if(_posterImage == null){
       widget.poster.toString().startsWith('http'); {
        Future<void> urlToFile(dynamic url) async {
          // 1. Fetch image data
          final uri = Uri.parse(url);
          final response = await http.get(uri);
          if (response.statusCode != 200) {
            throw Exception('Failed to download image: ${response.statusCode}');
          }
          final bytes = response.bodyBytes;

          // 2. Get a temporary directory
          final tempDir = await getTemporaryDirectory();

          // 3. Create a unique filename
          final fileName = uri.pathSegments.isNotEmpty
              ? uri.pathSegments.last
              : DateTime.now().millisecondsSinceEpoch.toString();

          final file = File('${tempDir.path}/$fileName');

          // 4. Write the bytes to the file
          await file.writeAsBytes(bytes, flush: true);

          _posterImage = file;

          print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$_posterImage');
        }

        urlToFile(widget.poster.images[0]);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Loading poster from URL...')),
        );
      };
    }

    // Store current values in case user cancels
    final currentFilter = _appliedFilter;
    final currentBrightness = _brightness;
    final currentContrast = _contrast;
    final currentSaturation = _saturation;

    // Show filter dialog
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Image Filters',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            // Reset values and close
                            setState(() {
                              _appliedFilter = currentFilter;
                              _brightness = currentBrightness;
                              _contrast = currentContrast;
                              _saturation = currentSaturation;
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Save the current values
                            Navigator.pop(context);
                          },
                          child: const Text('Apply'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Presets',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _filterOptions.length,
                    itemBuilder: (context, index) {
                      final filter = _filterOptions[index];
                      return GestureDetector(
                        onTap: () {
                          setModalState(() {
                            setState(() {
                              _appliedFilter = filter;
                            });
                          });
                        },
                        child: Container(
                          width: 80,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            border: _appliedFilter?.name == filter.name
                                ? Border.all(color: Colors.blue, width: 2)
                                : null,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(8),
                                  ),
                                  child: ColorFiltered(
                                    colorFilter: filter.filter,
                                    child: Image.file(
                                       _posterImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(8),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  filter.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Adjustments',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                // Brightness slider
                Row(
                  children: [
                    const SizedBox(width: 16),
                    const Icon(Icons.brightness_6),
                    const SizedBox(width: 8),
                    const Text('Brightness'),
                    Expanded(
                      child: Slider(
                        value: _brightness,
                        min: -1.0,
                        max: 1.0,
                        divisions: 20,
                        onChanged: (value) {
                          setModalState(() {
                            setState(() {
                              _brightness = value;
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
                // Contrast slider
                Row(
                  children: [
                    const SizedBox(width: 16),
                    const Icon(Icons.contrast),
                    const SizedBox(width: 8),
                    const Text('Contrast'),
                    Expanded(
                      child: Slider(
                        value: _contrast,
                        min: 0.5,
                        max: 2.0,
                        divisions: 15,
                        onChanged: (value) {
                          setModalState(() {
                            setState(() {
                              _contrast = value;
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
                // Saturation slider
                Row(
                  children: [
                    const SizedBox(width: 16),
                    const Icon(Icons.color_lens),
                    const SizedBox(width: 8),
                    const Text('Saturation'),
                    Expanded(
                      child: Slider(
                        value: _saturation,
                        min: 0.0,
                        max: 2.0,
                        divisions: 20,
                        onChanged: (value) {
                          setModalState(() {
                            setState(() {
                              _saturation = value;
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Preview
                Expanded(
                  child: Center(
                    child: ColorFiltered(
                      colorFilter: ColorFilter.matrix(
                        ColorFilterGenerator.brightnessAdjustMatrix(
                            _brightness),
                      ),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.matrix(
                          ColorFilterGenerator.contrastAdjustMatrix(_contrast),
                        ),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.matrix(
                            ColorFilterGenerator.saturationAdjustMatrix(
                                _saturation),
                          ),
                          child: _appliedFilter != null
                              ? ColorFiltered(
                                  colorFilter: ColorFilter.matrix(
                                      _appliedFilter!.matrix),
                                  child: Image.file(_posterImage ??= file,
                                      fit: BoxFit.contain),
                                )
                              : Image.file(_posterImage ??= file,
                                  fit: BoxFit.contain),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // BACKGROUND COLOR METHODS
  void _changeBackgroundColor() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setDialogState) {
        return AlertDialog(
          title: const Text('Background Color'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_useGradient)
                  ColorPicker(
                    pickerColor: _backgroundColor,
                    onColorChanged: (color) {
                      setDialogState(() {
                        _backgroundColor = color;
                      });
                    },
                    pickerAreaHeightPercent: 0.8,
                  ),
                if (_useGradient)
                  Column(
                    children: [
                      const Text('Gradient Color 1'),
                      ColorPicker(
                        pickerColor: _gradientColors[0],
                        onColorChanged: (color) {
                          setDialogState(() {
                            _gradientColors[0] = color;
                          });
                        },
                        pickerAreaHeightPercent: 0.4,
                      ),
                      const Text('Gradient Color 2'),
                      ColorPicker(
                        pickerColor: _gradientColors[1],
                        onColorChanged: (color) {
                          setDialogState(() {
                            _gradientColors[1] = color;
                          });
                        },
                        pickerAreaHeightPercent: 0.4,
                      ),
                    ],
                  ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text('Use Gradient: '),
                    Switch(
                      value: _useGradient,
                      onChanged: (value) {
                        setDialogState(() {
                          _useGradient = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Keep the selected colors and gradient option
                });
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            ),
          ],
        );
      }),
    );
  }

  // CONTACT INFO METHODS
  void _editContactInfo() {
    final TextEditingController controller =
        TextEditingController(text: contactInfoItem?.text);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Contact Information'),
        content: TextField(
          controller: controller,
          decoration:
              const InputDecoration(hintText: 'Enter contact information'),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _contactInfoController.text = controller.text;
                contactInfoItem?.text = controller.text;
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // SAVE AND EXPORT METHODS
  Future<void> _savePoster() async {
    try {
      // Request storage permission
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Storage permission is required to save the poster.')),
        );
        return;
      }

      // Capture the poster as image
      RenderRepaintBoundary boundary = _posterKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        final buffer = byteData.buffer.asUint8List();

        // Get app directory
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = 'poster_${DateTime.now().millisecondsSinceEpoch}.png';
        final file = File('${appDir.path}/$fileName');

        // Save file
        await file.writeAsBytes(buffer);

        // Save to gallery
        final mediaStorePlugin = MediaStore();

// await mediaStorePlugin.saveFile(
//   tempFilePath: file.path,
//   dirType: DirType.pictures,   // ✅ use 'pictures' for images
//   dirName: 'Posters',          // ✅ OK as string (creates Posters folder inside Pictures)
// );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Poster saved to gallery as $fileName')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save poster: $e')),
      );
    }
  }

  Future<void> _sharePoster() async {
    try {
      // Capture the poster as image
      RenderRepaintBoundary boundary = _posterKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        final buffer = byteData.buffer.asUint8List();

        // Get temporary directory
        final tempDir = await getTemporaryDirectory();
        final fileName = 'poster_${DateTime.now().millisecondsSinceEpoch}.png';
        final file = File('${tempDir.path}/$fileName');

        // Save file
        await file.writeAsBytes(buffer);

        // Share file
        await Share.shareXFiles([XFile(file.path)],
            text: 'Check out my poster!');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to share poster: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Default dimensions (if posterSize is null)
    double posterWidth = screenWidth;
    double posterHeight = screenHeight * 0.7;

    // If we have a posterSize, calculate appropriate dimensions
    if (widget.posterSize != null) {
      // Extract dimensions from size string (format: "width*height")
      final sizeString = widget.posterSize!.size;
      final parts = sizeString.split('*');

      if (parts.length == 2) {
        double width = double.tryParse(parts[0]) ?? 0;
        double height = double.tryParse(parts[1]) ?? 0;

        if (width > 0 && height > 0) {
          // Keep aspect ratio but fit within screen
          double aspectRatio = width / height;

          // Calculate max height and width while maintaining aspect ratio
          if (aspectRatio > 1) {
            // Wider than tall
            posterWidth = min(screenWidth, screenWidth * 0.9);
            posterHeight = posterWidth / aspectRatio;
          } else {
            // Taller than wide
            posterHeight = min(screenHeight * 0.7, screenHeight * 0.6);
            posterWidth = posterHeight * aspectRatio;
          }
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poster Maker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _savePoster,
            tooltip: 'Save Poster',
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _sharePoster,
            tooltip: 'Share Poster',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: RepaintBoundary(
                key: _posterKey,
                child: Container(
                  width: posterWidth,
                  height: posterHeight,
                  decoration: BoxDecoration(
                    color: (!_useGradient && widget.poster.images.isEmpty)
                        ? _backgroundColor
                        : null,
                    gradient: _useGradient && widget.poster.images.isEmpty
                        ? LinearGradient(
                            colors: _gradientColors,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    image: widget.poster.images.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage('https://posterbnaobackend.onrender.com${widget.poster.images[0]}'),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: Stack(
                    children: [
                      // Background image with filters
                      if (_posterImage != null)
                        Positioned.fill(
                          child: ColorFiltered(
                            colorFilter: ColorFilter.matrix(
                              ColorFilterGenerator.brightnessAdjustMatrix(
                                  _brightness),
                            ),
                            child: ColorFiltered(
                              colorFilter: ColorFilter.matrix(
                                ColorFilterGenerator.contrastAdjustMatrix(
                                    _contrast),
                              ),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.matrix(
                                  ColorFilterGenerator.saturationAdjustMatrix(
                                      _saturation),
                                ),
                                child: _appliedFilter != null
                                    ? ColorFiltered(
                                        colorFilter: ColorFilter.matrix(
                                            _appliedFilter!.matrix),
                                        child: Image.file(_posterImage!,
                                            fit: BoxFit.cover),
                                      )
                                    : Image.file(_posterImage!,
                                        fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),

                      // Social media icons
                      ...socialIcons
                          .map((item) => Positioned(
                                left: item.position.dx,
                                top: item.position.dy,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedItemId = item.id;
                                      _selectedItemType = 'icon';
                                    });
                                  },
                                  child: DraggableWidget(
                                    item: item,
                                    child: _applyAnimation(
                                      Container(
                                        decoration: BoxDecoration(
                                          border: _selectedItemId == item.id
                                              ? Border.all(
                                                  color: Colors.blue, width: 2)
                                              : null,
                                        ),
                                        child: item.child,
                                      ),
                                      item.id,
                                      item.animationType,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),

                      // Logo
                      if (logoItem != null)
                        Positioned(
                          left: logoItem!.position.dx,
                          top: logoItem!.position.dy,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedItemId = logoItem!.id;
                                _selectedItemType = 'logo';
                                _showLogoOptions(); // Show options when logo is tapped
                              });
                            },
                            child: DraggableWidget(
                              item: logoItem!,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // The actual logo container
                                  Container(
                                    width: 100 *
                                        logoItem!.scale, // Apply scale to width
                                    height: 100 *
                                        logoItem!
                                            .scale, // Apply scale to height
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: _selectedItemId == logoItem!.id
                                          ? Border.all(
                                              color: Colors.blue, width: 2)
                                          : null,
                                    ),
                                    child: ClipOval(
                                      child: logoItem!.child,
                                    ),
                                  ),

                                  // Show resize handles when logo is selected
                                  if (_selectedItemId == logoItem!.id)
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: GestureDetector(
                                        onPanUpdate: (details) {
                                          final double newScale =
                                              logoItem!.scale +
                                                  details.delta.dx * 0.01;
                                          // Constrain scale to reasonable bounds
                                          if (newScale >= 0.5 &&
                                              newScale <= 3.0) {
                                            setState(() {
                                              logoItem!.scale = newScale;
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.open_with,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      if (picItem != null)
                        Positioned(
                          left: picItem!.position.dx,
                          top: picItem!.position.dy,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedItemId = picItem!.id;
                                _selectedItemType = 'pic';
                                _showPicOptions(); // Show options when logo is tapped
                              });
                            },
                            child: DraggableWidget(
                              item: picItem!,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // The actual logo container
                                  Container(
                                    width: 100 *
                                        picItem!.scale, // Apply scale to width
                                    height: 100 *
                                        picItem!.scale, // Apply scale to height
                                    decoration: BoxDecoration(
                                      border: _selectedItemId == picItem!.id
                                          ? Border.all(
                                              color: Colors.blue, width: 2)
                                          : null,
                                    ),
                                    child: picItem!.child,
                                  ),

                                  // Show resize handles when logo is selected
                                  if (_selectedItemId == picItem!.id)
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: GestureDetector(
                                        onPanUpdate: (details) {
                                          final double newScale =
                                              picItem!.scale +
                                                  details.delta.dx * 0.01;
                                          // Constrain scale to reasonable bounds
                                          if (newScale >= 0.5 &&
                                              newScale <= 3.0) {
                                            setState(() {
                                              picItem!.scale = newScale;
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.open_with,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      // Text items
                      ...textItems
                          .map((item) => Positioned(
                                left: item.position.dx,
                                top: item.position.dy,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedItemId = item.id;
                                      _selectedItemType = 'text';
                                    });
                                    _editTextItem(item);
                                  },
                                  child: DraggableWidget(
                                    item: item,
                                    child: _applyAnimation(
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: item.bgColor,
                                          border: _selectedItemId == item.id
                                              ? Border.all(
                                                  color: Colors.blue, width: 2)
                                              : null,
                                        ),
                                        child: Text(
                                          item.text,
                                          style: TextStyle(
                                            fontSize: item.fontSize,
                                            fontWeight: item.fontWeight,
                                            color: item.textColor,
                                          ),
                                        ),
                                      ),
                                      item.id,
                                      item.animationType,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),

                      // Sticker items
                      ...stickerItems
                          .map((item) => Positioned(
                                left: item.position.dx,
                                top: item.position.dy,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedItemId = item.id;
                                      _selectedItemType = 'sticker';
                                    });
                                    _editStickerItem(item);
                                  },
                                  child: DraggableWidget(
                                    item: item,
                                    child: _applyAnimation(
                                      Container(
                                        decoration: BoxDecoration(
                                          border: _selectedItemId == item.id
                                              ? Border.all(
                                                  color: Colors.blue, width: 2)
                                              : null,
                                        ),
                                        child: Icon(
                                          item.icon,
                                          size: item.size,
                                          color: item.color,
                                        ),
                                      ),
                                      item.id,
                                      item.animationType,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),

                      // Contact info (always at bottom)
                      if (contactInfoItem != null)
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedItemId = contactInfoItem!.id;
                                _selectedItemType = 'contact';
                              });
                              _editContactInfo();
                            },
                            child: DraggableWidget(
                              item: contactInfoItem!,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(4),
                                  border: _selectedItemId == contactInfoItem!.id
                                      ? Border.all(color: Colors.blue, width: 2)
                                      : null,
                                ),
                                child: Text(
                                  contactInfoItem!.text,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: Colors.grey.shade200,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildToolButton(
                    icon: Icons.image,
                    label: 'Background',
                    onPressed: _pickPosterImage,
                  ),
                  _buildToolButton(
                    icon: Icons.photo_filter,
                    label: 'Filter',
                    onPressed: _applyImageFilter,
                  ),
                  _buildToolButton(
                    icon: Icons.color_lens,
                    label: 'Color',
                    onPressed: _changeBackgroundColor,
                  ),
                  _buildToolButton(
                    icon: Icons.text_fields,
                    label: 'Add Text',
                    onPressed: _addNewText,
                  ),
                  _buildToolButton(
                    icon: Icons.emoji_emotions,
                    label: 'Stickers',
                    onPressed: _addSticker,
                  ),
                  _buildToolButton(
                    icon: Icons.business,
                    label: 'Logo',
                    onPressed: _pickLogoImage,
                  ),
                  _buildToolButton(
                    icon: Icons.contact_phone,
                    label: 'Contact',
                    onPressed: _editContactInfo,
                  ),
                  _buildToolButton(
                    icon: Icons.camera,
                    label: 'Add Image',
                    onPressed: _pickImage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(icon),
            onPressed: onPressed,
            tooltip: label,
          ),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}


class DraggableWidget extends StatelessWidget {
  final dynamic item;
  final Widget child;

  const DraggableWidget({
    super.key,
    required this.item,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        item.onPositionChanged(Offset(
          item.position.dx + details.delta.dx,
          item.position.dy + details.delta.dy,
        ));
      },
      child: Transform.rotate(
        angle: item.rotation,
        child: child,
      ),
    );
  }
}

class DraggableItem {
  final String id;
  final Widget child;
  Offset position;
  double rotation;
  double scale;
  bool isAnimated;
  String animationType;
  final Function(Offset) onPositionChanged;

  DraggableItem({
    required this.id,
    required this.child,
    required this.position,
    required this.rotation,
    required this.scale,
    required this.isAnimated,
    required this.animationType,
    required this.onPositionChanged,
  });
}

class DraggableTextItem {
  final String id;
  String text;
  Offset position;
  double fontSize;
  FontWeight fontWeight;
  Color textColor;
  Color bgColor;
  double rotation;
  bool isAnimated;
  String animationType;
  final Function(Offset) onPositionChanged;

  DraggableTextItem({
    required this.id,
    required this.text,
    required this.position,
    required this.fontSize,
    required this.fontWeight,
    required this.textColor,
    required this.bgColor,
    required this.rotation,
    required this.isAnimated,
    required this.animationType,
    required this.onPositionChanged,
  });
}

class DraggableStickerItem {
  final String id;
  final String stickerType;
  final IconData icon;
  Offset position;
  double size;
  Color color;
  double rotation;
  bool isAnimated;
  String animationType;
  final Function(Offset) onPositionChanged;

  DraggableStickerItem({
    required this.id,
    required this.stickerType,
    required this.icon,
    required this.position,
    required this.size,
    required this.color,
    required this.rotation,
    required this.isAnimated,
    required this.animationType,
    required this.onPositionChanged,
  });
}

// Preset filters
// final List<Filter> presetFilters = [
//   ColorFilterGenerator.addFilter('None', <double>[
//     1,
//     0,
//     0,
//     0,
//     0,
//     0,
//     1,
//     0,
//     0,
//     0,
//     0,
//     0,
//     1,
//     0,
//     0,
//     0,
//     0,
//     0,
//     1,
//     0,
//   ]),
//   ColorFilterGenerator.addFilter('Sepia', <double>[
//     0.393,
//     0.769,
//     0.189,
//     0,
//     0,
//     0.349,
//     0.686,
//     0.168,
//     0,
//     0,
//     0.272,
//     0.534,
//     0.131,
//     0,
//     0,
//     0,
//     0,
//     0,
//     1,
//     0,
//   ]),
//   ColorFilterGenerator.addFilter('Grayscale', <double>[
//     0.2126,
//     0.7152,
//     0.0722,
//     0,
//     0,
//     0.2126,
//     0.7152,
//     0.0722,
//     0,
//     0,
//     0.2126,
//     0.7152,
//     0.0722,
//     0,
//     0,
//     0,
//     0,
//     0,
//     1,
//     0,
//   ]),
//   ColorFilterGenerator.addFilter('Vintage', <double>[
//     0.9,
//     0.5,
//     0.1,
//     0,
//     0,
//     0.3,
//     0.8,
//     0.1,
//     0,
//     0,
//     0.2,
//     0.3,
//     0.5,
//     0,
//     0,
//     0,
//     0,
//     0,
//     1,
//     0,
//   ]),
//   ColorFilterGenerator.addFilter('Cold', <double>[
//     0.8,
//     0,
//     0,
//     0,
//     0,
//     0,
//     1,
//     0,
//     0,
//     0,
//     0,
//     0,
//     1.2,
//     0,
//     0,
//     0,
//     0,
//     0,
//     1,
//     0,
//   ]),
//   ColorFilterGenerator.addFilter('Warm', <double>[
//     1.2,
//     0,
//     0,
//     0,
//     0,
//     0,
//     1.0,
//     0,
//     0,
//     0,
//     0,
//     0,
//     0.8,
//     0,
//     0,
//     0,
//     0,
//     0,
//     1,
//     0,
//   ]),
// ];

// class ColorFilterGenerator {
//   static Filter addFilter(String name, List<double> matrix) {
//     return Filter(name: name, matrix: matrix);
//   }

//   static List<double> brightnessAdjustMatrix(double value) {
//     return <double>[
//       1,
//       0,
//       0,
//       0,
//       value,
//       0,
//       1,
//       0,
//       0,
//       value,
//       0,
//       0,
//       1,
//       0,
//       value,
//       0,
//       0,
//       0,
//       1,
//       0,
//     ];
//   }

//   static List<double> contrastAdjustMatrix(double value) {
//     final double v = value;
//     final double o = -(128 * v) + 128;
//     return <double>[
//       v,
//       0,
//       0,
//       0,
//       o,
//       0,
//       v,
//       0,
//       0,
//       o,
//       0,
//       0,
//       v,
//       0,
//       o,
//       0,
//       0,
//       0,
//       1,
//       0,
//     ];
//   }

//   static List<double> saturationAdjustMatrix(double value) {
//     final double v = value;
//     final double invSat = 1 - v;
//     final double R = 0.213 * invSat;
//     final double G = 0.715 * invSat;
//     final double B = 0.072 * invSat;

//     return <double>[
//       R + v,
//       G,
//       B,
//       0,
//       0,
//       R,
//       G + v,
//       B,
//       0,
//       0,
//       R,
//       G,
//       B + v,
//       0,
//       0,
//       0,
//       0,
//       0,
//       1,
//       0,
//     ];
//   }
// }

class Filter {
  final String name;
  final List<double> matrix;

  Filter({required this.name, required this.matrix});
}

class FilterOption {
  final String name;
  final ColorFilter filter;
  final List<double> matrix;

  FilterOption({
    required this.name,
    required this.filter,
    required this.matrix,
  });
}

class ColorFilterGenerator {
  static List<double> brightnessAdjustMatrix(double value) {
    return [
      1,
      0,
      0,
      0,
      value,
      0,
      1,
      0,
      0,
      value,
      0,
      0,
      1,
      0,
      value,
      0,
      0,
      0,
      1,
      0,
    ];
  }

  static List<double> contrastAdjustMatrix(double value) {
    final v = value;
    final o = (1.0 - v) * 0.5;
    return [
      v,
      0,
      0,
      0,
      o,
      0,
      v,
      0,
      0,
      o,
      0,
      0,
      v,
      0,
      o,
      0,
      0,
      0,
      1,
      0,
    ];
  }

  static List<double> saturationAdjustMatrix(double value) {
    final v = value;
    final r = 0.2126 * (1 - v);
    final g = 0.7152 * (1 - v);
    final b = 0.0722 * (1 - v);
    return [
      r + v,
      g,
      b,
      0,
      0,
      r,
      g + v,
      b,
      0,
      0,
      r,
      g,
      b + v,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ];
  }
}
