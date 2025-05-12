// import 'package:flutter/material.dart';

// class RemoveBackgroundPremium extends StatelessWidget {
//   const RemoveBackgroundPremium({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: const Icon(Icons.arrow_back_ios)),
//         backgroundColor: Colors.amber[700],
//         title: const Text(
//           "Unlock access to\nUnlimited Premium & Trendy\nBranding Posts & Videos",
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         toolbarHeight: 120,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Features section
//             const Padding(
//               padding: EdgeInsets.all(12.0),
//               child: Text(
//                 "What you'll get with this Premium?",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _featureCard("2Lac+", "Event Posters", Icons.event_note),
//                 _featureCard(
//                     "2000+", "WhatsApp Stickers", Icons.emoji_emotions),
//                 _featureCard("1000+", "Audio Jingles", Icons.music_note),
//               ],
//             ),

//             // Premium Plans section
//             const Padding(
//               padding: EdgeInsets.all(12.0),
//               child: Text(
//                 "Premium Plans",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 26.0),
//               child: Wrap(
//                 spacing: 12,
//                 runSpacing: 16,
//                 children: [
//                   _planCard(
//                     title: "Yearly Limited Plan",
//                     price: "₹2247",
//                     oldPrice: "₹3247",
//                     save: "₹1000",
//                     validity: "Validity: 1 Year",
//                     bgColor: Colors.red[700],
//                   ),
//                   _planCard(
//                     title: "Brand Booster Plan",
//                     price: "₹3497",
//                     oldPrice: "₹4997",
//                     save: "₹1500",
//                     validity: "Validity: 12 Months",
//                     bgColor: Colors.blue[800],
//                     // isRecommended: true,
//                   ),
//                   _planCard(
//                     title: "Quarterly Plan",
//                     price: "₹897",
//                     oldPrice: "₹1247",
//                     save: "₹350",
//                     validity: "Validity: 3 Months",
//                     bgColor: Colors.red[700],
//                   ),
//                   _planCard(
//                     title: "Mega Booster Plan",
//                     price: "₹9997",
//                     oldPrice: "₹14997",
//                     save: "₹5000",
//                     validity: "Validity: Lifetime",
//                     bgColor: Colors.blue[800],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _featureCard(String count, String title, IconData icon) {
//     return Column(
//       children: [
//         CircleAvatar(
//           backgroundColor: Colors.amber[200],
//           child: Icon(icon, color: Colors.black),
//         ),
//         const SizedBox(height: 4),
//         Text(count, style: const TextStyle(fontWeight: FontWeight.bold)),
//         Text(title, textAlign: TextAlign.center),
//       ],
//     );
//   }

