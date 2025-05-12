// import 'package:company_project/views/presentation/pages/home/navbar_screen.dart';
// import 'package:flutter/material.dart';

// class ChangeIndustryScreen extends StatelessWidget {
//   const ChangeIndustryScreen({super.key});

//   final List<Map<String, String>> _industries = const [
//     {'name': 'Apparel & Clothing', 'image': 'assets/apparel.png'},
//     {'name': 'Arts & Entertainment', 'image': 'assets/arts.png'},
//     {'name': 'Astrologer', 'image': 'assets/astrologer.png'},
//     {'name': 'Audit & Taxation', 'image': 'assets/tax.png'},
//     {'name': 'Automotive Service', 'image': 'assets/automotive.png'},
//     {'name': 'Bag Shop', 'image': 'assets/bag.png'},
//     {'name': 'Bakery & Confectionery', 'image': 'assets/bakery.png'},
//     {'name': 'Banking & Finance', 'image': 'assets/banking.png'},
//     {'name': 'Beauty, Cosmetic & Personal Care', 'image': 'assets/beauty.png'},
//     {'name': 'Bicycle Shop', 'image': 'assets/bicycle.png'},
//     {'name': 'Chemicals', 'image': 'assets/chemicals.png'},
//     {
//       'name': 'Computer Sales, Repair, & Maintenance',
//       'image': 'assets/computer.png'
//     },
//     {'name': 'Contractor & Construction', 'image': 'assets/construction.png'},
//     {'name': 'Dairy & Milk', 'image': 'assets/dairy.png'},
//     {'name': 'Dance Institute', 'image': 'assets/dance.png'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: const Icon(Icons.arrow_back_ios)),
//         title: const Text(
//           'Select your Business Industry',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(60.0),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search here...',
//                 prefixIcon: const Icon(Icons.search),
//                 suffixIcon: const Icon(Icons.mic),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(8.0),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           childAspectRatio: 1.0,
//           crossAxisSpacing: 8.0,
//           mainAxisSpacing: 8.0,
//         ),
//         itemCount: _industries.length,
//         itemBuilder: (context, index) {
//           final industry = _industries[index];
//           return Card(
//             elevation: 2.0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const NavbarScreen()));
//               },
//               borderRadius: BorderRadius.circular(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 30.0,
//                     backgroundImage: AssetImage(
//                         industry['image']!), // Use your image asset here
//                     backgroundColor: Colors.grey[200], // Fallback color
//                   ),
//                   const SizedBox(height: 8.0),
//                   Text(
//                     industry['name']!,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(fontSize: 12.0),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }




// 



import 'package:company_project/providers/category_providerr.dart';
import 'package:company_project/providers/provider_main_category.dart';
import 'package:company_project/views/presentation/pages/home/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:company_project/providers/category_provider.dart';
import 'package:company_project/views/presentation/pages/home/navbar_screen.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChangeIndustryScreen extends StatefulWidget {
  const ChangeIndustryScreen({super.key});

  @override
  State<ChangeIndustryScreen> createState() => _ChangeIndustryScreenState();
}

class _ChangeIndustryScreenState extends State<ChangeIndustryScreen> {
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
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => const NavbarScreen()),
                              // );
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
