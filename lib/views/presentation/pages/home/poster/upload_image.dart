// import 'dart:async';
// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:company_project/views/presentation/pages/home/poster/animated_screen.dart';
// import 'package:company_project/views/presentation/pages/home/poster/filter_screen.dart';

// class UploadImage extends StatefulWidget {
//   const UploadImage({super.key});

//   @override
//   State<UploadImage> createState() => _UploadImageState();
// }

// class _UploadImageState extends State<UploadImage> {
//   List<File> _selectedImages = [];
//   int _currentIndex = 0;
//   Timer? _timer;

//   Future<void> pickImages() async {
//     final result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       type: FileType.image,
//     );

//     if (result != null && result.paths.isNotEmpty) {
//       setState(() {
//         _selectedImages = result.paths.map((path) => File(path!)).toList();
//         startSlideshow();
//       });
//     }
//   }

//   void startSlideshow() {
//     _timer?.cancel(); // Cancel previous timers
//     _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
//       if (_selectedImages.isEmpty) return;

//       setState(() {
//         _currentIndex = (_currentIndex + 1) % _selectedImages.length;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     pickImages(); // Automatically pick images when page opens
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     icon: const Icon(Icons.arrow_back_ios),
//                   ),
//                   const Spacer(),
//                   Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 51, 68, 196),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: const Icon(Icons.share, color: Colors.white),
//                   ),
//                   const SizedBox(width: 10),
//                   Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 51, 68, 196),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: const Icon(Icons.download_sharp, color: Colors.white),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Center(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: _selectedImages.isEmpty
//                       ? Image.network(
//                           'https://s3-alpha-sig.figma.com/img/1fa6/8002/d5fce3019c9d28c19b64aab8d8ba4732?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=DyTFsqO4tkNV-ZokVOWGcbtsBU5EJrbJ6U~IkZjFFbD4aoz2tgR3HNHIQNmb6YQ4S-810VtYIUzaYIc~7jo5BE3aANJx3nPUzIWggaJ9g5-IngkXmqZsFoTEMKL-EiOrE2eX0TYXora15YlQwZpBZqGz-1bjViV28wmPkYnCMsvR~T2J9l0IMnhb4Xm569y9aQagV7~BALuB6ndplmgAbhkaLt~-4ULU0aFukJpFtULcppSsqfLRmMPGELmj853IG1mXRQSSrFHSx-kg5mvT5R2nH5lEqnLLMUQX-dkc1aoxqAMlp7pc6286ph7N02eWgP-qspjRyFpKuFLKnxszRw__',
//                           width: 420,
//                           height: 400,
//                           fit: BoxFit.cover,
//                         )
//                       : Image.file(
//                           _selectedImages[_currentIndex],
//                           width: 420,
//                           height: 400,
//                           fit: BoxFit.cover,
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.black,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white70,
//         selectedFontSize: 14,
//         unselectedFontSize: 12,
//         iconSize: 27,
//         items: <BottomNavigationBarItem>[
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.wb_incandescent_outlined),
//             label: 'Upload Image',
//           ),
//           BottomNavigationBarItem(
//             icon: GestureDetector(
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => FilterScreen()));
//               },
//               child: const Icon(Icons.wb_incandescent_outlined),
//             ),
//             label: 'Filter',
//           ),
//           BottomNavigationBarItem(
//             icon: GestureDetector(
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const AnimatedScreen()));
//               },
//               child: const Icon(Icons.movie_creation_outlined),
//             ),
//             label: 'Animation',
//           ),
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.volume_up_outlined),
//             label: 'Audio',
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  List<File> _images = [];
  int _currentIndex = 0;
  final ImagePicker _picker = ImagePicker();
  Timer? _imageTimer;
  bool _isPlaying = false;
  
  // Timer related variables
  int _elapsedSeconds = 0;
  Timer? _secondTimer;
  bool _showControls = true;

  // Duration per image in milliseconds
  final int _durationPerImageMs = 1600;

  @override
  void initState() {
    super.initState();
    // Automatically open image picker when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pickMultipleImages();
    });
  }

  @override
  void dispose() {
    _imageTimer?.cancel();
    _secondTimer?.cancel();
    super.dispose();
  }

  Future<void> pickMultipleImages() async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage();
      
      if (pickedFiles.isNotEmpty) {
        setState(() {
          _images = pickedFiles.map((file) => File(file.path)).toList();
          _currentIndex = 0;
          _isPlaying = true;
          _elapsedSeconds = 0;
        });
        
        // Start auto-playing the images as a video
        _startVideoPlayback();
        _startTimer();
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  void _startVideoPlayback() {
    _imageTimer?.cancel();
    
    if (_images.length > 1) {
      _imageTimer = Timer.periodic(Duration(milliseconds: _durationPerImageMs), (timer) {
        if (mounted) {
          setState(() {
            if (_currentIndex < _images.length - 1) {
              _currentIndex++;
            } else {
              // At the end of the video, pause playback
              _currentIndex = _images.length - 1;
              _isPlaying = false;
              timer.cancel();
              _secondTimer?.cancel();
            }
          });
        }
      });
    }
  }

  void _startTimer() {
    _secondTimer?.cancel();
    _secondTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted && _isPlaying) {
        setState(() {
          // Calculate elapsed seconds based on current index
          _elapsedSeconds = (_currentIndex * _durationPerImageMs / 1000).round();
          
          // If we've reached the end, stop the timer
          if (_currentIndex >= _images.length - 1) {
            _elapsedSeconds = (_images.length * _durationPerImageMs / 1000).round();
            timer.cancel();
          }
        });
      }
    });
  }

  void _togglePlayback() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    
    if (_isPlaying) {
      // If we're at the end, start over
      if (_currentIndex >= _images.length - 1) {
        setState(() {
          _currentIndex = 0;
          _elapsedSeconds = 0;
        });
      }
      _startVideoPlayback();
      _startTimer();
    } else {
      _imageTimer?.cancel();
      _secondTimer?.cancel();
    }
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  // Format seconds into MM:SS
  String _formatDuration(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Calculate estimated total duration based on number of images and transition time
  String _getTotalDuration() {
    final totalSeconds = (_images.length * (_durationPerImageMs / 1000)).round();
    return _formatDuration(totalSeconds);
  }

  // Calculate total duration in seconds
  int _getTotalDurationInSeconds() {
    return (_images.length * (_durationPerImageMs / 1000)).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      const Spacer(),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 51, 68, 196),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.share, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 51, 68, 196),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.download_sharp, color: Colors.white),
                      ),
                    ],
                  ),
              ),
              const SizedBox(height: 120),
              
              if (_images.isNotEmpty)
                GestureDetector(
                  onTap: _toggleControls,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Image display
                      Container(
                        height: 400, // Reduced height to prevent overflow
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _images[_currentIndex],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      
                      // Play/pause button overlay (shown only when controls are visible)
                      if (_showControls)
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 36,
                            ),
                            onPressed: _togglePlayback,
                          ),
                        ),
                      
                      // YouTube style bottom controls bar (shown only when controls are visible)
                      if (_showControls)
                        Positioned(
                          bottom: 0,
                          left: 16,
                          right: 16,
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.7),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Progress bar with time on right
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    children: [
                                      // Play/pause button
                                      SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: IconButton(
                                          iconSize: 16,
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: Icon(
                                            _isPlaying ? Icons.pause : Icons.play_arrow,
                                            color: Colors.white,
                                          ),
                                          onPressed: _togglePlayback,
                                        ),
                                      ),
                                      
                                      // Progress bar
                                      Expanded(
                                        child: SliderTheme(
                                          data: SliderThemeData(
                                            trackHeight: 2,
                                            thumbShape: const RoundSliderThumbShape(
                                              enabledThumbRadius: 6,
                                            ),
                                            overlayShape: const RoundSliderOverlayShape(
                                              overlayRadius: 10,
                                            ),
                                            activeTrackColor: Colors.red,
                                            inactiveTrackColor: Colors.grey.withOpacity(0.5),
                                            thumbColor: Colors.red,
                                          ),
                                          child: Slider(
                                            value: _currentIndex.toDouble(),
                                            min: 0,
                                            max: (_images.length - 1).toDouble(),
                                            onChanged: (value) {
                                              setState(() {
                                                _currentIndex = value.toInt();
                                                // Update time based on slider position
                                                _elapsedSeconds = (_currentIndex * _durationPerImageMs / 1000).round();
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      
                                      // Time display on right
                                      Text(
                                        '${_formatDuration(_elapsedSeconds)} / ${_getTotalDuration()}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              else
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 150),
                      Icon(Icons.movie, size: 80, color: Colors.grey[300]),
                      const SizedBox(height: 20),
                      const Text('No images selected'),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: pickMultipleImages,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 51, 68, 196),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                        child: const Text('Select Images for Video'),
                      ),
                    ],
                  ),
                ),
              
              // Add space at bottom to prevent overflow
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        iconSize: 27,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_incandescent_outlined),
            label: 'Filter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation_outlined),
            label: 'Animation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volume_up_outlined),
            label: 'Audio',
          ),
        ],
      ),
    );
  }
}