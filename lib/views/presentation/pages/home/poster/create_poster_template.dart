import 'dart:io';

import 'package:company_project/helper/storage_helper.dart';
import 'package:company_project/models/editor_item.dart';
import 'package:company_project/models/poster_model.dart';
import 'package:company_project/models/poster_size_model.dart';
import 'package:company_project/models/poster_template_model.dart';
import 'package:company_project/views/presentation/pages/home/Logo/brand_info_screen.dart';
import 'package:company_project/views/presentation/pages/home/poster/add_element_screen.dart';
import 'package:company_project/views/presentation/pages/home/poster/add_image.dart';
import 'package:company_project/views/presentation/pages/home/poster/add_shape.dart';
import 'package:company_project/views/presentation/pages/home/poster/animation_screen.dart';
import 'package:company_project/views/presentation/pages/home/poster/audio_screen.dart';
import 'package:company_project/views/presentation/pages/home/poster/brand_info_poster.dart';
import 'package:company_project/views/presentation/pages/home/poster/brand_screen.dart';
import 'package:company_project/views/presentation/pages/home/poster/effect_screen.dart';
import 'package:company_project/views/presentation/widgets/bottom_navbar.dart';
import 'package:company_project/views/presentation/widgets/poster_brandinfo_widget.dart';
import 'package:company_project/views/presentation/widgets/sticker_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class LayerItem {
  final String id;
  final String name;
  bool isVisible;
  final String? imageUrl;
  final Widget? content;

  LayerItem({
    required this.id,
    required this.name,
    this.isVisible = true,
    this.imageUrl,
    this.content,
  });
}

class BottomNavbarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const BottomNavbarItem({
    Key? key,
    required this.icon,
    required this.label,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? Colors.amber : Colors.white,
          size: isActive ? 28 : 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.amber : Colors.white,
            fontSize: isActive ? 12 : 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class PosterTemplate extends StatefulWidget {
  final bool isCustom;
  final TemplateModel? poster; // Passed when selecting an existing poster
  final PosterSize? customSize; // Passed when creating a custom poster

  const PosterTemplate({
    Key? key,
    required this.isCustom,
    this.poster,
    this.customSize,
  }) : super(key: key);

  @override
  State<PosterTemplate> createState() => _PosterTemplateState();
}

class _PosterTemplateState extends State<PosterTemplate>
    with SingleTickerProviderStateMixin {
  final ScreenshotController screenshotController = ScreenshotController();
  final GlobalKey _canvasKey = GlobalKey();
  double _sliderPosition = 150;
  bool _showLayerSlider = false;
  String _backgroundImage = '';
  Color _backgroundColor = Colors.white;
  final List<EditorItem> _editorItems = [];
  EditorItem? _selectedItem;
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Audio player
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _selectedAudioPath;
  bool _isAudioPlaying = false;

  // Animation properties
  String? _selectedAnimation;
  double _animationDuration = 1.0; // seconds

  // Active tool state
  String _activeTool = 'text'; // Default tool

  List<LayerItem> _layers = [];
  // String? _userData;
  // String? _userName;
  String? _userNumber;
  String? _email;
  String? _sitename;

  File? _logoFile;

  // Text effects properties
  double _textShadowOffset = 1.0;
  Color _textShadowColor = Colors.black.withOpacity(0.3);
  double _textShadowBlur = 2.0;

  // For multitouch scaling
  double _baseScaleFactor = 1.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _initializeLayers();
    _loadUserData();

    if (widget.poster != null && widget.poster!.images.isNotEmpty) {
      _backgroundImage = widget.poster!.images[0];
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _sitename = prefs.getString('user_site_name') ?? "Site name";
        _email = prefs.getString('user_email') ?? "email";
        _userNumber = prefs.getString('user_phone') ?? "9876543210";
      });
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }
  }

  void _initializeLayers() {
    _layers = [
      LayerItem(
        id: 'header',
        name: 'Header',
        isVisible: true,
        content: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.transparent,
          child: const Row(
            children: [
              Icon(Icons.star, color: Colors.amber),
              SizedBox(width: 5),
              Text(
                'Respect and Humble Tribute',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      LayerItem(
        id: 'logo',
        name: 'Logo',
        isVisible: true,
        imageUrl: 'YOUR LOGO HERE',
      ),
      LayerItem(
        id: 'person',
        name: 'Person Image',
        isVisible: true,
        imageUrl: 'https://example.com/person.jpg',
      ),
      LayerItem(
        id: 'title',
        name: 'Title Text',
        isVisible: true,
        content: const Text(
          'RASHTRASANT\nTUKDOJI MAHARAJ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
      LayerItem(
        id: 'subtitle',
        name: 'Subtitle',
        isVisible: true,
        content: Text(
          'ON HIS BIRTH ANNIVERSARY',
          style: TextStyle(fontSize: 14),
        ),
      ),
      LayerItem(
        id: 'business',
        name: 'Business Info',
        isVisible: true,
        content: Column(
          children: [
            Text(
              _sitename ?? 'www.abc.com',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16),
                    Text(_email??'abc@gmail.com',
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.phone, size: 16),
                    Text(_userNumber ?? '9876543210',
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      LayerItem(
        id: 'background',
        name: 'Background',
        isVisible: true,
      ),
    ];
  }

  void _toggleLayerVisibility(String layerId) {
    setState(() {
      final layerIndex = _layers.indexWhere((layer) => layer.id == layerId);
      if (layerIndex != -1) {
        _layers[layerIndex].isVisible = !_layers[layerIndex].isVisible;
      }
    });
  }

  Future<void> _downloadPoster() async {
    try {
      // First capture the screenshot
      final Uint8List? imageBytes = await screenshotController.capture();
      if (imageBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to capture poster')),
        );
        return;
      }

      // Request permissions
      if (Platform.isAndroid) {
        final status = await Permission.storage.request();
        if (!status.isGranted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('Storage permission is required to save the poster')),
          );
          return;
        }
      } else if (Platform.isIOS) {
        final status = await Permission.photos.request();
        if (!status.isGranted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('Photos permission is required to save the poster')),
          );
          return;
        }
      }

      // Save to gallery
      // final result = await ImageGallerySaver.saveImage(
      //   imageBytes,
      //   quality: 100,
      //   name: "Poster_${DateTime.now().millisecondsSinceEpoch}",
      // );

      // if (result['isSuccess']) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Poster saved successfully!'),
      //       backgroundColor: Colors.green,
      //     ),
      //   );
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text('Failed to save poster: ${result['errorMessage'] ?? "Unknown error"}'),
      //       backgroundColor: Colors.red,
      //     ),
      //   );
      // }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving poster: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickLogo() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _logoFile = File(image.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking logo: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting logo: $e')),
      );
    }
  }

  void _toggleAudioPlayback() {
    if (_selectedAudioPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an audio file first')),
      );
      return;
    }

    setState(() {
      _isAudioPlaying = !_isAudioPlaying;
    });

    if (_isAudioPlaying) {
      _audioPlayer.play(DeviceFileSource(_selectedAudioPath!));
    } else {
      _audioPlayer.pause();
    }
  }

  void _applyAnimation(String animationType, double duration) {
    setState(() {
      _selectedAnimation = animationType;
      _animationDuration = duration;

      // Reset and restart animation
      _animationController.duration =
          Duration(milliseconds: (duration * 1000).toInt());
      _animationController.reset();
      _animationController.forward();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$animationType animation applied')),
    );
  }

  void _openBackgroundColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Background Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _backgroundColor,
              onColorChanged: (Color color) {
                setState(() {
                  _backgroundColor = color;
                });
              },
              pickerAreaHeightPercent: 0.8,
              enableAlpha: true,
              displayThumbColor: true,
              showLabel: true,
              paletteType: PaletteType.hsv,
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
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showLayerSlider = !_showLayerSlider;
                          });
                        },
                        child: const Icon(Icons.layers),
                      ),
                      const Spacer(),
                      if (_selectedAudioPath != null)
                        IconButton(
                          icon: Icon(
                            _isAudioPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_fill,
                            color: Colors.blue,
                          ),
                          onPressed: _toggleAudioPlayback,
                        ),
                      InkWell(
                        onTap: _downloadPoster,
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF5C6BC0),
                                Color.fromARGB(255, 127, 81, 255)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.download_for_offline_sharp,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Download',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          // Deselect when tapping on the background
                          setState(() {
                            if (_selectedItem != null) {
                              _selectedItem!.isSelected = false;
                              _selectedItem = null;
                            }
                          });
                        },
                        onScaleStart: (details) {
                          if (_selectedItem != null) {
                            _baseScaleFactor = _selectedItem!.scale;
                          }
                        },
                        onScaleUpdate: (details) {
                          if (_selectedItem != null) {
                            setState(() {
                              // Apply scaling
                              _selectedItem!.scale =
                                  _baseScaleFactor * details.scale;

                              // Limit scale range
                              if (_selectedItem!.scale < 0.5)
                                _selectedItem!.scale = 0.5;
                              if (_selectedItem!.scale > 3.0)
                                _selectedItem!.scale = 3.0;
                            });
                          }
                        },
                        child: Screenshot(
                          controller: screenshotController,
                          child: Container(
                            key: _canvasKey,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: _buildPosterCanvas(),
                                ),
                                if (_layers
                                    .firstWhere((layer) => layer.id == 'header',
                                        orElse: () => LayerItem(
                                            id: 'not-found',
                                            name: 'Not Found',
                                            isVisible: false))
                                    .isVisible)
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    right: 10,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: _pickLogo,
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border:
                                                  Border.all(color: Colors.red),
                                              image: _logoFile != null
                                                  ? DecorationImage(
                                                      image:
                                                          FileImage(_logoFile!),
                                                      fit: BoxFit.cover,
                                                    )
                                                  : null,
                                            ),
                                            child: _logoFile == null
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .add_photo_alternate,
                                                          size: 16,
                                                          color: Colors.red),
                                                      Text(
                                                        'LOGO',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.red),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  )
                                                : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (_layers
                                    .firstWhere((layer) => layer.id == 'person',
                                        orElse: () => LayerItem(
                                            id: 'not-found',
                                            name: 'Not Found',
                                            isVisible: false))
                                    .isVisible)
                                  Positioned(
                                    top: 80,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.orange, width: 3),
                                          image:const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                'https://s3-alpha-sig.figma.com/img/9cf6/9546/ebfe8be7faa0bcece189903d1e14b4d7?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=YGwJR0j8WDu-tfa~nvJd90b9coqrtqXsWyqXePok5XUXvpyN5lVWahW33A5oomX6R05rIsJnDgFouHZMy3-~iGFbdXhbaupOkOAtNM2p3O6o9iBJDeil8qfb519bIUiu-7dZBHmy~y~UUOf-eymwdj9ikjqOY~XTlycxvxcZJE3rwdcZg6pAptH6Kw~nVTymvMpIq~eLrcrq2vLxVdWVhw7jNLHAZkpfIe0jCALLAgmQ5nyZNvMqRwmnAcpSKxwjudRM0ZsDqcCUukmupdFSNCB8fbpurIjoTK7v9KR6S0WCkv5MpzD0sJiXfsXGVLHK80RHO69RMXtGZAPhRsRNkQ__'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (_layers
                                    .firstWhere((layer) => layer.id == 'title',
                                        orElse: () => LayerItem(
                                            id: 'not-found',
                                            name: 'Not Found',
                                            isVisible: false))
                                    .isVisible)
                                  // Positioned(
                                  //   top: 210,
                                  //   left: 0,
                                  //   right: 0,
                                  //   child: Center(
                                  //     child: Text(
                                  //       'RASHTRASANT\nTUKDOJI MAHARAJ',
                                  //       textAlign: TextAlign.center,
                                  //       style: TextStyle(
                                  //         fontSize: 20,
                                  //         fontWeight: FontWeight.bold,
                                  //         color: Colors.green,
                                  //         shadows: [
                                  //           Shadow(
                                  //             offset: Offset(_textShadowOffset, _textShadowOffset),
                                  //             blurRadius: _textShadowBlur,
                                  //             color: _textShadowColor,
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  if (_layers
                                      .firstWhere(
                                          (layer) => layer.id == 'subtitle',
                                          orElse: () => LayerItem(
                                              id: 'not-found',
                                              name: 'Not Found',
                                              isVisible: false))
                                      .isVisible)
                                    // Positioned(
                                    //   top: 260,
                                    //   left: 0,
                                    //   right: 0,
                                    //   child: Center(
                                    //     child: Text(
                                    //       'ON HIS BIRTH ANNIVERSARY',
                                    //       style: TextStyle(fontSize: 14),
                                    //     ),
                                    //   ),
                                    // ),
                                    if (_layers
                                        .firstWhere(
                                            (layer) => layer.id == 'business',
                                            orElse: () => LayerItem(
                                                id: 'not-found',
                                                name: 'Not Found',
                                                isVisible: false))
                                        .isVisible)
                                      Positioned(
                                        bottom: 20,
                                        left: 10,
                                        right: 10,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 5),
                                            Container(
                                              height: 35,
                                             
                                              decoration: BoxDecoration(
                                                
                                                color: const Color.fromARGB(255, 163, 153, 143)
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BrandInfo()));
                                                    },
                                                    child: Text(
                                                       _email??'abc@gmail.com',
                                                      style:const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.email,
                                                          size: 16),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BrandInfo()));
                                                        },
                                                        child: Text(_sitename??'www.abc.com',
                                                            style: TextStyle(
                                                                fontSize: 12)),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.phone, size: 16),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BrandInfo()));
                                                        },
                                                        child: Text(
                                                            _userNumber ??
                                                                '8051281283',
                                                            style: TextStyle(
                                                                fontSize: 12)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                ..._editorItems
                                    .map((item) => _buildEditorItem(item)),
                                if (_selectedItem != null)
                                  _buildSelectionControls(_selectedItem!),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    color: Colors.black,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _activeTool = 'text';
                              });
                              showAddTextBottomSheet(context);
                            },
                            child: BottomNavbarItem(
                              icon: Icons.text_fields,
                              label: 'Text',
                              isActive: _activeTool == 'text',
                            ),
                          ),
                          const SizedBox(width: 24),
                          // GestureDetector(
                          //   onTap: () async {
                          //     setState(() {
                          //       _activeTool = 'audio';
                          //     });

                          //     final result = await Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => const AudioScreen()
                          //       ),
                          //     );

                          //     if (result != null && result is String) {
                          //       setState(() {
                          //         _selectedAudioPath = result;
                          //       });

                          //       // Start playing the audio
                          //       _audioPlayer.play(DeviceFileSource(_selectedAudioPath!));
                          //       _isAudioPlaying = true;

                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //         const SnackBar(
                          //           content: Text('Audio added to poster'),
                          //           backgroundColor: Colors.green,
                          //         ),
                          //       );
                          //     }
                          //   },
                          //   child: BottomNavbarItem(
                          //     icon: Icons.music_note,
                          //     label: 'Audio',
                          //     isActive: _activeTool == 'audio',
                          //   ),
                          // ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                _activeTool = 'animation';
                              });

                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AnimationScreen()),
                              );

                              if (result != null &&
                                  result is Map<String, dynamic>) {
                                _applyAnimation(result['animationType'],
                                    result['duration']);
                              }
                            },
                            child: BottomNavbarItem(
                              icon: Icons.animation,
                              label: 'Animation',
                              isActive: _activeTool == 'animation',
                            ),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () async {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>BrandInfoScreenposter()));

                              setState(() {
                                _activeTool = 'brand';
                              });

                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BrandInfo()),
                              );
                              if (result != null &&
                                  result is Map<String, dynamic>) {
                                setState(() {
                                  if (result.containsKey('email')) {
                                    _email = result['email'];
                                  }
                                  if (result.containsKey('phoneNumber')) {
                                    _userNumber = result['phoneNumber'];
                                  }
                                  if (result.containsKey('site')) {
                                    _sitename = result['site'];
                                  }
                                });
                              }
                            },
                            child: BottomNavbarItem(
                              icon: Icons.info_outline,
                              label: 'Brand Info',
                              isActive: _activeTool == 'brand',
                            ),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                _activeTool = 'sticker';
                              });

                              final result = await showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20))),
                                  builder: (context) => const StickerPicker());

                              if (result != null) {
                                _addStickerItem('assets/unnamed.png');
                              }
                            },
                            child: BottomNavbarItem(
                              icon: Icons.emoji_emotions_outlined,
                              label: 'Sticker',
                              isActive: _activeTool == 'sticker',
                            ),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _activeTool = 'effects';
                              });

                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                backgroundColor: Colors.white,
                                isScrollControlled: true,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setModalState) {
                                      return Container(
                                        padding: const EdgeInsets.all(20),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Text Effects',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            const Text('Shadow Offset',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Slider(
                                              value: _textShadowOffset,
                                              min: 0,
                                              max: 10,
                                              divisions: 20,
                                              label: _textShadowOffset
                                                  .toStringAsFixed(1),
                                              onChanged: (value) {
                                                setModalState(() {
                                                  _textShadowOffset = value;
                                                });
                                                setState(() {
                                                  _textShadowOffset = value;
                                                });
                                              },
                                            ),
                                            const SizedBox(height: 10),
                                            const Text('Shadow Blur',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Slider(
                                              value: _textShadowBlur,
                                              min: 0,
                                              max: 20,
                                              divisions: 20,
                                              label: _textShadowBlur
                                                  .toStringAsFixed(1),
                                              onChanged: (value) {
                                                setModalState(() {
                                                  _textShadowBlur = value;
                                                });
                                                setState(() {
                                                  _textShadowBlur = value;
                                                });
                                              },
                                            ),
                                            const SizedBox(height: 10),
                                            const Text('Shadow Color',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            const SizedBox(height: 10),
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Pick Shadow Color'),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: ColorPicker(
                                                          pickerColor:
                                                              _textShadowColor,
                                                          onColorChanged:
                                                              (Color color) {
                                                            setModalState(() {
                                                              _textShadowColor =
                                                                  color;
                                                            });
                                                            setState(() {
                                                              _textShadowColor =
                                                                  color;
                                                            });
                                                          },
                                                          pickerAreaHeightPercent:
                                                              0.8,
                                                          enableAlpha: true,
                                                          displayThumbColor:
                                                              true,
                                                          showLabel: true,
                                                          paletteType:
                                                              PaletteType.hsv,
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: const Text(
                                                              'Done'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: _textShadowColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            const Text('Background Color',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            const SizedBox(height: 10),
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Pick Background Color'),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: ColorPicker(
                                                          pickerColor:
                                                              _backgroundColor,
                                                          onColorChanged:
                                                              (Color color) {
                                                            setModalState(() {
                                                              _backgroundColor =
                                                                  color;
                                                            });
                                                            setState(() {
                                                              _backgroundColor =
                                                                  color;
                                                            });
                                                          },
                                                          pickerAreaHeightPercent:
                                                              0.8,
                                                          enableAlpha: true,
                                                          displayThumbColor:
                                                              true,
                                                          showLabel: true,
                                                          paletteType:
                                                              PaletteType.hsv,
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: const Text(
                                                              'Done'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: _backgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blue,
                                                  foregroundColor: Colors.white,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 12),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child:
                                                    const Text('Apply Effects'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: BottomNavbarItem(
                              icon: Icons.auto_fix_high,
                              label: 'Effects',
                              isActive: _activeTool == 'effects',
                            ),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _activeTool = 'background';
                              });
                              _openBackgroundColorPicker();
                            },
                            child: BottomNavbarItem(
                              icon: Icons.format_color_fill,
                              label: 'Background',
                              isActive: _activeTool == 'background',
                            ),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                _activeTool = 'image';
                              });

                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AddImageScreen()),
                              );

                              if (result != null && result is String) {
                                setState(() {
                                  _backgroundImage = result;
                                });
                              }
                            },
                            child: BottomNavbarItem(
                              icon: Icons.image,
                              label: 'Image',
                              isActive: _activeTool == 'image',
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Layer slider panel
              // if (_showLayerSlider)
              //   Positioned(
              //     right: 0,
              //     top: 70,
              //     bottom: 100,
              //     width: 250,
              //     child: Container(
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.black.withOpacity(0.2),
              //             blurRadius: 10,
              //             spreadRadius: 1,
              //           ),
              //         ],
              //         borderRadius: const BorderRadius.only(
              //           topLeft: Radius.circular(15),
              //           bottomLeft: Radius.circular(15),
              //         ),
              //       ),
              //       padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               const Text(
              //                 'Layers',
              //                 style: TextStyle(
              //                   fontSize: 18,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //               IconButton(
              //                 icon: const Icon(Icons.close),
              //                 onPressed: () {
              //                   setState(() {
              //                     _showLayerSlider = false;
              //                   });
              //                 },
              //               ),
              //             ],
              //           ),
              //           const Divider(),
              //           Expanded(
              //             child: ListView.builder(
              //               itemCount: _layers.length,
              //               itemBuilder: (context, index) {
              //                 final layer = _layers[index];
              //                 return ListTile(
              //                   title: Text(layer.name),
              //                   leading: IconButton(
              //                     icon: Icon(
              //                       layer.isVisible ? Icons.visibility : Icons.visibility_off,
              //                       color: layer.isVisible ? Colors.blue : Colors.grey,
              //                     ),
              //                     onPressed: () {
              //                       _toggleLayerVisibility(layer.id);
              //                     },
              //                   ),
              //                   dense: true,
              //                 );
              //               },
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPosterCanvas() {
    return Container(
      width: _selectedAnimation == null ? double.infinity : null,
      height: _selectedAnimation == null ? null : null,
      alignment: Alignment.center,
      color: _backgroundColor,
      child: _selectedAnimation != null
          ? _buildAnimatedPoster()
          : (_backgroundImage.isNotEmpty)
              ? Image.network(
                  _backgroundImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                )
              : Container(color: _backgroundColor),
    );
  }

  Widget _buildAnimatedPoster() {
    switch (_selectedAnimation) {
      case 'Fade In':
        return FadeTransition(
          opacity: _animation,
          child: Container(
            color: _backgroundColor,
            width: double.infinity,
            height: double.infinity,
            child: _backgroundImage.isNotEmpty
                ? Image.network(
                    _backgroundImage,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        );
      case 'Zoom In':
        return ScaleTransition(
          scale: _animation,
          child: Container(
            color: _backgroundColor,
            width: double.infinity,
            height: double.infinity,
            child: _backgroundImage.isNotEmpty
                ? Image.network(
                    _backgroundImage,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        );
      case 'Slide In':
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(_animationController),
          child: Container(
            color: _backgroundColor,
            width: double.infinity,
            height: double.infinity,
            child: _backgroundImage.isNotEmpty
                ? Image.network(
                    _backgroundImage,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        );
      case 'Rotate':
        return RotationTransition(
          turns: _animation,
          child: Container(
            color: _backgroundColor,
            width: double.infinity,
            height: double.infinity,
            child: _backgroundImage.isNotEmpty
                ? Image.network(
                    _backgroundImage,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        );
      default:
        return Container(
          color: _backgroundColor,
          width: double.infinity,
          height: double.infinity,
          child: _backgroundImage.isNotEmpty
              ? Image.network(
                  _backgroundImage,
                  fit: BoxFit.cover,
                )
              : null,
        );
    }
  }

  Widget _buildEditorItem(EditorItem item) {
    return Positioned(
      left: item.position.dx,
      top: item.position.dy,
      child: GestureDetector(
        onTap: () {
          setState(() {
            // Deselect previous item
            if (_selectedItem != null) {
              _selectedItem!.isSelected = false;
            }
            // Select this item
            item.isSelected = true;
            _selectedItem = item;
          });
        },
        onPanUpdate: (details) {
          setState(() {
            item.position = Offset(
              item.position.dx + details.delta.dx,
              item.position.dy + details.delta.dy,
            );
          });
        },
        child: Transform.scale(
          scale: item.scale,
          child: item.child,
        ),
      ),
    );
  }

  Widget _buildSelectionControls(EditorItem item) {
    return Positioned(
      left: item.position.dx - 10,
      top: item.position.dy - 10,
      child: Container(
        width: 150 * item.scale + 20, // Approximation of size
        height: 50 * item.scale + 20, // Approximation of size
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: [
            // Delete button
            Positioned(
              right: -5,
              top: -5,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _editorItems.remove(item);
                    _selectedItem = null;
                  });
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
            // Rotate button
            Positioned(
              bottom: -5,
              right: -5,
              child: GestureDetector(
                onTap: () {
                  // Implement rotation logic
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.rotate_right,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAddTextBottomSheet(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    Color selectedColor = Colors.black;
    double fontSize = 20;
    String fontFamily = 'Roboto';
    FontWeight fontWeight = FontWeight.normal;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add Text',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your text here',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  const Text('Font Size',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  Slider(
                    value: fontSize,
                    min: 12,
                    max: 40,
                    divisions: 28,
                    label: fontSize.round().toString(),
                    onChanged: (value) {
                      setModalState(() {
                        fontSize = value;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Color',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Pick a color'),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: selectedColor,
                                    onColorChanged: (Color color) {
                                      setModalState(() {
                                        selectedColor = color;
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
                            color: selectedColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text('Font Style',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFontStyleOption(
                          'Regular',
                          fontWeight == FontWeight.normal,
                          () {
                            setModalState(() {
                              fontWeight = FontWeight.normal;
                            });
                          },
                        ),
                        _buildFontStyleOption(
                          'Bold',
                          fontWeight == FontWeight.bold,
                          () {
                            setModalState(() {
                              fontWeight = FontWeight.bold;
                            });
                          },
                        ),
                        _buildFontStyleOption(
                          'Italic',
                          false, // Add a state variable for italic if needed
                          () {
                            // Implement italic toggle
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Font Family',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFontFamilyOption(
                          'Roboto',
                          fontFamily == 'Roboto',
                          () {
                            setModalState(() {
                              fontFamily = 'Roboto';
                            });
                          },
                        ),
                        _buildFontFamilyOption(
                          'Poppins',
                          fontFamily == 'Poppins',
                          () {
                            setModalState(() {
                              fontFamily = 'Poppins';
                            });
                          },
                        ),
                        _buildFontFamilyOption(
                          'Montserrat',
                          fontFamily == 'Montserrat',
                          () {
                            setModalState(() {
                              fontFamily = 'Montserrat';
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        if (textController.text.isNotEmpty) {
                          _addTextItem(
                            textController.text,
                            fontSize,
                            selectedColor,
                            fontFamily,
                            fontWeight,
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Add Text'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFontStyleOption(
      String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildFontFamilyOption(
      String fontFamily, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          fontFamily,
          style: TextStyle(
            fontFamily: fontFamily,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  void _addTextItem(
    String text,
    double fontSize,
    Color color,
    String fontFamily,
    FontWeight fontWeight,
  ) {
    final size = MediaQuery.of(context).size;
    setState(() {
      _editorItems.add(
        EditorItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          position: Offset(size.width / 4, size.height / 4),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: color,
              fontFamily: fontFamily,
              fontWeight: fontWeight,
              shadows: [
                Shadow(
                  offset: Offset(_textShadowOffset, _textShadowOffset),
                  blurRadius: _textShadowBlur,
                  color: _textShadowColor,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void _addStickerItem(String stickerAsset) {
    final size = MediaQuery.of(context).size;
    setState(() {
      _editorItems.add(
        EditorItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          position: Offset(size.width / 4, size.height / 4),
          child: Image.asset(
            stickerAsset,
            width: 100,
            height: 100,
          ),
        ),
      );
    });
  }
}

class StickerPicker extends StatelessWidget {
  const StickerPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> stickers = [
      'assets/unnamed.png',
      'assets/unnamed.png',
      'assets/unnamed.png',
      'assets/unnamed.png',
      'assets/unnamed.png',
      'assets/unnamed.png',
      'assets/unnamed.png',
      'assets/unnamed.png',
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Sticker',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: stickers.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context, stickers[index]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      stickers[index],
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



class PosterEditor extends StatefulWidget {
  final String email;
  final String phoneNumber;
  final String sitename;

  const PosterEditor({
    Key? key,
    required this.email,
    required this.phoneNumber,
    required this.sitename,
  }) : super(key: key);

  @override
  _PosterEditorState createState() => _PosterEditorState();
}

class _PosterEditorState extends State<PosterEditor>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final List<EditorItem> _editorItems = [];
  EditorItem? _selectedItem;
  Color _backgroundColor = Colors.white;
  String _backgroundImage = '';
  String _activeTool = '';
  double _textShadowOffset = 2.0;
  double _textShadowBlur = 4.0;
  Color _textShadowColor = Colors.black.withOpacity(0.5);
  String? _selectedAnimation;
  bool _showLayerSlider = false;
  final List<Layer> _layers = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    // Add business details as text items
    _addBusinessInfo();

    // Initialize layers
    _initLayers();
  }

  void _addBusinessInfo() {
    final size = MediaQuery.of(context).size;

    // Add business name
    _editorItems.add(
      EditorItem(
        id: 'email',
        position: Offset(size.width / 4, size.height / 6),
        child: Text(
          widget.email,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );

    // Add phone number
    _editorItems.add(
      EditorItem(
        id: 'phone_number',
        position: Offset(size.width / 4, size.height / 6 + 40),
        child: Text(
          'Phone: ${widget.phoneNumber}',
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );

    // Add address
    _editorItems.add(
      EditorItem(
        id: 'site',
        position: Offset(size.width / 4, size.height / 6 + 70),
        child: Text(
          'Address: ${widget.sitename}',
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }

  void _initLayers() {
    // Add default layers
    _layers.add(Layer(id: 'background', name: 'Background', isVisible: true));
    _layers.add(Layer(id: 'content', name: 'Content', isVisible: true));
    _layers.add(
        Layer(id: 'business_info', name: 'Business Info', isVisible: true));
  }

  void _toggleLayerVisibility(String layerId) {
    setState(() {
      final layerIndex = _layers.indexWhere((layer) => layer.id == layerId);
      if (layerIndex != -1) {
        _layers[layerIndex].isVisible = !_layers[layerIndex].isVisible;
      }
    });
  }

  void _openBackgroundColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a background color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _backgroundColor,
              onColorChanged: (Color color) {
                setState(() {
                  _backgroundColor = color;
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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poster Editor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Implement save functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Poster saved to gallery'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Implement share functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sharing poster...'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.layers),
            onPressed: () {
              setState(() {
                _showLayerSlider = !_showLayerSlider;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Poster canvas
            Positioned.fill(
              child: _buildPosterCanvas(),
            ),

            // Editor items
            ..._editorItems.map((item) => _buildEditorItem(item)),

            // Selection controls for selected item
            if (_selectedItem != null && _selectedItem!.isSelected)
              _buildSelectionControls(_selectedItem!),

            // Bottom controls
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 80,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _activeTool = 'text';
                            });
                            showAddTextBottomSheet(context);
                          },
                          child: BottomNavbarItem(
                            icon: Icons.text_fields,
                            label: 'Text',
                            isActive: _activeTool == 'text',
                          ),
                        ),
                        const SizedBox(width: 24),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _activeTool = 'sticker';
                            });
                            final result = await showModalBottomSheet(
                              context: context,
                              builder: (context) => const StickerPicker(),
                            );
                            if (result != null) {
                              _addStickerItem(result);
                            }
                          },
                          child: BottomNavbarItem(
                            icon: Icons.emoji_emotions,
                            label: 'Stickers',
                            isActive: _activeTool == 'sticker',
                          ),
                        ),
                        const SizedBox(width: 24),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _activeTool = 'effects';
                            });
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setModalState) {
                                    return Container(
                                      padding: const EdgeInsets.all(20),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Text Effects',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          const Text('Shadow Offset',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500)),
                                          Slider(
                                            value: _textShadowOffset,
                                            min: 0,
                                            max: 10,
                                            divisions: 20,
                                            label: _textShadowOffset
                                                .toStringAsFixed(1),
                                            onChanged: (value) {
                                              setModalState(() {
                                                _textShadowOffset = value;
                                              });
                                              setState(() {
                                                _textShadowOffset = value;
                                              });
                                            },
                                          ),
                                          const SizedBox(height: 10),
                                          const Text('Shadow Blur',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500)),
                                          Slider(
                                            value: _textShadowBlur,
                                            min: 0,
                                            max: 20,
                                            divisions: 20,
                                            label: _textShadowBlur
                                                .toStringAsFixed(1),
                                            onChanged: (value) {
                                              setModalState(() {
                                                _textShadowBlur = value;
                                              });
                                              setState(() {
                                                _textShadowBlur = value;
                                              });
                                            },
                                          ),
                                          const SizedBox(height: 10),
                                          const Text('Shadow Color',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500)),
                                          const SizedBox(height: 10),
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Pick Shadow Color'),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: ColorPicker(
                                                        pickerColor:
                                                            _textShadowColor,
                                                        onColorChanged:
                                                            (Color color) {
                                                          setModalState(() {
                                                            _textShadowColor =
                                                                color;
                                                          });
                                                          setState(() {
                                                            _textShadowColor =
                                                                color;
                                                          });
                                                        },
                                                        pickerAreaHeightPercent:
                                                            0.8,
                                                        enableAlpha: true,
                                                        displayThumbColor: true,
                                                        showLabel: true,
                                                        paletteType:
                                                            PaletteType.hsv,
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child:
                                                            const Text('Done'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: _textShadowColor,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          const Text('Background Color',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500)),
                                          const SizedBox(height: 10),
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Pick Background Color'),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: ColorPicker(
                                                        pickerColor:
                                                            _backgroundColor,
                                                        onColorChanged:
                                                            (Color color) {
                                                          setModalState(() {
                                                            _backgroundColor =
                                                                color;
                                                          });
                                                          setState(() {
                                                            _backgroundColor =
                                                                color;
                                                          });
                                                        },
                                                        pickerAreaHeightPercent:
                                                            0.8,
                                                        enableAlpha: true,
                                                        displayThumbColor: true,
                                                        showLabel: true,
                                                        paletteType:
                                                            PaletteType.hsv,
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child:
                                                            const Text('Done'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: _backgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                foregroundColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child:
                                                  const Text('Apply Effects'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: BottomNavbarItem(
                            icon: Icons.auto_fix_high,
                            label: 'Effects',
                            isActive: _activeTool == 'effects',
                          ),
                        ),
                        const SizedBox(width: 24),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _activeTool = 'background';
                            });
                            _openBackgroundColorPicker();
                          },
                          child: BottomNavbarItem(
                            icon: Icons.format_color_fill,
                            label: 'Background',
                            isActive: _activeTool == 'background',
                          ),
                        ),
                        const SizedBox(width: 24),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _activeTool = 'image';
                            });

                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddImageScreen()),
                            );

                            if (result != null && result is String) {
                              setState(() {
                                _backgroundImage = result;
                              });
                            }
                          },
                          child: BottomNavbarItem(
                            icon: Icons.image,
                            label: 'Image',
                            isActive: _activeTool == 'image',
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Layer slider panel
            if (_showLayerSlider)
              Positioned(
                right: 0,
                top: 70,
                bottom: 100,
                width: 250,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Layers',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                _showLayerSlider = false;
                              });
                            },
                          ),
                        ],
                      ),
                      const Divider(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _layers.length,
                          itemBuilder: (context, index) {
                            final layer = _layers[index];
                            return ListTile(
                              title: Text(layer.name),
                              leading: IconButton(
                                icon: Icon(
                                  layer.isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: layer.isVisible
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  _toggleLayerVisibility(layer.id);
                                },
                              ),
                              dense: true,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPosterCanvas() {
    return Container(
      width: _selectedAnimation == null ? double.infinity : null,
      height: _selectedAnimation == null ? null : null,
      alignment: Alignment.center,
      color: _backgroundColor,
      child: _selectedAnimation != null
          ? _buildAnimatedPoster()
          : (_backgroundImage.isNotEmpty)
              ? Image.network(
                  _backgroundImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                )
              : Container(color: _backgroundColor),
    );
  }

  Widget _buildAnimatedPoster() {
    switch (_selectedAnimation) {
      case 'Fade In':
        return FadeTransition(
          opacity: _animation,
          child: Container(
            color: _backgroundColor,
            width: double.infinity,
            height: double.infinity,
            child: _backgroundImage.isNotEmpty
                ? Image.network(
                    _backgroundImage,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        );
      case 'Zoom In':
        return ScaleTransition(
          scale: _animation,
          child: Container(
            color: _backgroundColor,
            width: double.infinity,
            height: double.infinity,
            child: _backgroundImage.isNotEmpty
                ? Image.network(
                    _backgroundImage,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        );
      case 'Slide In':
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(_animationController),
          child: Container(
            color: _backgroundColor,
            width: double.infinity,
            height: double.infinity,
            child: _backgroundImage.isNotEmpty
                ? Image.network(
                    _backgroundImage,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        );
      case 'Rotate':
        return RotationTransition(
          turns: _animation,
          child: Container(
            color: _backgroundColor,
            width: double.infinity,
            height: double.infinity,
            child: _backgroundImage.isNotEmpty
                ? Image.network(
                    _backgroundImage,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        );
      default:
        return Container(
          color: _backgroundColor,
          width: double.infinity,
          height: double.infinity,
          child: _backgroundImage.isNotEmpty
              ? Image.network(
                  _backgroundImage,
                  fit: BoxFit.cover,
                )
              : null,
        );
    }
  }

  Widget _buildEditorItem(EditorItem item) {
    return Positioned(
      left: item.position.dx,
      top: item.position.dy,
      child: GestureDetector(
        onTap: () {
          setState(() {
            // Deselect previous item
            if (_selectedItem != null) {
              _selectedItem!.isSelected = false;
            }
            // Select this item
            item.isSelected = true;
            _selectedItem = item;
          });
        },
        onPanUpdate: (details) {
          setState(() {
            item.position = Offset(
              item.position.dx + details.delta.dx,
              item.position.dy + details.delta.dy,
            );
          });
        },
        child: Transform.scale(
          scale: item.scale,
          child: item.child,
        ),
      ),
    );
  }

  Widget _buildSelectionControls(EditorItem item) {
    return Positioned(
      left: item.position.dx - 10,
      top: item.position.dy - 10,
      child: Container(
        width: 150 * item.scale + 20, // Approximation of size
        height: 50 * item.scale + 20, // Approximation of size
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: [
            // Delete button
            Positioned(
              right: -5,
              top: -5,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _editorItems.remove(item);
                    _selectedItem = null;
                  });
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
            // Rotate button
            Positioned(
              bottom: -5,
              right: -5,
              child: GestureDetector(
                onTap: () {
                  // Implement rotation logic
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.rotate_right,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAddTextBottomSheet(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    Color selectedColor = Colors.black;
    double fontSize = 20;
    String fontFamily = 'Roboto';
    FontWeight fontWeight = FontWeight.normal;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add Text',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your text here',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  const Text('Font Size',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  Slider(
                    value: fontSize,
                    min: 12,
                    max: 40,
                    divisions: 28,
                    label: fontSize.round().toString(),
                    onChanged: (value) {
                      setModalState(() {
                        fontSize = value;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Color',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Pick a color'),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: selectedColor,
                                    onColorChanged: (Color color) {
                                      setModalState(() {
                                        selectedColor = color;
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
                            color: selectedColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text('Font Style',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFontStyleOption(
                          'Regular',
                          fontWeight == FontWeight.normal,
                          () {
                            setModalState(() {
                              fontWeight = FontWeight.normal;
                            });
                          },
                        ),
                        _buildFontStyleOption(
                          'Bold',
                          fontWeight == FontWeight.bold,
                          () {
                            setModalState(() {
                              fontWeight = FontWeight.bold;
                            });
                          },
                        ),
                        _buildFontStyleOption(
                          'Italic',
                          fontWeight == FontWeight.w300,
                          () {
                            setModalState(() {
                              fontWeight = FontWeight.w300;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Font Family',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFontFamilyOption(
                          'Roboto',
                          fontFamily == 'Roboto',
                          () {
                            setModalState(() {
                              fontFamily = 'Roboto';
                            });
                          },
                        ),
                        _buildFontFamilyOption(
                          'Montserrat',
                          fontFamily == 'Montserrat',
                          () {
                            setModalState(() {
                              fontFamily = 'Montserrat';
                            });
                          },
                        ),
                        _buildFontFamilyOption(
                          'Playfair',
                          fontFamily == 'Playfair',
                          () {
                            setModalState(() {
                              fontFamily = 'Playfair';
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        if (textController.text.isNotEmpty) {
                          final newItem = EditorItem(
                            id: 'text_${DateTime.now().millisecondsSinceEpoch}',
                            position: Offset(
                              MediaQuery.of(context).size.width / 4,
                              MediaQuery.of(context).size.height / 4,
                            ),
                            child: Text(
                              textController.text,
                              style: TextStyle(
                                fontSize: fontSize,
                                color: selectedColor,
                                fontWeight: fontWeight,
                                fontFamily: fontFamily,
                                shadows: [
                                  Shadow(
                                    offset: Offset(
                                        _textShadowOffset, _textShadowOffset),
                                    blurRadius: _textShadowBlur,
                                    color: _textShadowColor,
                                  ),
                                ],
                              ),
                            ),
                          );

                          setState(() {
                            _editorItems.add(newItem);
                          });

                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Add Text'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFontStyleOption(
      String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildFontFamilyOption(
      String family, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          family,
          style: TextStyle(
            fontFamily: family,
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _addStickerItem(String stickerPath) {
    final newItem = EditorItem(
      id: 'sticker_${DateTime.now().millisecondsSinceEpoch}',
      position: Offset(
        MediaQuery.of(context).size.width / 4,
        MediaQuery.of(context).size.height / 4,
      ),
      child: Image.asset(
        stickerPath,
        width: 80,
        height: 80,
      ),
    );

    setState(() {
      _editorItems.add(newItem);
      _selectedItem = newItem;
      _selectedItem!.isSelected = true;
    });
  }
}

class EditorItem {
  final String id;
  Offset position;
  final Widget child;
  bool isSelected;
  double scale;
  double rotation;

  EditorItem({
    required this.id,
    required this.position,
    required this.child,
    this.isSelected = false,
    this.scale = 1.0,
    this.rotation = 0.0,
  });
}

class Layer {
  final String id;
  final String name;
  bool isVisible;

  Layer({
    required this.id,
    required this.name,
    this.isVisible = true,
  });
}

// class BottomNavbarItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final bool isActive;

//   const BottomNavbarItem({
//     Key? key,
//     required this.icon,
//     required this.label,
//     this.isActive = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(
//           icon,
//           color: isActive ? Colors.blue : Colors.grey,
//           size: 28,
//         ),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(
//             color: isActive ? Colors.blue : Colors.grey,
//             fontSize: 12,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class StickerPicker extends StatelessWidget {
//   const StickerPicker({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Mock sticker data
//     final stickerCategories = [
//       {
//         'name': 'Emojis',
//         'stickers': [
//           'assets/stickers/emoji1.png',
//           'assets/stickers/emoji2.png',
//           'assets/stickers/emoji3.png',
//           'assets/stickers/emoji4.png',
//         ],
//       },
//       {
//         'name': 'Shapes',
//         'stickers': [
//           'assets/stickers/shape1.png',
//           'assets/stickers/shape2.png',
//           'assets/stickers/shape3.png',
//           'assets/stickers/shape4.png',
//         ],
//       },
//       {
//         'name': 'Icons',
//         'stickers': [
//           'assets/stickers/icon1.png',
//           'assets/stickers/icon2.png',
//           'assets/stickers/icon3.png',
//           'assets/stickers/icon4.png',
//         ],
//       },
//     ];

//     return DefaultTabController(
//       length: stickerCategories.length,
//       child: Column(
//         children: [
//           TabBar(
//             tabs: stickerCategories.map((category) => Tab(text: category['name'] as String)).toList(),
//             labelColor: Colors.blue,
//             unselectedLabelColor: Colors.grey,
//             indicatorColor: Colors.blue,
//           ),
//           Expanded(
//             child: TabBarView(
//               children: stickerCategories.map((category) {
//                 return GridView.count(
//                   crossAxisCount: 4,
//                   padding: const EdgeInsets.all(16),
//                   children: (category['stickers'] as List<String>).map((sticker) {
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context, sticker);
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey.shade300),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Image.asset(
//                           sticker,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class AddImageScreen extends StatelessWidget {
  const AddImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock image data
    final backgroundImages = [
      'https://picsum.photos/id/10/800/1200',
      'https://picsum.photos/id/20/800/1200',
      'https://picsum.photos/id/30/800/1200',
      'https://picsum.photos/id/40/800/1200',
      'https://picsum.photos/id/50/800/1200',
      'https://picsum.photos/id/60/800/1200',
      'https://picsum.photos/id/70/800/1200',
      'https://picsum.photos/id/80/800/1200',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Background Image'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Select a background image',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: backgroundImages.map((imageUrl) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context, imageUrl);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
