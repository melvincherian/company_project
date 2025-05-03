// import 'dart:convert';

// import 'package:company_project/providers/date_time_provider.dart';
// import 'package:company_project/providers/poster_provider.dart';
// import 'package:company_project/providers/story_provider.dart';
// import 'package:company_project/views/presentation/pages/home/details_screen.dart';
// import 'package:company_project/views/presentation/pages/home/poster/create_poster_template.dart';
// import 'package:company_project/views/presentation/widgets/add_story.dart';
// import 'package:company_project/views/presentation/widgets/date_selector_screen.dart';
// import 'package:company_project/views/presentation/widgets/story_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:company_project/models/story_model.dart';
// import 'package:http/http.dart' as http;

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final String currentUserId = '680634a4bb1d44fb0c93aae2';
//    bool _isLoading = false;
//   Map<String, List<Map<String, dynamic>>> _categorizedPosters = {};

//   @override
//   void initState() {
//     super.initState();
//     print('HomeScreen init - about to fetch posters and stories');
//     Future.microtask(() {
//       print('Inside microtask - calling providers');
//       final posterProvider =
//           Provider.of<PosterProvider>(context, listen: false);
//       final storyProvider = Provider.of<StoryProvider>(context, listen: false);

//       posterProvider.fetchPosters().then((_) {
//         print(
//             'Fetch posters completed - poster count: ${posterProvider.posters.length}');
//       });

//       storyProvider.fetchStories().then((_) {
//         print(
//             'Fetch stories completed - story count: ${storyProvider.stories.length}');
//       });
//     });

//         WidgetsBinding.instance.addPostFrameCallback((_) {
//       _fetchFestivalPosters(context.read<DateTimeProvider>().selectedDate);
//     });
//   }

//     String _formatDate(DateTime date) {
//     return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
//   }


  
//   // Fetch festival posters from API based on selected date
//   Future<void> _fetchFestivalPosters(DateTime date) async {
//     setState(() {
//       _isLoading = true;
//       _categorizedPosters = {};
//     });

//     try {
//       final response = await http.post(
//         Uri.parse('https://posterbnaobackend.onrender.com/api/poster/festival'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'festivalDate': _formatDate(date)}),
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> posters = jsonDecode(response.body);
        
//         // Group posters by category
//         final Map<String, List<Map<String, dynamic>>> categorizedPosters = {};
        
//         for (var poster in posters) {
//           final category = poster['categoryName'];
//           if (!categorizedPosters.containsKey(category)) {
//             categorizedPosters[category] = [];
//           }
//           categorizedPosters[category]?.add(poster);
//         }
        
//         setState(() {
//           _categorizedPosters = categorizedPosters;
//           _isLoading = false;
//         });
//       } else {
//         // Handle error
//         setState(() {
//           _isLoading = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to load festival posters')),
//         );
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: ${e.toString()}')),
//       );
//     }
//   }

//   void _openAddStory() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddStoryWidget(
//           userId: currentUserId,
//           onStoryAdded: () {
//             // Refresh stories after adding
//             Provider.of<StoryProvider>(context, listen: false).fetchStories();
//           },
//         ),
//       ),
//     );
//   }

