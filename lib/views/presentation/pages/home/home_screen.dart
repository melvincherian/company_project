import 'dart:convert';

import 'package:company_project/helper/storage_helper.dart';
import 'package:company_project/models/category_modell.dart';
import 'package:company_project/models/get_all_plan_model.dart';
import 'package:company_project/providers/category_provider.dart';
import 'package:company_project/providers/category_providerr.dart';
import 'package:company_project/providers/date_time_provider.dart';
import 'package:company_project/providers/get_all_plan_provider.dart';
import 'package:company_project/providers/poster_provider.dart';
import 'package:company_project/providers/story_provider.dart';
import 'package:company_project/views/presentation/pages/home/details_screen.dart';
import 'package:company_project/views/presentation/pages/home/poster/create_poster_template.dart';
import 'package:company_project/views/presentation/pages/home/poster/poster_maker_screen.dart';
import 'package:company_project/views/presentation/pages/home/search_screen.dart';
import 'package:company_project/views/presentation/widgets/home_carousel.dart';
import 'package:company_project/views/presentation/widgets/story/add_story.dart';
import 'package:company_project/views/presentation/widgets/category_widget.dart';
import 'package:company_project/views/presentation/widgets/date_selector_screen.dart';
import 'package:company_project/views/presentation/widgets/story/stories_widget.dart';
import 'package:company_project/views/presentation/widgets/story/story_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:company_project/models/story_model.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> items = [];
  final String imageUrl =
      "https://fntarizona.com/wp-content/uploads/2017/05/shutterstock_624472886.jpg";

  bool serchValue = false;

  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();

  // final List<Map<String, dynamic>> _bannerData = [
  //   {
  //     'image': 'assets/assets/4db504a1da2c0272db46bf139b7be4d117bf4487.png',
  //     'title': 'Ugadi Posters\nare Ready',
  //     'buttonText': 'Explore Now',
  //   },
  //   {
  //     'image': 'assets/assets/banner2.png', // Add your other banner images
  //     'title': 'Festival\nCollection',
  //     'buttonText': 'Shop Now',
  //   },
  //   {
  //     'image': 'assets/assets/banner3.png', // Add your other banner images
  //     'title': 'Special\nOffers',
  //     'buttonText': 'View Deals',
  //   },
  // ];

  String currentUserId = '680634a4bb1d44fb0c93aae2';

  bool _isLoading = false;

  final TextEditingController _searchController = TextEditingController();
  bool _isListening = false;
  String _searchText = '';

  late stt.SpeechToText _speech;
  List<dynamic> _filteredCategories = [];

  late final CategoryProviderr categoryprovider;
  Map<String, List<Map<String, dynamic>>> _categorizedPosters = {};

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initializeSpeech();
    _loadUserId();
    print('HomeScreen init - about to fetch posters and stories');
    Future.microtask(() {
      print('Inside microtask - calling providers');
      final posterProvider =
          Provider.of<PosterProvider>(context, listen: false);
      final storyProvider = Provider.of<StoryProvider>(context, listen: false);

      posterProvider.fetchPosters().then((_) {
        print(
            'Fetch posters completed - poster count: ${posterProvider.posters.length}');
      });

      storyProvider.fetchStories().then((_) {
        print(
            'Fetch stories completed - story count: ${storyProvider.stories.length}');

        showSubscriptionModal(context);

        categoryprovider =
            Provider.of<CategoryProviderr>(context, listen: false);
      });
    });

    // Fetch festival posters for the selected date when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchFestivalPosters(context.read<DateTimeProvider>().selectedDate);
    });

    Provider.of<StoryProvider>(context, listen: false).setCurrentUser(
      userId: currentUserId,
      userImage: 'https://example.com/avatar.jpg',
      username: 'Your Story',
    );
  }

  Future<void> _fetchCategories() async {
    await Provider.of<CategoryProvider>(context, listen: false)
        .fetchCategories();
    setState(() {
      _filteredCategories =
          Provider.of<CategoryProvider>(context, listen: false).categories;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _speech.stop();
    super.dispose();
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
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    if (_searchText.isEmpty) {
      setState(() {
        _filteredCategories = categoryProvider.categories;
      });
    } else {
      setState(() {
        _filteredCategories = categoryProvider.categories
            .where((category) => category.categoryname
                .toLowerCase()
                .contains(_searchText.toLowerCase()))
            .toList();
      });
    }
  }

  Future<void> _loadUserId() async {
    final userData = await AuthPreferences.getUserData();
    if (userData != null) {
      setState(() {
        currentUserId = userData
            .user.id; // Adjust this based on your LoginResponse structure
      });
      print('User IDddddddddddddddddddddddddddddddddddddddddd: $currentUserId');
    }
  }

  List<dynamic> _searchResults = [];

  // void handleSearch(String query) {
  //   final trimmedQuery = query.trim();

  //   if (trimmedQuery.isEmpty) {
  //     serchValue = false;
  //   } else {
  //     final items = categoryprovider.searchItems(trimmedQuery);
  //     print('melvin$items');

  //     setState(() {
  //       serchValue = true;
  //     });
  //   }
  // }

  // Format date for API request
  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  // Fetch festival posters from API based on selected date
  Future<void> _fetchFestivalPosters(DateTime date) async {
    setState(() {
      _isLoading = true;
      _categorizedPosters = {};
    });

    try {
      final response = await http.post(
        Uri.parse('https://posterbnaobackend.onrender.com/api/poster/festival'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'festivalDate': _formatDate(date)}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> posters = jsonDecode(response.body);

        // Group posters by category
        final Map<String, List<Map<String, dynamic>>> categorizedPosters = {};

        for (var poster in posters) {
          final category = poster['categoryName'];
          if (!categorizedPosters.containsKey(category)) {
            categorizedPosters[category] = [];
          }
          categorizedPosters[category]?.add(poster);
        }

        setState(() {
          _categorizedPosters = categorizedPosters;
          _isLoading = false;
        });

        print('Fetched festival posters: ${posters.length}');
        print('Categories found: ${categorizedPosters.keys.toList()}');
      } else {
        // Handle error
        setState(() {
          _isLoading = false;
        });
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Failed to load festival posters')),
        // );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  // Build a horizontal list of festival posters for a specific category
  Widget _buildFestivalPosterList(
      String category, List<Map<String, dynamic>> posters) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: posters.length,
        itemBuilder: (context, index) {
          final poster = posters[index];
          return Container(
            width: 120,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 169, 137, 126),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => PosterTemplate(
                      //       poster: poster, // Pass the selected poster
                      //       isCustom: false,
                      //     ),
                      //   ),
                      // );
                    },
                    child: Image.network(
                      poster['images'][0],
                      height: 100,
                      width: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 100,
                          width: 120,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          poster['price'] == 0
                              ? 'Free'
                              : '₹ ${poster['price']}',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ],
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

  // void _openAddStory() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => AddStoryWidget(
  //         userId: currentUserId,
  //         onStoryAdded: () {
  //           // Refresh stories after adding
  //           Provider.of<StoryProvider>(context, listen: false).fetchStories();
  //         },
  //       ),
  //     ),
  //   );
  // }

  // void _openStoryViewer(int index) {
  //   final storyProvider = Provider.of<StoryProvider>(context, listen: false);
  //   print('ooooooooooooooooooooooooooooooooooooooooooooo${storyProvider.stories}');

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => StoryViewerScreen(
  //         stories: storyProvider.stories,
  //         viewIndex: index,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    if (_filteredCategories.isEmpty && categoryProvider.categories.isNotEmpty) {
      _filteredCategories = categoryProvider.categories;
    }

    //  bool serchValue=false;
    final searchController = TextEditingController();
    final posterProvider = Provider.of<PosterProvider>(context);
    final storyProvider = Provider.of<StoryProvider>(context);
    final categoryprovider = Provider.of<CategoryProviderr>(context);

    print(
        'Building HomeScreen - PosterProvider isLoading: ${posterProvider.isLoading}');
    print(
        'Building HomeScreen - PosterProvider error: ${posterProvider.error}');
    print(
        'Building HomeScreen - Poster count: ${posterProvider.posters.length}');
    print('Building HomeScreen - Story count: ${storyProvider.stories.length}');

    final posters = posterProvider.posters;
    final stories = storyProvider.stories;

    final filteredStories =
        stories.where((story) => story.userId != currentUserId).toList();

    final ugadiPosters = posters
        .where((poster) => poster.categoryName.toLowerCase() == 'ugadi')
        .toList();

    // Separate lists for clothing, beauty and chemical
    final clothingPosters = posters
        .where((poster) => poster.categoryName.toLowerCase() == 'clothing')
        .toList();

    final beautyPosters = posters
        .where((poster) => poster.categoryName.toLowerCase() == 'beauty')
        .toList();

    final chemicalPosters = posters
        .where((poster) => poster.categoryName.toLowerCase() == 'chemical')
        .toList();

    print('Ugadi poster count: ${ugadiPosters.length}');
    print('Clothing poster count: ${clothingPosters.length}');
    print('Beauty poster count: ${beautyPosters.length}');
    print('Chemical poster count: ${chemicalPosters.length}');
    print('Storieeeeeeeeeeeeeeeeeees: ${stories}');

    bool _currentUserHasStory() {
      final storyProvider = Provider.of<StoryProvider>(context, listen: false);
      return storyProvider.stories
          .any((story) => story.userId == currentUserId);
    }

    // Add this method to get current user's story
    Story? _getCurrentUserStory() {
      final storyProvider = Provider.of<StoryProvider>(context, listen: false);
      try {
        return storyProvider.stories
            .firstWhere((story) => story.userId == currentUserId);
      } catch (e) {
        return null;
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBvqzyx_zoi6q2c0Gd1XnE7wysD9PGOLe3-A&s',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'PMS Software',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Hyderabad',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            builder: (BuildContext context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: const Text('Telugu'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      // Handle language change
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('English'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      // Handle language change
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('Hindi'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      // Handle language change
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('Tamil'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      // Handle language change
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Icon(Icons.translate, size: 24),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey[600], size: 24),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search Poster by Topic',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                          ),
                          controller: searchController,
                          // onChanged: (query) {
                          //   handleSearch(query);
                          // },
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: const Color(0xFF6C4EF9),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: _isListening
                                  ? Colors.red
                                  : const Color.fromARGB(255, 97, 74, 160),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              _isListening ? Icons.mic : Icons.mic_none,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                if (serchValue == false)
                  Column(
                    children: [
                      HomeCarousel(),
                      // Container(
                      //   height: 140,
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(20),
                      //       image: const DecorationImage(
                      //           image: AssetImage(
                      //               'assets/assets/4db504a1da2c0272db46bf139b7be4d117bf4487.png'),
                      //           fit: BoxFit.cover)),
                      //   child: Stack(
                      //     children: [
                      //       Positioned(
                      //           top: 16,
                      //           left: 16,
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               const Text(
                      //                 'Ugadi Posters\nare Ready',
                      //                 style: TextStyle(
                      //                     fontSize: 20,
                      //                     fontWeight: FontWeight.bold,
                      //                     color: Colors.white),
                      //               ),
                      //               const SizedBox(height: 8),
                      //               ElevatedButton(
                      //                   onPressed: () {},
                      //                   style: ElevatedButton.styleFrom(
                      //                       backgroundColor: Colors.white,
                      //                       foregroundColor: Colors.black,
                      //                       shape: RoundedRectangleBorder(
                      //                           borderRadius:
                      //                               BorderRadius.circular(8))),
                      //                   child: const Text(
                      //                     'Explore Now',
                      //                     style: TextStyle(fontSize: 17),
                      //                   ))
                      //             ],
                      //           )),
                      //     ],
                      //   ),
                      // ),

                      SizedBox(
                        height: 30,
                      ),

                      // Stories Section - UPDATED
                      const StoriesWidget(),

                      // StoriesWidget(currentUserId: currentUserId),

                      const SizedBox(height: 15),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Upcoming Festivals',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Consumer<DateTimeProvider>(
                          builder: (context, dateTimeProvider, _) {
                        return DateSelectorRow(
                          selectedDate: dateTimeProvider.selectedDate,
                          onDateSelected: (date) {
                            dateTimeProvider.setStartDate(date);
                            // Fetch festival posters when date is changed
                            _fetchFestivalPosters(date);
                          },
                        );
                      }),

                      // Festival posters based on selected date
                      const SizedBox(height: 20),
                      _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : _categorizedPosters.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.event_busy,
                                          size: 70,
                                          color: const Color(0xFF6C4EF9)
                                              .withOpacity(0.7),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        'No Festivals Found',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Try selecting a different date',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 25),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 12),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          border: Border.all(
                                              color: const Color(0xFF6C4EF9)
                                                  .withOpacity(0.3)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              size: 18,
                                              color: Color(0xFF6C4EF9),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Check Other Dates',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF6C4EF9),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Column(
                                  children:
                                      _categorizedPosters.entries.map((entry) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Category header
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              entry.key, // Category name
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailsScreen(
                                                      category: entry.key
                                                              .toLowerCase() +
                                                          'poster',
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Row(
                                                children: [
                                                  Text(
                                                    'View All',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 19,
                                                    color: Colors.black,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Festival poster list for this category
                                        _buildFestivalPosterList(
                                            entry.key, entry.value),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  }).toList(),
                                ),

                      // Regular category sections
                      // Only show these if we want to display regular categories alongside festival categories

                      // Ugadi Posters Section
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const Text(
                      //       'Ugadi',
                      //       style:
                      //           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      //     ),
                      //     TextButton(
                      //         onPressed: () {
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) => const DetailsScreen(
                      //                       category: 'ugadiposter')));
                      //         },
                      //         child: Row(
                      //           children: [
                      //             const Text(
                      //               'View All',
                      //               style: TextStyle(color: Colors.black),
                      //             ),
                      //             Icon(
                      //               Icons.arrow_forward_ios,
                      //               size: 19,
                      //               color: Colors.black,
                      //             )
                      //           ],
                      //         ))
                      //   ],
                      // ),
                      // _buildPosterList(ugadiPosters),

                      // // Clothing Posters Section
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const Text(
                      //       'Clothing',
                      //       style:
                      //           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      //     ),
                      //     TextButton(
                      //       onPressed: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => const DetailsScreen(
                      //                       category: 'clothingposter',
                      //                     )));
                      //       },
                      //       child: Row(
                      //         children: [
                      //           const Text(
                      //             'View All',
                      //             style: TextStyle(color: Colors.black),
                      //           ),
                      //           Icon(
                      //             Icons.arrow_forward_ios,
                      //             size: 19,
                      //             color: Colors.black,
                      //           )
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),
                      // _buildPosterList(clothingPosters),

                      // // Beauty Posters Section
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const Text(
                      //       'Beauty',
                      //       style:
                      //           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      //     ),
                      //     TextButton(
                      //       onPressed: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => const DetailsScreen(
                      //                       category: 'beautyposter',
                      //                     )));
                      //       },
                      //       child: Row(
                      //         children: [
                      //           const Text(
                      //             'View All',
                      //             style: TextStyle(color: Colors.black),
                      //           ),
                      //           Icon(
                      //             Icons.arrow_forward_ios,
                      //             size: 19,
                      //             color: Colors.black,
                      //           )
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),
                      // _buildPosterList(beautyPosters),

                      // // Chemical Posters Section
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const Text(
                      //       'Chemical',
                      //       style:
                      //           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      //     ),
                      //     TextButton(
                      //       onPressed: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => const DetailsScreen(
                      //                     category: 'chemicalposter')));
                      //       },
                      //       child: Row(
                      //         children: [
                      //           const Text(
                      //             'View All',
                      //             style: TextStyle(color: Colors.black),
                      //           ),
                      //           Icon(
                      //             Icons.arrow_forward_ios,
                      //             size: 19,
                      //             color: Colors.black,
                      //           )
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),
                      // _buildPosterList(chemicalPosters),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Extracted method to build poster list to avoid code duplication
  Widget _buildPosterList(List posters) {
    return SizedBox(
      height: 150,
      child: posters.isEmpty
          ? const Center(
              child: Text(
                'No posters available',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: posters.length,
              itemBuilder: (context, index) {
                final poster = posters[index];
                return Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 169, 137, 126),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 4)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PosterMakerApp(
                                  poster: poster,
                                  isCustom: false,
                                ),
                              ),
                            );
                          },
                          child: Image.network(
                            poster.images[0],
                            height: 100,
                            width: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 100,
                                width: 120,
                                color: Colors.grey[300],
                                child: const Icon(Icons.image_not_supported),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                poster.price == 0
                                    ? 'Free'
                                    : '₹ ${poster.price}',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
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

  void showSubscriptionModal(BuildContext context) {
    // Get the provider instance
    final planProvider =
        Provider.of<GetAllPlanProvider>(context, listen: false);

    // Fetch plans if not already loaded
    if (planProvider.plans.isEmpty && !planProvider.isLoading) {
      planProvider.fetchAllPlans();
    }

    // Track the selected plan
    String? selectedPlanId;
    bool showPaymentOptions = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors
          .transparent, // Make the background transparent to apply our own padding
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return Container(
            // Add padding around the entire modal
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            // Make it take up to 90% of the screen height
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with padding
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Subscriptions Plans',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.grey.shade700),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),

                // Subscription plans (scrollable if needed)
                Flexible(
                  child: Consumer<GetAllPlanProvider>(
                    builder: (context, provider, child) {
                      // Show loading indicator while fetching data
                      if (provider.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      // Show error message if any
                      if (provider.error != null) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Failed to load plans',
                                style: TextStyle(color: Colors.red),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () => provider.fetchAllPlans(),
                                child: Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }

                      // Show plans if available
                      if (provider.plans.isNotEmpty) {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              const SizedBox(height: 12),
                              ...provider.plans.map((plan) {
                                // Determine card color based on plan name
                                Color cardColor = Colors.teal.shade50;
                                Color priceColor = Colors.green;
                                IconData planIcon = Icons.verified_user;

                                if (plan.name
                                    .toUpperCase()
                                    .contains('COPPER')) {
                                  cardColor = Colors.orange.shade50;
                                  priceColor = Colors.orange;
                                  planIcon = Icons.workspace_premium;
                                } else if (plan.name
                                    .toUpperCase()
                                    .contains('SILVER')) {
                                  cardColor = Colors.blueGrey.shade50;
                                  priceColor = Colors.blueGrey;
                                  planIcon = Icons.star;
                                } else if (plan.name
                                    .toUpperCase()
                                    .contains('GOLD')) {
                                  cardColor = Colors.amber.shade50;
                                  priceColor = Colors.amber.shade700;
                                  planIcon = Icons.auto_awesome;
                                }

                                return Column(
                                  children: [
                                    _buildSubscriptionCard(
                                      context: context,
                                      planTitle: plan.name.toUpperCase(),
                                      price: plan.offerPrice == 0
                                          ? '₹Free'
                                          : '₹${plan.offerPrice}',
                                      priceColor: priceColor,
                                      cardColor: cardColor,
                                      icon: planIcon,
                                      features: plan.features,
                                      isSelected: selectedPlanId == plan.id,
                                      onTap: () {
                                        setState(() {
                                          selectedPlanId = plan.id;
                                          showPaymentOptions = true;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                        );
                      }

                      // No plans available
                      return const Center(
                        child: Text('No subscription plans available'),
                      );
                    },
                  ),
                ),

                // Payment options container - shows when a plan is selected
                if (showPaymentOptions)
                  Consumer<GetAllPlanProvider>(
                    builder: (context, provider, child) {
                      final selectedPlan = provider.plans.firstWhere(
                        (plan) => plan.id == selectedPlanId,
                        orElse: () => GetAllPlanModel(
                          id: '',
                          name: 'Unknown',
                          originalPrice: 0,
                          offerPrice: 0,
                          duration: '',
                          discountPercentage: 0,
                          features: [],
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        ),
                      );

                      final price = selectedPlan.offerPrice == 0
                          ? '₹Free'
                          : '₹${selectedPlan.offerPrice}';

                      return _buildPaymentOptionsContainer(
                        context: context,
                        selectedPlan: selectedPlan.name,
                        price: price,
                        onClose: () {
                          setState(() {
                            showPaymentOptions = false;
                            selectedPlanId = null;
                          });
                        },
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubscriptionCard({
    required BuildContext context,
    required String planTitle,
    required String price,
    required Color priceColor,
    required Color cardColor,
    required IconData icon,
    required List<String> features,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.deepPurple : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon,
                    color:
                        isSelected ? Colors.deepPurple : Colors.grey.shade700),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    planTitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle,
                          size: 16, color: Colors.green),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          feature,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                )),
            // Add padding at the bottom
            const SizedBox(height: 8),
            // Price container at the bottom right
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Text(
                  price,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: priceColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOptionsContainer({
    required BuildContext context,
    required String selectedPlan,
    required String price,
    required VoidCallback onClose,
  }) {
    // List of available payment methods
    final paymentMethods = [
      {'name': 'Wallet Balance', 'icon': Icons.account_balance_wallet},
      {'name': 'UPI', 'icon': Icons.payment},
      {'name': 'Credit/Debit Card', 'icon': Icons.credit_card},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Payment Options',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, size: 20, color: Colors.grey.shade700),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: onClose,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Selected Plan: $selectedPlan - $price',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Choose a payment method:',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 12),

          // Payment method options
          ...paymentMethods.map((method) => _buildPaymentMethodTile(
                icon: method['icon'] as IconData,
                name: method['name'] as String,
                onTap: () {
                  // Handle payment method selection
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected ${method['name']} for payment'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              )),

          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Process payment
                Navigator.pop(context); // Close the modal
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Processing payment for $selectedPlan'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                price == '₹Free' ? 'ACTIVATE PLAN' : 'PAY NOW',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodTile({
    required IconData icon,
    required String name,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.deepPurple),
            const SizedBox(width: 12),
            Text(
              name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
