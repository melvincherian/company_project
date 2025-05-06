import 'dart:io';
import 'dart:async';
// import 'dart:ui' as ui;
import 'package:company_project/views/presentation/pages/home/video/audio_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as math;
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

// Filter model
enum FilterType {
  none,
  blackWhite,
  watercolor,
  snow,
  waterDrops,
}

// Animation model
enum AnimationType {
  none,
  leftRight,
  upDown,
  window,
  gradient,
  transition,
  thaw,
  scale,
}

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  List<File> _images = [];
  List<File> _processedImages = []; // Filtered images
  int _currentIndex = 0;
  final ImagePicker _picker = ImagePicker();
  Timer? _imageTimer;
  bool _isPlaying = false;

  AudioTrack? _selectedAudio;
  AudioPlayer? _backgroundAudioPlayer;

  // Timer related variables
  int _elapsedSeconds = 0;
  Timer? _secondTimer;
  bool _showControls = true;

  // Filter and animation related
  FilterType _selectedFilter = FilterType.none;
  AnimationType _selectedAnimation = AnimationType.none;
  bool _showFilters = false;
  bool _showAnimations = false;
  bool _processingImages = false;

  // Animation controller
  double _animationValue = 0.2;
  Timer? _animationTimer;

  // Duration per image in milliseconds
  final int _durationPerImageMs = 3000;

  @override
  void initState() {
    super.initState();
    // Automatically open image picker when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pickInitialImages();
    });
  }

  @override
  void dispose() {
    _imageTimer?.cancel();
    _secondTimer?.cancel();
    _animationTimer?.cancel();
    super.dispose();
  }
  
  Future<void> _pickInitialImages() async {
    try {
      final List<XFile>? pickedFiles = await _picker.pickMultiImage();

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        setState(() {
          _images = pickedFiles.map((file) => File(file.path)).toList();
          _processedImages = List.from(_images); // Start with original images
          _currentIndex = 0;
          _isPlaying = true;
          _elapsedSeconds = 0;
        });

        // Start auto-playing the images as a video
        _startVideoPlayback();
        _startTimer();
        // Start animation if one is selected
        if (_selectedAnimation != AnimationType.none) {
          _startAnimationTimer();
        }
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }




  void _openEditImagesScreen() {
    // Pause playback when going to edit screen
    _imageTimer?.cancel();
    _secondTimer?.cancel();
    _animationTimer?.cancel();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditImagesScreen(
          existingImages: _images,
          onComplete: (updatedImages) {
            // This will be called when the user presses Done
            setState(() {
              _images = updatedImages;
              // If using filters, we need to reprocess the images
              if (_selectedFilter != FilterType.none) {
                _applySelectedFilter();
              } else {
                _processedImages = List.from(_images);
              }

              // If no images remain, reset to default state
              if (_images.isEmpty) {
                _isPlaying = false;
                _currentIndex = 0;
                _elapsedSeconds = 0;
              } else {
                // Make sure current index is valid
                _currentIndex = _currentIndex.clamp(0, _images.length - 1);
                _isPlaying = true;
                // Restart playback
                _startVideoPlayback();
                _startTimer();
                // Restart animation if needed
                if (_selectedAnimation != AnimationType.none) {
                  _startAnimationTimer();
                }
              }
            });
          },
        ),
      ),
    );
  }

  void _startVideoPlayback() {
    _imageTimer?.cancel();

    if (_images.length > 1) {
      _imageTimer = Timer.periodic(
        Duration(milliseconds: _durationPerImageMs),
        (timer) {
          if (mounted) {
            setState(() {
              if (_currentIndex < _images.length - 1) {
                _currentIndex++;
                // Reset animation value for transition effects
                if (_selectedAnimation == AnimationType.transition) {
                  _animationValue = 0.0;
                }
              } else {
                // At the end of the video, pause playback
                _currentIndex = 0; // Loop back to start
                // _isPlaying = false; // Uncomment if you want to stop at the end instead of looping
                // timer.cancel();
                // _secondTimer?.cancel();
              }
            });
          }
        },
      );
    }
  }

  void _startTimer() {
    _secondTimer?.cancel();
    _secondTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted && _isPlaying) {
        setState(() {
          // Calculate elapsed seconds based on current index
          _elapsedSeconds =
              (_currentIndex * _durationPerImageMs / 1000).round();

          // If we've reached the end, stop the timer
          if (_currentIndex >= _images.length - 1) {
            _elapsedSeconds =
                (_images.length * _durationPerImageMs / 1000).round();
            // timer.cancel(); // Remove this if you want to loop
          }
        });
      }
    });
  }

  void _startAnimationTimer() {
    _animationTimer?.cancel();
    _animationValue = 0.0;

    // Use a faster update rate for smoother animations
    const animationUpdateRate = 60; // ~60fps for smooth motion

    _animationTimer = Timer.periodic(
        const Duration(milliseconds: animationUpdateRate), (timer) {
      if (mounted) {
        setState(() {
          // Adjust speed based on animation type - slower speed means smoother animation
          double speedFactor =
              0.5; // Reduced from 1.0 to make all animations smoother

          // Special handling for different animation types
          if (_selectedAnimation == AnimationType.transition) {
            speedFactor = 0.3; // Even slower for transitions
          } else if (_selectedAnimation == AnimationType.thaw) {
            speedFactor = 0.4; // Slightly faster than transition
          }

          _animationValue += 0.01 * speedFactor;

          if (_animationValue >= 1.0) {
            if (_selectedAnimation == AnimationType.transition ||
                _selectedAnimation == AnimationType.thaw) {
              _animationValue =
                  1.0; // Keep at full for completion-based animations
            } else {
              _animationValue = 0.0; // Reset for continuous animations
            }
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

      // Restart animation if one is selected
      if (_selectedAnimation != AnimationType.none) {
        _startAnimationTimer();
      }
    } else {
      _imageTimer?.cancel();
      _secondTimer?.cancel();
      _animationTimer?.cancel();
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
    final totalSeconds =
        (_images.length * (_durationPerImageMs / 1000)).round();
    return _formatDuration(totalSeconds);
  }

  // Toggle filter panel visibility
  void _toggleFilters() {
    setState(() {
      _showFilters = !_showFilters;
      if (_showFilters) {
        _showAnimations = false;
      }
    });
  }

  // Toggle animation panel visibility
  void _toggleAnimations() {
    setState(() {
      _showAnimations = !_showAnimations;
      if (_showAnimations) {
        _showFilters = false;
      }
    });
  }

  // Apply selected filter to all images
  Future<void> _applySelectedFilter() async {
    if (_images.isEmpty) return;

    setState(() {
      _processingImages = true;
    });

    // Show a loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Applying filter..."),
            ],
          ),
        );
      },
    );

    // Process images in background
    List<File> newProcessedImages = [];



    // for (int i = 0; i < _images.length; i++) {
    //   File processedFile = await _applyFilterToImage(_images[i], _selectedFilter);
    //   newProcessedImages.add(processedFile);
    // }

    // Pop the loading dialog
    if (mounted && Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }

    if (mounted) {
      setState(() {
        _processedImages = newProcessedImages;
        _processingImages = false;
      });
    }
  }
  

  // Apply a filter to an individual image

  Future<File> applyFilterToVideo(File videoFile, FilterType filter) async {
    // For "none" filter, return the original video
    if (filter == FilterType.none) {
      return videoFile;
    }

    final tempDir = await getTemporaryDirectory();
    final outputPath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';

    // Create FFmpeg command based on filter type
    String ffmpegCommand;

    switch (filter) {
      case FilterType.blackWhite:
        // Convert to grayscale using FFmpeg
        ffmpegCommand =
            '-i ${videoFile.path} -vf colorchannelmixer=.3:.4:.3:0:.3:.4:.3:0:.3:.4:.3 $outputPath';
        break;

      case FilterType.watercolor:
        // Apply watercolor-like effect
        ffmpegCommand =
            '-i ${videoFile.path} -vf "colorbalance=rs=0.1:gs=0:bs=0.2,boxblur=1:1" $outputPath';
        break;

      case FilterType.snow:
        // Add snow effect and cool tint
        ffmpegCommand =
            '-i ${videoFile.path} -vf "colorbalance=rm=-0.1:bm=0.1,geq=\'r=r(X,Y):g=g(X,Y):b=b(X,Y)+if(mod(X+Y,30)<1.5*random(1),255-b(X,Y),0)\'" $outputPath';
        break;

      case FilterType.waterDrops:
        // A simplified water drops effect
        ffmpegCommand =
            '-i ${videoFile.path} -vf "colorbalance=bm=0.2,unsharp=3:3:1" $outputPath';
        break;

      default:
        return videoFile;
    }

    try {
      // Execute the FFmpeg command
      final session = await FFmpegKit.execute(ffmpegCommand);
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        return File(outputPath);
      } else {
        print('FFmpeg process exited with code $returnCode');
        return videoFile;
      }
    } catch (e) {
      print('Error applying filter to video: $e');
      return videoFile;
    }
  }

  // Apply selected animation
  void _applyAnimation(AnimationType animation) {
    setState(() {
      _selectedAnimation = animation;
      // Reset animation value
      _animationValue = 0.0;
    });

    // Cancel existing animation timer
    _animationTimer?.cancel();

    // If selected animation is "none", we don't start the timer
    if (animation == AnimationType.none) {
      return;
    }

    // Start animation timer for other animations
    _startAnimationTimer();
  }

  Widget _buildAnimatedImage(File imageFile) {
    if (_selectedAnimation == AnimationType.none || !_isPlaying) {
      return Image.file(
        imageFile,
        fit: BoxFit.cover,
      );
    }

    switch (_selectedAnimation) {
      case AnimationType.none:
        return Image.file(
          imageFile,
          fit: BoxFit.cover,
        );

      case AnimationType.leftRight:
        // Smoother horizontal movement with easing
        final double maxOffset =
            MediaQuery.of(context).size.width * 0.08; // Reduced from 0.15
        final double offset = maxOffset * math.sin(_animationValue * math.pi);
        return Transform.translate(
          offset: Offset(offset, 0),
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        );

      case AnimationType.upDown:
        // Smoother vertical movement with easing
        final double maxOffset =
            MediaQuery.of(context).size.height * 0.05; // Reduced from 0.1
        final double offset = maxOffset * math.sin(_animationValue * math.pi);
        return Transform.translate(
          offset: Offset(0, offset),
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        );

      case AnimationType.window:
        // More natural zoom effect with gentle ease-in-out
        final double minScale = 1.0;
        final double maxScale = 1.08; // Reduced from 1.15 for subtler effect
        final double scale =
            minScale + (maxScale - minScale) * _getEasedValue(_animationValue);
        return Transform.scale(
          scale: scale,
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        );

      case AnimationType.gradient:
        // Smoother gradient animation with better values
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.transparent,
              ],
              stops: [
                _animationValue,
                _animationValue + 0.4
              ], // Increased from 0.3 for smoother transition
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        );

      case AnimationType.transition:
        if (_currentIndex > 0 && _currentIndex < _processedImages.length) {
          // Smooth cross-fade with easing function
          int previousIndex = _currentIndex - 1;
          double easedValue = _getEasedValue(_animationValue);
          return Stack(
            fit: StackFit.expand,
            children: [
              // Previous image
              Opacity(
                opacity: 1.0 - easedValue,
                child: Image.file(
                  _processedImages[previousIndex],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              // Current image
              Opacity(
                opacity: easedValue,
                child: Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ],
          );
        } else {
          return Image.file(
            imageFile,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          );
        }

      case AnimationType.thaw:
        // New thaw animation - reveals image gradually with a melting effect
        final double progress = _getEasedValue(_animationValue);
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.transparent,
              ],
              stops: [progress - 0.3, progress + 0.1],
              transform: GradientRotation(math.pi / 4), // Diagonal direction
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        );

      case AnimationType.scale:
        // New scale animation - pulsing zoom effect
        final double minScale = 1.0;
        final double maxScale = 1.1;

        // Use sine function for continuous smooth pulsing
        final double scale = minScale +
            (maxScale - minScale) *
                0.5 *
                (1 + math.sin(_animationValue * math.pi * 2 - math.pi / 2));

        return Transform.scale(
          scale: scale,
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        );
    }
  }