//   Widget _planCard({
//     required String title,
//     required String price,
//     required String oldPrice,
//     required String save,
//     required String validity,
//     required Color? bgColor,
//     // bool isRecommended = false,
//   }) {
//     return Stack(
//       children: [
//         Container(
//           width: 170,
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: bgColor?.withOpacity(0.9),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(title,
//                   style: const TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               Text(
//                 oldPrice,
//                 style: const TextStyle(
//                   color: Colors.white70,
//                   decoration: TextDecoration.lineThrough,
//                 ),
//               ),
//               Text(
//                 price,
//                 style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//               Text("Save: $save", style: const TextStyle(color: Colors.white)),
//               const SizedBox(height: 4),
//               Text(validity, style: const TextStyle(color: Colors.white)),
//             ],
//           ),
//         ),
//         // if (isRecommended)
//         //   Positioned(
//         //     top: -8,
//         //     right: -8,
//         //     child: Container(
//         //       padding:
//         //           const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
//         //       decoration: BoxDecoration(
//         //         color: Colors.yellow[700],
//         //         borderRadius: BorderRadius.circular(8),
//         //       ),
//         //       child: const Text(
//         //         "Recommended",
//         //         style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
//         //       ),
//         //     ),
//         //   )
//       ],
//     );
//   }
// }






// ignore_for_file: use_super_parameters

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class BackgroundRemovalProcessingScreen extends StatefulWidget {
  final List<File> selectedImages;
  
  const BackgroundRemovalProcessingScreen({
    Key? key, 
    required this.selectedImages,
  }) : super(key: key);

  @override
  State<BackgroundRemovalProcessingScreen> createState() => _BackgroundRemovalProcessingScreenState();
}

class _BackgroundRemovalProcessingScreenState extends State<BackgroundRemovalProcessingScreen> {
  final List<File> _processedImages = [];
  final List<bool> _processingStatus = [];
  bool _isProcessing = false;
  int _currentProcessingIndex = -1;
  int _remainingCredits = 10; // Example value, should be fetched from user account

  @override
  void initState() {
    super.initState();
    _initializeProcessingStatus();
    _loadRemainingCredits();
    // Start processing automatically
    _startProcessing();
  }

  Future<void> _loadRemainingCredits() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _remainingCredits = prefs.getInt('remaining_bg_removal_credits') ?? 10;
    });
  }

  Future<void> _updateRemainingCredits(int used) async {
    final prefs = await SharedPreferences.getInstance();
    _remainingCredits -= used;
    await prefs.setInt('remaining_bg_removal_credits', _remainingCredits);
  }

  void _initializeProcessingStatus() {
    // _processingStatus = List.generate(widget.selectedImages.length, (index) => false);
  }

  Future<void> _startProcessing() async {
    if (_isProcessing || widget.selectedImages.isEmpty) return;
    
    setState(() {
      _isProcessing = true;
    });
    
    for (int i = 0; i < widget.selectedImages.length; i++) {
      if (_remainingCredits <= 0) {
        _showNoCreditsDialog();
        break;
      }
      
      setState(() {
        _currentProcessingIndex = i;
      });
      
      // Simulate API call to remove background
      await _processImage(i);
      
      await _updateRemainingCredits(1);
      
      setState(() {
        _processingStatus[i] = true;
      });
    }
    
    setState(() {
      _isProcessing = false;
      _currentProcessingIndex = -1;
    });
    
    _showCompletionDialog();
  }

  Future<void> _processImage(int index) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));
    
    // This is where you would normally make an API call to a background removal service
    // For this example, we'll just create a copy of the image to simulate processing
    final processedImage = await _simulateBackgroundRemoval(widget.selectedImages[index]);
    
    setState(() {
      _processedImages.add(processedImage);
    });
  }

  Future<File> _simulateBackgroundRemoval(File originalImage) async {
    // In a real app, you would call an API service here
    // For now, we'll just copy the file to simulate processing
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final newPath = '${directory.path}/bg_removed_$timestamp.jpg';
    return originalImage.copy(newPath);
  }

  void _showNoCreditsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Insufficient Credits'),
          content: const Text('You have run out of background removal credits. Please purchase more to continue.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Processing Complete'),
          content: Text('${_processedImages.length} images have been processed successfully.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToResultScreen();
              },
              child: const Text('View Results'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToResultScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BackgroundRemovedResultsScreen(
          processedImages: _processedImages,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Processing Images'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Credits: $_remainingCredits',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Credits info
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.yellow[100],
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.orange),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'You have $_remainingCredits background removal credits remaining.',
                    style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Processing status
          Expanded(
            child: ListView.builder(
              itemCount: widget.selectedImages.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final isCurrentlyProcessing = _currentProcessingIndex == index;
                final isProcessed = _processingStatus[index];
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // Image thumbnail
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            widget.selectedImages[index],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        
                        // Status info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Image ${index + 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                isProcessed 
                                    ? 'Processed ✓' 
                                    : isCurrentlyProcessing 
                                        ? 'Processing...' 
                                        : 'Waiting...',
                                style: TextStyle(
                                  color: isProcessed 
                                      ? Colors.green 
                                      : isCurrentlyProcessing 
                                          ? Colors.blue 
                                          : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Status indicator
                        if (isCurrentlyProcessing)
                          const CircularProgressIndicator()
                        else if (isProcessed)
                          const Icon(Icons.check_circle, color: Colors.green)
                        else
                          const Icon(Icons.hourglass_empty, color: Colors.grey),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Processing: ${_processedImages.length}/${widget.selectedImages.length}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: _isProcessing 
                    ? null 
                    : () {
                        if (_processedImages.isNotEmpty) {
                          _navigateToResultScreen();
                        } else {
                          _startProcessing();
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  _isProcessing 
                      ? 'Processing...' 
                      : _processedImages.isNotEmpty 
                          ? 'View Results' 
                          : 'Start Processing',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundRemovedResultsScreen extends StatefulWidget {
  final List<File> processedImages;
  
  const BackgroundRemovedResultsScreen({
    Key? key, 
    required this.processedImages,
  }) : super(key: key);

  @override
  State<BackgroundRemovedResultsScreen> createState() => _BackgroundRemovedResultsScreenState();
}

class _BackgroundRemovedResultsScreenState extends State<BackgroundRemovedResultsScreen> {
  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Removed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: () => _saveAllImages(),
            tooltip: 'Save all images',
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareImage(_selectedIndex),
            tooltip: 'Share current image',
          ),
        ],
      ),
      body: Column(
        children: [
          // Main image view
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              color: Colors.grey[200],
              child: widget.processedImages.isNotEmpty
                  ? Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.all(20),
                        child: Image.file(
                          widget.processedImages[_selectedIndex],
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : const Center(
                      child: Text('No processed images available'),
                    ),
            ),
          ),
          
          // Image thumbnails
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: widget.processedImages.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedIndex == index;
                  
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Colors.teal : Colors.transparent,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.file(
                          widget.processedImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                icon: Icons.save,
                label: 'Save',
                onPressed: () => _saveImage(_selectedIndex),
              ),
              _buildActionButton(
                icon: Icons.share,
                label: 'Share',
                onPressed: () => _shareImage(_selectedIndex),
              ),
              _buildActionButton(
                icon: Icons.edit,
                label: 'Edit',
                onPressed: () => _editImage(_selectedIndex),
              ),
              _buildActionButton(
                icon: Icons.delete,
                label: 'Delete',
                onPressed: () => _deleteImage(_selectedIndex),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  void _saveImage(int index) {
    // Implement save functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image saved to gallery')),
    );
  }

  void _saveAllImages() {
    // Implement save all functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.processedImages.length} images saved to gallery')),
    );
  }

  void _shareImage(int index) {
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sharing image...')),
    );
  }

  void _editImage(int index) {
    // Implement edit functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening editor...')),
    );
  }

  void _deleteImage(int index) {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Image'),
          content: const Text('Are you sure you want to delete this image?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  widget.processedImages.removeAt(index);
                  if (_selectedIndex >= widget.processedImages.length) {
                    _selectedIndex = widget.processedImages.length - 1;
                  }
                  if (_selectedIndex < 0) {
                    _selectedIndex = 0;
                  }
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Image deleted')),
                );
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}