//   void _openStoryViewer(int index) {
//     final storyProvider = Provider.of<StoryProvider>(context, listen: false);

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => StoryViewerScreen(
//           stories: storyProvider.stories,
//           initialIndex: index,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final posterProvider = Provider.of<PosterProvider>(context);
//     final storyProvider = Provider.of<StoryProvider>(context);

//     print(
//         'Building HomeScreen - PosterProvider isLoading: ${posterProvider.isLoading}');
//     print(
//         'Building HomeScreen - PosterProvider error: ${posterProvider.error}');
//     print(
//         'Building HomeScreen - Poster count: ${posterProvider.posters.length}');
//     print('Building HomeScreen - Story count: ${storyProvider.stories.length}');

//     final posters = posterProvider.posters;
//     final stories = storyProvider.stories;

//     final ugadiPosters = posters
//         .where((poster) => poster.categoryName.toLowerCase() == 'ugadi')
//         .toList();

//     // Separate lists for clothing, beauty and chemical
//     final clothingPosters = posters
//         .where((poster) => poster.categoryName.toLowerCase() == 'clothing')
//         .toList();

//     final beautyPosters = posters
//         .where((poster) => poster.categoryName.toLowerCase() == 'beauty')
//         .toList();

//     final chemicalPosters = posters
//         .where((poster) => poster.categoryName.toLowerCase() == 'chemical')
//         .toList();

//     print('Ugadi poster count: ${ugadiPosters.length}');
//     print('Clothing poster count: ${clothingPosters.length}');
//     print('Beauty poster count: ${beautyPosters.length}');
//     print('Chemical poster count: ${chemicalPosters.length}');
//     print('Storieeeeeeeeeeeeeeeeeees: ${stories}');

//     bool _currentUserHasStory() {
//       final storyProvider = Provider.of<StoryProvider>(context, listen: false);
//       return storyProvider.stories
//           .any((story) => story.userId == currentUserId);
//     }

//     // Add this method to get current user's story
//     Story? _getCurrentUserStory() {
//       final storyProvider = Provider.of<StoryProvider>(context, listen: false);
//       try {
//         return storyProvider.stories
//             .firstWhere((story) => story.userId == currentUserId);
//       } catch (e) {
//         return null;
//       }
//     }

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         const CircleAvatar(
//                           radius: 25,
//                           backgroundImage: NetworkImage(
//                             'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBvqzyx_zoi6q2c0Gd1XnE7wysD9PGOLe3-A&s',
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'PMS Software',
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               'Hyderabad',
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.black.withOpacity(0.6),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: Colors.black12),
//                       ),
//                       child: const Icon(Icons.translate, size: 24),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(Icons.search, color: Colors.grey[600], size: 24),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: 'Search Poster by Topic',
//                             hintStyle: TextStyle(color: Colors.grey[600]),
//                           ),
//                         ),
//                       ),
//                       const CircleAvatar(
//                         radius: 23,
//                         backgroundColor: Color(0xFF6C4EF9),
//                         child: Icon(Icons.mic, color: Colors.white),
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 Container(
//                   height: 140,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       image: const DecorationImage(
//                           image: AssetImage(
//                               'assets/assets/4db504a1da2c0272db46bf139b7be4d117bf4487.png'),
//                           fit: BoxFit.cover)),
//                   child: Stack(
//                     children: [
//                       Positioned(
//                           top: 16,
//                           left: 16,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Ugadi Posters\nare Ready',
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                               const SizedBox(height: 8),
//                               ElevatedButton(
//                                   onPressed: () {},
//                                   style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.white,
//                                       foregroundColor: Colors.black,
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(8))),
//                                   child: const Text(
//                                     'Explore Now',
//                                     style: TextStyle(fontSize: 17),
//                                   ))
//                             ],
//                           )),
//                     ],
//                   ),
//                 ),

