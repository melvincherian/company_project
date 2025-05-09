// // ignore_for_file: use_build_context_synchronously

// import 'package:company_project/views/presentation/pages/home/navbar_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:company_project/providers/category_provider.dart';

// class BusinessIndustryScreen extends StatefulWidget {
//   const BusinessIndustryScreen({super.key});

//   @override
//   State<BusinessIndustryScreen> createState() => _BusinessIndustryScreenState();
// }

// class _BusinessIndustryScreenState extends State<BusinessIndustryScreen> {
//   int? _selectedIndex;

//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() => Provider.of<CategoryProvider>(context, listen: false)
//         .fetchCategories());
//     // print("Categories in UI: ${Provider.of<CategoryProvider>(context).categories}");
//   }

//   @override
//   Widget build(BuildContext context) {
//     final categoryProvider = Provider.of<CategoryProvider>(context);
//     // print('fsfsfnsfnwsnfkw$categoryProvider');

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select Your Business Industry'),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),
//       body: categoryProvider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : categoryProvider.categories.isEmpty
//               ? const Center(child: Text("No categories available"))
//               : Column(
//                   children: [
//                     const Divider(thickness: 2),
//                     _buildSearchBar(),
//                     Expanded(
//                       child: GridView.builder(
//                         padding: const EdgeInsets.all(16),
//                         itemCount: categoryProvider.categories.length,
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 3,
//                           mainAxisSpacing: 16,
//                           crossAxisSpacing: 16,
//                         ),
//                         itemBuilder: (context, index) {
//                           final category = categoryProvider.categories[index];
//                           final isSelected = _selectedIndex == index;
                      
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(context,MaterialPageRoute(builder: (context)=>const NavbarScreen()));
//                               setState(() {
//                                 _selectedIndex = index;
//                               });
//                             },
//                             child: _buildCategoryCard(
//                               category.categoryname,
//                               isSelected
//                                   ? const Color(0xFF413B99)
//                                   : const Color(0xFFF9F9F9),
//                               category.image,
//                               textColor:
//                                   isSelected ? Colors.white : Colors.black,
//                               hasBorder: true,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search "Posters"',
//                 contentPadding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: const Color.fromARGB(255, 252, 250, 250),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: const Color.fromARGB(255, 97, 74, 160),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: const Icon(Icons.mic, color: Colors.white, size: 25),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategoryCard(
//     String title,
//     Color backgroundColor,
//     String imagePath, {
//     Color textColor = Colors.white,
//     bool hasBorder = false,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(12),
//         border: hasBorder ? Border.all(color: Colors.grey[300]!) : null,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(25),
//             child: CircleAvatar(
//               radius: 25,
//               backgroundColor: Colors.white,
//               backgroundImage: NetworkImage(imagePath),
//               onBackgroundImageError: (_, __) => debugPrint("Image load error"),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: textColor,
//               fontWeight: FontWeight.w500,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




// ignore_for_file: use_build_context_synchronously

import 'package:company_project/providers/category_providerr.dart';
import 'package:company_project/providers/provider_main_category.dart';
import 'package:company_project/views/presentation/pages/home/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:company_project/providers/category_provider.dart';
import 'package:company_project/views/presentation/pages/home/navbar_screen.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class BusinessIndustryScreen extends StatefulWidget {
  const BusinessIndustryScreen({super.key});

  @override
  State<BusinessIndustryScreen> createState() => _ChangeIndustryScreenState();
}

class _ChangeIndustryScreenState extends State<BusinessIndustryScreen> {
  int? _selectedIndex;
  final TextEditingController _searchController = TextEditingController();
  bool _isListening = false;
  String _searchText = '';
  List<dynamic> _filteredCategories = [];

  late stt.SpeechToText _speech;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initializeSpeech();
    _fetchCategories();
  }

  Future<void> _initializeSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) => debugPrint('Speech status: $status'),
      onError: (error) => debugPrint('Speech error: $error'),
    );
    if (!available) {
      debugPrint('Speech recognition not available');
    }
  }

  Future<void> _fetchCategories() async {
    await Provider.of<CategoryMainProvider>(context, listen: false).fetchCategories();
    setState(() {

      _filteredCategories = Provider.of<CategoryMainProvider>(context, listen: false).categories;
     for (var category in _filteredCategories) {
    print('Category: ${category.categoryName}, ID: ${category.id}, Image: ${category.image}');
  }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _speech.stop();
    super.dispose();
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => debugPrint('Speech status: $status'),
        onError: (error) => debugPrint('Speech error: $error'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _searchText = result.recognizedWords;
              _searchController.text = _searchText;
            });
            _filterCategories();
          },
        );
      } else {
        debugPrint('The user has denied the use of speech recognition.');
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _filterCategories() {
    final categoryProvider = Provider.of<CategoryMainProvider>(context, listen: false);
    if (_searchText.isEmpty) {
      setState(() {
        _filteredCategories = categoryProvider.categories;
        print('KOIIIIIIIIII$_filteredCategories');
      });
    } else {
      setState(() {
        _filteredCategories = categoryProvider.categories
            .where((category) => category.categoryName
                .toLowerCase()
                .contains(_searchText.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryMainProvider>(context);
    if (_filteredCategories.isEmpty && categoryProvider.categories.isNotEmpty) {
      _filteredCategories = categoryProvider.categories;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Business Industry'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: categoryProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : categoryProvider.categories.isEmpty
              ? const Center(child: Text("No categories available"))
              : Column(
                  children: [
                    const Divider(thickness: 2),
                    _buildSearchBar(),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredCategories.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {
                          final category = _filteredCategories[index];
                          final isSelected = _selectedIndex == index;

                          print('tttttttttttttt$category');

                          return GestureDetector(
                            onTap: () {
                    //            Navigator.push(
                    // context,
                    // MaterialPageRoute(
                    //     builder: (context) =>
                    //         DetailsScreen(category: category.categoryName)));
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const NavbarScreen()),
                              );
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            child: _buildCategoryCard(
                              category.categoryName,
                              isSelected ? const Color(0xFF413B99) : const Color(0xFFF9F9F9),
                              category.image,
                              textColor: isSelected ? Colors.white : Colors.black,
                              hasBorder: true,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
                _filterCategories();
              },
              decoration: InputDecoration(
                hintText: 'Search "Posters"',
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color.fromARGB(255, 252, 250, 250),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _startListening,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _isListening ? Colors.red : const Color.fromARGB(255, 97, 74, 160),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                _isListening ? Icons.mic : Icons.mic_none,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    String title,
    Color backgroundColor,
    String imagePath, {
    Color textColor = Colors.white,
    bool hasBorder = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: hasBorder ? Border.all(color: Colors.grey[300]!) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(imagePath),
              onBackgroundImageError: (_, __) => debugPrint("Image load error"),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