// Add this easing function for smoother animations
  double _getEasedValue(double value) {
    // Enhanced ease in-out function for smoother transitions
    if (value < 0.5) {
      // Ease in - slow start, faster end
      return 4 * value * value * value;
    } else {
      // Ease out - fast start, slower end
      final double f = ((2 * value) - 2);
      return 0.5 * f * f * f + 1;
    }
  }

  Future<void> _exportVideo() async {
    if (_images.isEmpty) return;

    // Show a loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Creating video..."),
            ],
          ),
        );
      },
    );

    try {
      final tempDir = await getTemporaryDirectory();
      final outputVideoPath = '${tempDir.path}/output_video.mp4';

      // Create a temporary directory for frames
      final framesDir =
          await Directory('${tempDir.path}/frames/').create(recursive: true);

      // Copy all processed images to sequential frames
      List<String> framePaths = [];
      for (int i = 0; i < _processedImages.length; i++) {
        final framePath =
            '${framesDir.path}/frame_${i.toString().padLeft(5, '0')}.jpg';
        await _processedImages[i].copy(framePath);
        framePaths.add(framePath);
      }

      // Create video with FFmpeg
      String ffmpegCommand =
          '-framerate ${1000 / _durationPerImageMs} -i ${framesDir.path}/frame%05d.jpg -c:v libx264 -pix_fmt yuv420p $outputVideoPath';

      final session = await FFmpegKit.execute(ffmpegCommand);
      final returnCode = await session.getReturnCode();

      // Close the loading dialog
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      if (ReturnCode.isSuccess(returnCode)) {
        // Success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Video created successfully!')),
        );
      } else {
        // Error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating video')),
        );
      }
    } catch (e) {
      // Close the loading dialog
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      // Error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _downloadVideo() async {
    if (_images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No video to download')),
      );
      return;
    }

    // Request storage permission
    var status = await Permission.storage.request();

    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission is required to save video')),
      );
      return;
    }

    // Show a loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Creating and saving video..."),
            ],
          ),
        );
      },
    );

    try {
      final tempDir = await getTemporaryDirectory();
      final outputVideoPath = '${tempDir.path}/output_video.mp4';

      // Create a temporary directory for frames
      final framesDir =
          await Directory('${tempDir.path}/frames/').create(recursive: true);

      // Copy all processed images to sequential frames
      for (int i = 0; i < _processedImages.length; i++) {
        final framePath =
            '${framesDir.path}/frame_${i.toString().padLeft(5, '0')}.jpg';
        await _processedImages[i].copy(framePath);
      }

      // Create video with FFmpeg
      String ffmpegCommand =
          '-framerate ${1000 / _durationPerImageMs} -i ${framesDir.path}/frame%05d.jpg -c:v libx264 -pix_fmt yuv420p $outputVideoPath';

      final session = await FFmpegKit.execute(ffmpegCommand);
      final returnCode = await session.getReturnCode();

      // Close the loading dialog
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      if (ReturnCode.isSuccess(returnCode)) {
        // Read the video file as bytes
        final File videoFile = File(outputVideoPath);
        final Uint8List videoBytes = await videoFile.readAsBytes();

        // Save the video to the gallery using photo_manager
        final asset = await PhotoManager.editor.saveVideo(videoFile);

        if (asset != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Video saved to gallery successfully!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save video to gallery')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating video')),
        );
      }
    } catch (e) {
      // Close the loading dialog
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

// Add this method to _UploadImageState class
  void _initializeAudioPlayer() {
    _backgroundAudioPlayer = AudioPlayer();
  }

// Add this method to _UploadImageState class
  Future<void> _playBackgroundAudio() async {
    if (_selectedAudio != null && _backgroundAudioPlayer != null) {
      try {
        await _backgroundAudioPlayer!.setAsset(_selectedAudio!.source);
        await _backgroundAudioPlayer!
            .setLoopMode(LoopMode.all); // Loop the audio
        await _backgroundAudioPlayer!.play();
      } catch (e) {
        print('Error playing background audio: $e');
      }
    }
  }

// Add this method to _UploadImageState class
  Future<void> _stopBackgroundAudio() async {
    if (_backgroundAudioPlayer != null && _backgroundAudioPlayer!.playing) {
      await _backgroundAudioPlayer!.stop();
    }
  }

  void _openAudioSelectionScreen() {
    // Pause video playback
    _imageTimer?.cancel();
    _secondTimer?.cancel();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AudioSelectionScreen(
          currentAudio: _selectedAudio,
          onAudioSelected: (audio) {
            setState(() {
              _selectedAudio = audio;
            });

            // Stop current audio if playing
            _stopBackgroundAudio();

            // If an audio is selected, start playing it
            if (_selectedAudio != null && _isPlaying) {
              _playBackgroundAudio();
            }

            // Resume video playback if it was playing
            if (_isPlaying) {
              _startVideoPlayback();
              _startTimer();
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Close filters and animations panels if they are open
          if (_showFilters || _showAnimations) {
            setState(() {
              _showFilters = false;
              _showAnimations = false;
            });
          }
        },
        behavior: HitTestBehavior.translucent,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
             const   SizedBox(height: 30),
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
                      GestureDetector(
                        onTap: _downloadVideo,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 51, 68, 196),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.download_sharp,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),

                if (_images.isNotEmpty)
                  GestureDetector(
                    onTap: _toggleControls,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Image display
                        Container(
                          height: 400,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: _processingImages
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : _buildAnimatedImage(_processedImages
                                            .isNotEmpty &&
                                        _currentIndex < _processedImages.length
                                    ? _processedImages[_currentIndex]
                                    : _images[_currentIndex]),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
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
                                              _isPlaying
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
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
                                              thumbShape:
                                                  const RoundSliderThumbShape(
                                                enabledThumbRadius: 6,
                                              ),
                                              overlayShape:
                                                  const RoundSliderOverlayShape(
                                                overlayRadius: 10,
                                              ),
                                              activeTrackColor: Colors.red,
                                              inactiveTrackColor:
                                                  Colors.grey.withOpacity(0.5),
                                              thumbColor: Colors.red,
                                            ),
                                            child: Slider(
                                              value: _currentIndex.toDouble(),
                                              min: 0,
                                              max: (_images.length - 1)
                                                  .toDouble()
                                                  .clamp(0, double.infinity),
                                              onChanged: (value) {
                                                setState(() {
                                                  _currentIndex = value.toInt();
                                                  // Update time based on slider position
                                                  _elapsedSeconds =
                                                      (_currentIndex *
                                                              _durationPerImageMs /
                                                              1000)
                                                          .round();

                                                  // Reset animation for transition effect
                                                  if (_selectedAnimation ==
                                                      AnimationType
                                                          .transition) {
                                                    _animationValue = 0.0;
                                                  }
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
                          onPressed: _pickInitialImages,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 51, 68, 196),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                          child: const Text('Select Images for Video'),
                        ),
                      ],
                    ),
                  ),

                SizedBox(
                  height: 85,
                ),

                // Filter selection panel
                if (_showFilters)
                  Container(
                    height: 120,
                    width: double.infinity,
                    color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16, top: 8),
                          child: Text(
                            'Filter',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            children: [
                              _buildFilterOption(FilterType.none, 'None'),
                              _buildFilterOption(
                                  FilterType.blackWhite, 'Black&White'),
                              _buildFilterOption(
                                  FilterType.watercolor, 'Watercolor'),
                              _buildFilterOption(FilterType.snow, 'Snow'),
                              _buildFilterOption(
                                  FilterType.waterDrops, 'WaterDrops'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                // Animation selection panel
                if (_showAnimations)
                  Container(
                    height: 120,
                    width: double.infinity,
                    color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16, top: 8),
                          child: Text(
                            'Animation',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            children: [
                              _buildAnimationOption(AnimationType.none, 'None'),
                              _buildAnimationOption(
                                  AnimationType.leftRight, 'LeftRight'),
                              _buildAnimationOption(
                                  AnimationType.upDown, 'UpDown'),
                              _buildAnimationOption(
                                  AnimationType.window, 'Window'),
                              _buildAnimationOption(
                                  AnimationType.gradient, 'Gradient'),
                              _buildAnimationOption(
                                  AnimationType.transition, 'Transition'),
                              _buildAnimationOption(AnimationType.thaw, 'Thaw'),
                              _buildAnimationOption(
                                  AnimationType.scale, 'Scale'),
                            ],
                          ),
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        iconSize: 27,
        onTap: (index) {
          switch (index) {
            case 0:
              // Handle "Add image" tap - open edit screen
              _openEditImagesScreen();
              break;
            case 1:
              // Toggle filter panel
              _toggleFilters();
              break;
            case 2:
              // Toggle animation panel
              _toggleAnimations();
              break;
            case 3:
              // Audio feature (not implemented yet)
              _openAudioSelectionScreen();
              break;
          }
        },
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add image',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_incandescent_outlined),
            label: 'Filter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation_outlined),
            label: 'Animation',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.volume_up_outlined,
          //     color: _selectedAudio != null ? Colors.blue : Colors.white70,
          //   ),
          //   label: 'Audio',
          // ),
        ],
      ),
    );
  }

  // Build a filter option widget
  Widget _buildFilterOption(FilterType filter, String label) {
    bool isSelected = _selectedFilter == filter;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = filter;
        });
        // Apply filter immediately when selected
        _applySelectedFilter();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: _images.isNotEmpty
                    ? _getFilterPreview(filter)
                    : Container(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build an animation option widget
  Widget _buildAnimationOption(AnimationType animation, String label) {
    bool isSelected = _selectedAnimation == animation;

    return GestureDetector(
      onTap: () {
        // Apply animation immediately when selected
        _applyAnimation(animation);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  width: 2,
                ),
                color: Colors.white24,
              ),
              child: Center(
                child: Icon(
                  _getAnimationIcon(animation),
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Return an appropriate icon for each animation type
  IconData _getAnimationIcon(AnimationType animation) {
    switch (animation) {
      case AnimationType.none:
        return Icons.not_interested;
      case AnimationType.leftRight:
        return Icons.arrow_right_alt;
      case AnimationType.upDown:
        return Icons.arrow_downward;
      case AnimationType.window:
        return Icons.crop_free;
      case AnimationType.gradient:
        return Icons.gradient;
      case AnimationType.transition:
        return Icons.switch_access_shortcut;
      case AnimationType.thaw:
        return Icons.ac_unit; // Snow/ice icon for thaw effect
      case AnimationType.scale:
        return Icons.zoom_in; // Zoom icon for scale effect
    }
  }

  // Get a preview image for a filter
  Widget _getFilterPreview(FilterType filter) {
    if (_images.isEmpty) {
      return Container(color: Colors.grey);
    }

    // For simplicity, we'll show a colored overlay representing the filter
    Widget baseImage = Image.file(
      _images[0],
      fit: BoxFit.cover,
    );

    switch (filter) {
      case FilterType.none:
      case FilterType.none:
        return baseImage;
      case FilterType.blackWhite:
        return ColorFiltered(
          colorFilter: const ColorFilter.matrix([
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
          child: baseImage,
        );
      case FilterType.watercolor:
        return ColorFiltered(
          colorFilter: const ColorFilter.matrix([
            1.3,
            0,
            0,
            0,
            0,
            0,
            1.3,
            0,
            0,
            0,
            0,
            0,
            1.3,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
          ]),
          child: baseImage,
        );
      case FilterType.snow:
        return ColorFiltered(
          colorFilter: const ColorFilter.matrix([
            1.2,
            0,
            0,
            0,
            10,
            0,
            1.2,
            0.1,
            0,
            10,
            0,
            0,
            1.4,
            0,
            20,
            0,
            0,
            0,
            1,
            0,
          ]),
          child: baseImage,
        );
      case FilterType.waterDrops:
        return ColorFiltered(
          colorFilter: const ColorFilter.matrix([
            0.9,
            0,
            0,
            0,
            0,
            0,
            1.0,
            0,
            0,
            0,
            0,
            0,
            1.5,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
          ]),
          child: baseImage,
        );
    }
  }
}

// Edit Screen implementation
class EditImagesScreen extends StatefulWidget {
  final List<File> existingImages;
  final Function(List<File>) onComplete;

  const EditImagesScreen({
    Key? key,
    required this.existingImages,
    required this.onComplete,
  }) : super(key: key);

  @override
  _EditImagesScreenState createState() => _EditImagesScreenState();
}

class _EditImagesScreenState extends State<EditImagesScreen> {
  late List<File> _images;
  final ImagePicker _picker = ImagePicker();
  bool _isDragging = false;
  int? _draggedItemIndex;

  @override
  void initState() {
    super.initState();
    _images = List.from(widget.existingImages);
  }

  Future<void> _addMoreImages() async {
    try {
      final List<XFile>? pickedFiles = await _picker.pickMultiImage();

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        setState(() {
          _images.addAll(pickedFiles.map((file) => File(file.path)).toList());
        });
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _reorderImages(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final File item = _images.removeAt(oldIndex);
      _images.insert(newIndex, item);
    });
  }

  void _saveChanges() {
    widget.onComplete(_images);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Images'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            widget.onComplete(widget.existingImages); // Keep original images
          },
        ),
        actions: [
          TextButton(
            onPressed: _saveChanges,
            child: const Text('Done', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Drag to reorder, tap X to remove',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: _images.isEmpty
                ? Center(
                    child: Text(
                      'No images selected',
                      style: TextStyle(fontSize: 18, color: Colors.grey[400]),
                    ),
                  )
                : ReorderableListView.builder(
                    itemCount: _images.length,
                    onReorder: _reorderImages,
                    itemBuilder: (context, index) {
                      return Card(
                        key: Key('$index'),
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        child: ListTile(
                          leading: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                image: FileImage(_images[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text('Image ${index + 1}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => _removeImage(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMoreImages,
        child:  Icon(Icons.add_photo_alternate),
        backgroundColor: const Color.fromARGB(255, 51, 68, 196),
      ),
    );
  }
}

// Main app entry point
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo to Video Maker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo to Video Maker'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.video_collection,
              size: 100,
              color: Color.fromARGB(255, 51, 68, 196),
            ),
            const SizedBox(height: 30),
            const Text(
              'Create stunning videos from your photos',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Add filters, animations, and transitions to your photos',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UploadImage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 51, 68, 196),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Create New Video'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // This would typically open a gallery of previously created videos
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Gallery feature coming soon!'),
                  ),
                );
              },
              child: const Text(
                'View My Gallery',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper class for downloading and sharing video
class VideoUtility {
  // Save video to gallery
  static Future<void> saveVideoToGallery(
      List<File> images, int durationPerImageMs) async {
    // This would require a video encoding implementation
    // For now, just show a placeholder message
    print('Video save functionality will be implemented with FFmpeg');
  }

  // Share video to other apps
  static Future<void> shareVideo(List<File> images) async {
    // This would require generating a video first
    // For now, just show a placeholder message
    print('Video sharing functionality will be implemented');
  }
}

// Advanced filter implementation
class FilterUtility {
  // Additional filters could be implemented here
  // For more complex filters beyond what the image package can do

  static Future<img.Image> applyAdvancedFilter(
      img.Image image, FilterType filterType) async {
    switch (filterType) {
      case FilterType.none:
        return image;

      // Additional advanced filter implementations would go here

      default:
        return image;
    }
  }

  
}