//                 // Stories Section - UPDATED
//                 SizedBox(
//                   height: 120,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: stories.length +
//                         (!_currentUserHasStory()
//                             ? 1
//                             : 0), // Add 1 for "Add Story" if user has no story
//                     itemBuilder: (context, index) {
//                       // First position shows either "Add Story" or user's own story
//                       if (index == 0) {
//                         // If user has no story, show "Add Story" button
//                         if (!_currentUserHasStory()) {
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 14),
//                             child: GestureDetector(
//                               onTap: _openAddStory,
//                               child: Column(
//                                 children: [
//                                   const SizedBox(height: 16),
//                                   Stack(
//                                     children: [
//                                       CircleAvatar(
//                                         radius: 30,
//                                         backgroundColor: Colors.grey[300],
//                                         child: const Icon(
//                                           Icons.add,
//                                           size: 32,
//                                           color: Colors.black87,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 4),
//                                   const Text(
//                                     'Add Story',
//                                     style: TextStyle(color: Colors.black),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         } else {
//                           // Show user's own story first
//                           final userStory = _getCurrentUserStory()!;
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 14),
//                             child: GestureDetector(
//                               onTap: () {
//                                 // Find the index of this story in the overall stories list
//                                 final storyIndex = stories
//                                     .indexWhere((s) => s.id == userStory.id);
//                                 _openStoryViewer(storyIndex);
//                               },
//                               child: Column(
//                                 children: [
//                                   const SizedBox(height: 16),
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       border: Border.all(
//                                         color: const Color(0xFF6C4EF9),
//                                         width: 2,
//                                       ),
//                                     ),
//                                     child: CircleAvatar(
//                                       radius: 30,
//                                       backgroundImage: NetworkImage(
//                                         'https://posterbnaobackend.onrender.com/${userStory.image}',
//                                       ),
//                                       onBackgroundImageError:
//                                           (exception, stackTrace) {
//                                         print(
//                                             'Error loading story image: $exception');
//                                       },
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   const Text(
//                                     'Your Story',
//                                     style: TextStyle(color: Colors.black),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         }
//                       } else {
//                         // For other users' stories
//                         // Adjust index based on whether user has story
//                         final adjustedIndex =
//                             _currentUserHasStory() ? index : index - 1;

//                         // Filter out current user's story from the list shown here
//                         final filteredStories = stories.toList();
//                         // .where((s) => s.userId == currentUserId)
//                         // .toList();

//                         if (adjustedIndex < filteredStories.length) {
//                           final story = filteredStories[adjustedIndex];

//                           // Find the index of this story in the overall stories list for viewer
//                           final viewerIndex =
//                               stories.indexWhere((s) => s.id == story.id);

//                           return Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 14),
//                             child: GestureDetector(
//                               onTap: () => _openStoryViewer(viewerIndex),
//                               child: Column(
//                                 children: [
//                                   const SizedBox(height: 16),
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       border: Border.all(
//                                         color: const Color(0xFF6C4EF9),
//                                         width: 2,
//                                       ),
//                                     ),
//                                     child: CircleAvatar(
//                                       radius: 30,
//                                       backgroundImage: NetworkImage(
//                                         'https://posterbnaobackend.onrender.com/${story.image}',
//                                       ),
//                                       onBackgroundImageError:
//                                           (exception, stackTrace) {
//                                         print(
//                                             'Error loading story image: $exception');
//                                       },
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   const Text(
//                                     'Story',
//                                     style: TextStyle(color: Colors.black),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         }
//                         return const SizedBox
//                             .shrink(); // Fallback for any out-of-bounds indices
//                       }
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Upcoming Festivals',
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 15),
//                 Consumer<DateTimeProvider>(
//                     builder: (context, dateTimeProvider, _) {
//                   return DateSelectorRow(
//                     selectedDate: dateTimeProvider.selectedDate,
//                     onDateSelected: (date) {
//                       dateTimeProvider.setStartDate(date);
//                     },
//                   );
//                 }),

//                 // Ugadi Posters Section
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Ugadi',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const DetailsScreen(
//                                       category: 'ugadiposter')));
//                         },
//                         child: Row(
//                           children: [
//                             const Text(
//                               'View All',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                             Icon(
//                               Icons.arrow_forward_ios,
//                               size: 19,
//                               color: Colors.black,
//                             )
//                           ],
//                         ))
//                   ],
//                 ),
//                 _buildPosterList(ugadiPosters),

//                 // Clothing Posters Section
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Clothing',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const DetailsScreen(
//                                       category: 'clothingposter',
//                                     )));
//                       },
//                       child: Row(
//                         children: [
//                           const Text(
//                             'View All',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                           Icon(
//                             Icons.arrow_forward_ios,
//                             size: 19,
//                             color: Colors.black,
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 _buildPosterList(clothingPosters),

//                 // Beauty Posters Section
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Beauty',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const DetailsScreen(
//                                       category: 'beautyposter',
//                                     )));
//                       },
//                       child: Row(
//                         children: [
//                           const Text(
//                             'View All',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                           Icon(
//                             Icons.arrow_forward_ios,
//                             size: 19,
//                             color: Colors.black,
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 _buildPosterList(beautyPosters),

//                 // Chemical Posters Section
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Chemical',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const DetailsScreen(
//                                     category: 'chemicalposter')));
//                       },
//                       child: Row(
//                         children: [
//                           const Text(
//                             'View All',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                           Icon(
//                             Icons.arrow_forward_ios,
//                             size: 19,
//                             color: Colors.black,
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 _buildPosterList(chemicalPosters),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Extracted method to build poster list to avoid code duplication
//   Widget _buildPosterList(List posters) {
//     return SizedBox(
//       height: 150,
//       child: posters.isEmpty
//           ? const Center(
//               child: Text(
//                 'No posters available',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             )
//           : ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: posters.length,
//               itemBuilder: (context, index) {
//                 final poster = posters[index];
//                 return Container(
//                   width: 120,
//                   margin: const EdgeInsets.only(right: 12),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: const Color.fromARGB(255, 169, 137, 126),
//                     boxShadow: const [
//                       BoxShadow(color: Colors.black12, blurRadius: 4)
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: const BorderRadius.vertical(
//                             top: Radius.circular(12)),
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => PosterTemplate(
//                                   poster: poster,
//                                   isCustom: false,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Image.network(
//                             poster.images[0],
//                             height: 100,
//                             width: 120,
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               return Container(
//                                 height: 100,
//                                 width: 120,
//                                 color: Colors.grey[300],
//                                 child: const Icon(Icons.image_not_supported),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(6.0),
//                         child: Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 poster.price == 0
//                                     ? 'Free'
//                                     : '₹ ${poster.price}',
//                                 style: const TextStyle(
//                                     fontSize: 12, color: Colors.white),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }











import 'dart:convert';

import 'package:company_project/models/poster_model.dart';
import 'package:company_project/providers/date_time_provider.dart';
import 'package:company_project/providers/poster_provider.dart';
import 'package:company_project/providers/story_provider.dart';
import 'package:company_project/views/presentation/pages/home/details_screen.dart';
import 'package:company_project/views/presentation/pages/home/poster/create_poster_template.dart';
import 'package:company_project/views/presentation/widgets/add_story.dart';
import 'package:company_project/views/presentation/widgets/date_selector_screen.dart';
import 'package:company_project/views/presentation/widgets/story_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:company_project/models/story_model.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String currentUserId = '680634a4bb1d44fb0c93aae2';
  bool _isLoading = false;
  Map<String, List<Map<String, dynamic>>> _categorizedPosters = {};

  @override
  void initState() {
    super.initState();
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
      });
    });

    // Fetch festival posters for the selected date when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchFestivalPosters(context.read<DateTimeProvider>().selectedDate);
    });
  }

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
  Widget _buildFestivalPosterList(String category, List<Map<String, dynamic>> posters) {
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
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12)),
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

  void _openAddStory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddStoryWidget(
          userId: currentUserId,
          onStoryAdded: () {
            // Refresh stories after adding
            Provider.of<StoryProvider>(context, listen: false).fetchStories();
          },
        ),
      ),
    );
  }

  void _openStoryViewer(int index) {
    final storyProvider = Provider.of<StoryProvider>(context, listen: false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryViewerScreen(
          stories: storyProvider.stories,
          initialIndex: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final posterProvider = Provider.of<PosterProvider>(context);
    final storyProvider = Provider.of<StoryProvider>(context);

    print(
        'Building HomeScreen - PosterProvider isLoading: ${posterProvider.isLoading}');
    print(
        'Building HomeScreen - PosterProvider error: ${posterProvider.error}');
    print(
        'Building HomeScreen - Poster count: ${posterProvider.posters.length}');
    print('Building HomeScreen - Story count: ${storyProvider.stories.length}');

    final posters = posterProvider.posters;
    final stories = storyProvider.stories;

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
                      child: const Icon(Icons.translate, size: 24),
                    )
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
                        ),
                      ),
                      const CircleAvatar(
                        radius: 23,
                        backgroundColor: Color(0xFF6C4EF9),
                        child: Icon(Icons.mic, color: Colors.white),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage(
                              'assets/assets/4db504a1da2c0272db46bf139b7be4d117bf4487.png'),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 16,
                          left: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ugadi Posters\nare Ready',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  child: const Text(
                                    'Explore Now',
                                    style: TextStyle(fontSize: 17),
                                  ))
                            ],
                          )),
                    ],
                  ),
                ),

                // Stories Section - UPDATED
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: stories.length +
                        (!_currentUserHasStory()
                            ? 1
                            : 0), // Add 1 for "Add Story" if user has no story
                    itemBuilder: (context, index) {
                      // First position shows either "Add Story" or user's own story
                      if (index == 0) {
                        // If user has no story, show "Add Story" button
                        if (!_currentUserHasStory()) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: GestureDetector(
                              onTap: _openAddStory,
                              child: Column(
                                children: [
                                  const SizedBox(height: 16),
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey[300],
                                        child: const Icon(
                                          Icons.add,
                                          size: 32,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Add Story',
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {
                          // Show user's own story first
                          final userStory = _getCurrentUserStory()!;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: GestureDetector(
                              onTap: () {
                                // Find the index of this story in the overall stories list
                                final storyIndex = stories
                                    .indexWhere((s) => s.id == userStory.id);
                                _openStoryViewer(storyIndex);
                              },
                              child: Column(
                                children: [
                                  const SizedBox(height: 16),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF6C4EF9),
                                        width: 2,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                        'https://posterbnaobackend.onrender.com/${userStory.image}',
                                      ),
                                      onBackgroundImageError:
                                          (exception, stackTrace) {
                                        print(
                                            'Error loading story image: $exception');
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Your Story',
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      } else {
                        // For other users' stories
                        // Adjust index based on whether user has story
                        final adjustedIndex =
                            _currentUserHasStory() ? index : index - 1;

                        // Filter out current user's story from the list shown here
                        final filteredStories = stories.toList();
                        // .where((s) => s.userId == currentUserId)
                        // .toList();

                        if (adjustedIndex < filteredStories.length) {
                          final story = filteredStories[adjustedIndex];

                          // Find the index of this story in the overall stories list for viewer
                          final viewerIndex =
                              stories.indexWhere((s) => s.id == story.id);

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: GestureDetector(
                              onTap: () => _openStoryViewer(viewerIndex),
                              child: Column(
                                children: [
                                  const SizedBox(height: 16),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF6C4EF9),
                                        width: 2,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                        'https://posterbnaobackend.onrender.com/${story.image}',
                                      ),
                                      onBackgroundImageError:
                                          (exception, stackTrace) {
                                        print(
                                            'Error loading story image: $exception');
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Story',
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        return const SizedBox
                            .shrink(); // Fallback for any out-of-bounds indices
                      }
                    },
                  ),
                ),
                const SizedBox(height: 15),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Upcoming Festivals',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
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
                  }
                ),
                
                // Festival posters based on selected date
                const SizedBox(height: 20),
                _isLoading 
                  ? const Center(child: CircularProgressIndicator())
                  : _categorizedPosters.isEmpty
                      ? const Center(
                          child: Text(
                            'No festivals found for selected date',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : Column(
                          children: _categorizedPosters.entries.map((entry) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Category header
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      entry.key, // Category name
                                      style: const TextStyle(
                                        fontSize: 18, 
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailsScreen(
                                              category: entry.key.toLowerCase() + 'poster',
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Row(
                                        children: [
                                           Text(
                                            'View All',
                                            style: TextStyle(color: Colors.black),
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
                                _buildFestivalPosterList(entry.key, entry.value),
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
                                builder: (context) => PosterTemplate(
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
}