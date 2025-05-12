// // ignore_for_file: prefer_const_constructors_in_immutables, unused_local_variable

// import 'package:company_project/providers/beauty_provider.dart';
// import 'package:company_project/providers/chemical_provider.dart';
// import 'package:company_project/providers/clothing_provider.dart';
// import 'package:company_project/providers/ugadi_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CategoryScreen extends StatefulWidget {
//   CategoryScreen({super.key});

//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   final List<String> categories = [
//     'Business Ads',
//     'Education',
//     'Ugadi',
//     'Beauty',
//     'Chemical'
//   ];

//   final Map<String, List<String>> sectionItems = {
//     'Ugadi Special': ['Ugadi1', 'Ugadi2', 'Ugadi3'],
//     'Chemical': ['Chemical1', 'Chemical2', 'Chemical3'],
//     'Clothing': ['Clothing1', 'Clothing2', 'Clothing3'],
//     'Beauty': ['Beauty1', 'Beauty2', 'Beauty3']
//   };

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() =>
//         Provider.of<ChemicalProvider>(context, listen: false).fetchChemicals());
//     Future.microtask(() =>
//         Provider.of<ClothingProvider>(context, listen: false).fetchClothing());
//     Future.microtask(() =>
//         Provider.of<BeautyProvider>(context, listen: false).fetchBeauty());
//     Future.microtask(
//         () => Provider.of<UgadiProvider>(context, listen: false).fetchUgadi());
//   }

//   @override
//   Widget build(BuildContext context) {
//     final chemicalProvider = Provider.of<ChemicalProvider>(context);
//     final clothingProvider = Provider.of<ClothingProvider>(context);
//     final beautyProvider = Provider.of<BeautyProvider>(context);
//     final ugadiProvider = Provider.of<UgadiProvider>(context);

//     final chemicals = chemicalProvider.chemical;
//     final clothing = clothingProvider.clothing;
//     final beauty = beautyProvider.beauty;
//     final ugady = ugadiProvider.ugadi;

//     final chemicalposters = chemicals.where(
//         (chemicals) => chemicals.categoryName.toLowerCase() == 'chemical');
//     final clothingposters = clothing
//         .where((clothing) => clothing.categoryName.toLowerCase() == 'clothing');
//     final beautyposters =
//         beauty.where((beauty) => beauty.categoryName.toLowerCase() == 'beauty');
//     final ugadiposters =
//         beauty.where((ugady) => ugady.categoryName.toLowerCase() == 'ugady');

//     return Scaffold(
//       body: SafeArea(
//           child: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Categories',
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Icon(Icons.translate),
//                     ),
//                     const SizedBox(
//                       width: 12,
//                     ),
//                     CircleAvatar(
//                       backgroundColor: Colors.grey[200],
//                       child: const Icon(Icons.search),
//                     )
//                   ],
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                   children: categories.map((cat) {
//                 return Padding(
//                   padding: const EdgeInsets.only(right: 8),
//                   child: Chip(
//                     label: Text(cat),
//                     backgroundColor: cat == 'Business Ads'
//                         ? const Color.fromARGB(255, 107, 22, 255)
//                         : const Color.fromARGB(255, 250, 250, 250),
//                     labelStyle: TextStyle(
//                         color:
//                             cat == 'Business Ads' ? Colors.white : Colors.grey),
//                   ),
//                 );
//               }).toList()),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Ugadi Special',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(
//                   width: 165,
//                 ),
//                 TextButton(
//                     onPressed: () {},
//                     child: const Text(
//                       'View All',
//                       style: TextStyle(color: Colors.black),
//                     )),
//                 Icon(Icons.arrow_forward_ios)
//               ],
//             ),
//             SizedBox(
//               height: 110,
//               child: Consumer<UgadiProvider>(
//                 builder: (context, provider, child) {
//                   if (provider.isLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (provider.error != null) {
//                     return Center(child: Text("Error: ${provider.error}"));
//                   } else {
//                     final ugadiposters = provider.ugadi;

//                     return ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: ugadiposters.length,
//                       itemBuilder: (context, index) {
//                         final poster = ugadiposters[index];
//                         return Container(
//                           width: 120,
//                           margin: const EdgeInsets.only(right: 12),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: const Color.fromARGB(255, 247, 158, 106),
//                             boxShadow: const [BoxShadow(color: Colors.black12)],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: const BorderRadius.vertical(
//                                   top: Radius.circular(12),
//                                 ),
//                                 child: Image.network(
//                                   poster.images.isNotEmpty
//                                       ? poster.images[0]
//                                       : 'https://via.placeholder.com/120x100',
//                                   height: 100,
//                                   width: 120,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//             Row(
//               children: [
//                 const Text(
//                   'Chemical',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(
//                   width: 199,
//                 ),
//                 TextButton(
//                     onPressed: () {},
//                     child: const Text(
//                       'View All',
//                       style: TextStyle(color: Colors.black),
//                     )),
//                 const Icon(Icons.arrow_forward_ios)
//               ],
//             ),
//             SizedBox(
//               height: 110,
//               child: Consumer<ChemicalProvider>(
//                 builder: (context, provider, child) {
//                   if (provider.isLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (provider.error != null) {
//                     return Center(child: Text("Error: ${provider.error}"));
//                   } else {
//                     final chemicalposters = provider.chemical;

//                     return ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: chemicalposters.length,
//                       itemBuilder: (context, index) {
//                         final poster = chemicalposters[index];
//                         return Container(
//                           width: 120,
//                           margin: const EdgeInsets.only(right: 12),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: const Color.fromARGB(255, 247, 158, 106),
//                             boxShadow: const [BoxShadow(color: Colors.black12)],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: const BorderRadius.vertical(
//                                   top: Radius.circular(12),
//                                 ),
//                                 child: Image.network(
//                                   poster.images.isNotEmpty
//                                       ? poster.images[0]
//                                       : 'https://via.placeholder.com/120x100',
//                                   height: 100,
//                                   width: 120,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//             Row(
//               children: [
//                 const Text(
//                   'Clothing',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(
//                   width: 210,
//                 ),
//                 TextButton(
//                     onPressed: () {},
//                     child: const Text(
//                       'View All',
//                       style: TextStyle(color: Colors.black),
//                     )),
//                 const Icon(Icons.arrow_forward_ios)
//               ],
//             ),
//             SizedBox(
//               height: 110,
//               child: Consumer<ClothingProvider>(
//                 builder: (context, provider, child) {
//                   if (provider.isLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (provider.error != null) {
//                     return Center(child: Text("Error: ${provider.error}"));
//                   } else {
//                     final clothingposters = provider.clothing;

//                     return ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: clothingposters.length,
//                       itemBuilder: (context, index) {
//                         final poster = clothingposters[index];
//                         return Container(
//                           width: 120,
//                           margin: const EdgeInsets.only(right: 12),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: const Color.fromARGB(255, 247, 158, 106),
//                             boxShadow: const [BoxShadow(color: Colors.black12)],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: const BorderRadius.vertical(
//                                   top: Radius.circular(12),
//                                 ),
//                                 child: Image.network(
//                                   poster.images.isNotEmpty
//                                       ? poster.images[0]
//                                       : 'https://via.placeholder.com/120x100',
//                                   height: 100,
//                                   width: 120,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//             Row(
//               children: [
//                 const Text(
//                   'Beauty',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(
//                   width: 220,
//                 ),
//                 TextButton(
//                     onPressed: () {},
//                     child: const Text(
//                       'View All',
//                       style: TextStyle(color: Colors.black),
//                     )),
//                 const Icon(Icons.arrow_forward_ios)
//               ],
//             ),
//             SizedBox(
//               height: 110,
//               child: Consumer<BeautyProvider>(
//                 builder: (context, provider, child) {
//                   if (provider.isLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (provider.error != null) {
//                     return Center(child: Text("Error: ${provider.error}"));
//                   } else {
//                     final beautyposters = provider.beauty;

//                     return ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: beautyposters.length,
//                       itemBuilder: (context, index) {
//                         final poster = beautyposters[index];
//                         return Container(
//                           width: 120,
//                           margin: const EdgeInsets.only(right: 12),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: const Color.fromARGB(255, 247, 158, 106),
//                             boxShadow: const [BoxShadow(color: Colors.black12)],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: const BorderRadius.vertical(
//                                   top: Radius.circular(12),
//                                 ),
//                                 child: Image.network(
//                                   poster.images.isNotEmpty
//                                       ? poster.images[0]
//                                       : 'https://via.placeholder.com/120x100',
//                                   height: 100,
//                                   width: 120,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       )),
//     );
//   }

//   Widget buildSection(String title, List<String> items) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 title,
//                 style:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//               ),
//               const Text(
//                 'View all',
//                 style:
//                     TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 140,
//           child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: items.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   width: 120,
//                   margin: const EdgeInsets.only(right: 10),
//                   decoration: BoxDecoration(
//                       color: Colors.orangeAccent,
//                       borderRadius: BorderRadius.circular(12),
//                       image: const DecorationImage(
//                           image: NetworkImage(
//                               'https://s3-alpha-sig.figma.com/img/1f3a/2ea2/0e854d5fb1e4924513dfcce9ccefa3e0?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=HHgEXFEt4br9HgPFlB0zYc0rxkawN2j-ucMirhXKUSqLT9YpxRlPsDimsuFsMVhWNmS5zpGT3PKSp2f8lV8g1vx5-ujAG~n3zuM~8JQdUFOJMvnuyG6XhBoC29hcmoEVEE~3NZUW~t5nJTCWuDLa0QalSUuX2C1KlN1eTeRBOKf6edb31XpFoS7ibDZ4-FjVGXMfDGlPk3k7-OZGcUfTK7kBaHgwdJVPtn-Lz2gcRY--QnNHphtrYzt~XHu37N4gMmPadnFc8hRfJAqMW3VSWHeWAg~kgFzlsvqwZ5tQb1uBRQnqUgPHntIPKGNWSyuRnZH43PGCjnpsIHfX7RuhCg__'),
//                           fit: BoxFit.cover)),
//                 );
//               }),
//         )
//       ],
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors_in_immutables, unused_local_variable

// import 'package:company_project/providers/beauty_provider.dart';
// import 'package:company_project/providers/category_poster_provider.dart';
// import 'package:company_project/providers/chemical_provider.dart';
// import 'package:company_project/providers/clothing_provider.dart';
// import 'package:company_project/providers/ugadi_provider.dart';
// import 'package:company_project/views/presentation/pages/home/details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CategoryScreen extends StatefulWidget {
//   CategoryScreen({super.key});

//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   final List<String> categories = [
//     'Business Ads',
//     'Education',
//     'Ugadi',
//     'Beauty',
//     'Chemical'
//   ];

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() =>
//         Provider.of<ChemicalProvider>(context, listen: false).fetchChemicals());
//     Future.microtask(() =>
//         Provider.of<ClothingProvider>(context, listen: false).fetchClothing());
//     Future.microtask(() =>
//         Provider.of<BeautyProvider>(context, listen: false).fetchBeauty());
//     Future.microtask(
//         () => Provider.of<UgadiProvider>(context, listen: false).fetchUgadi());
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Get the screen size using MediaQuery
//     final MediaQueryData mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;

//     // Define responsive sizes based on screen width
//     final double paddingSize = screenWidth * 0.04; // 4% of screen width
//     final double itemWidth = screenWidth < 600 ? 120 : 150; // Increase item width on larger screens
//     final double itemHeight = screenWidth < 600 ? 100 : 120; // Increase item height on larger screens
//     final double titleFontSize = screenWidth < 600 ? 26 : 32; // Larger title font on bigger screens
//     final double sectionTitleSize = screenWidth < 600 ? 18 : 22; // Larger section titles on bigger screens

//     final chemicalProvider = Provider.of<ChemicalProvider>(context);
//     final clothingProvider = Provider.of<ClothingProvider>(context);
//     final beautyProvider = Provider.of<BeautyProvider>(context);
//     final ugadiProvider = Provider.of<UgadiProvider>(context);

//     final chemicals = chemicalProvider.chemical;
//     final clothing = clothingProvider.clothing;
//     final beauty = beautyProvider.beauty;
//     final ugady = ugadiProvider.ugadi;

//     final chemicalposters = chemicals.where(
//         (chemicals) => chemicals.categoryName.toLowerCase() == 'chemical');
//     final clothingposters = clothing
//         .where((clothing) => clothing.categoryName.toLowerCase() == 'clothing');
//     final beautyposters =
//         beauty.where((beauty) => beauty.categoryName.toLowerCase() == 'beauty');
//     final ugadiposters =
//         beauty.where((ugady) => ugady.categoryName.toLowerCase() == 'ugady');

//     return Scaffold(
//       body: SafeArea(
//           child: SingleChildScrollView(
//         padding: EdgeInsets.all(paddingSize),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Categories',
//                   style: TextStyle(
//                     fontSize: titleFontSize,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(screenWidth * 0.02),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Icon(Icons.translate),
//                     ),
//                     SizedBox(
//                       width: screenWidth * 0.03,
//                     ),
//                     CircleAvatar(
//                       backgroundColor: Colors.grey[200],
//                       child: const Icon(Icons.search),
//                     )
//                   ],
//                 )
//               ],
//             ),
//             SizedBox(
//               height: screenHeight * 0.025,
//             ),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                   children: categories.map((cat) {
//                 return Padding(
//                   padding: EdgeInsets.only(right: screenWidth * 0.02),
//                   child: Chip(
//                     label: Text(cat),
//                     backgroundColor: cat == 'Business Ads'
//                         ? const Color.fromARGB(255, 107, 22, 255)
//                         : const Color.fromARGB(255, 250, 250, 250),
//                     labelStyle: TextStyle(
//                         color:
//                             cat == 'Business Ads' ? Colors.white : Colors.grey),
//                   ),
//                 );
//               }).toList()),
//             ),
//             SizedBox(
//               height: screenHeight * 0.025,
//             ),
//             _buildSectionHeader('Ugadi Special', context, sectionTitleSize, screenWidth),
//             SizedBox(
//               height: itemHeight + 10,
//               child: Consumer<UgadiProvider>(
//                 builder: (context, provider, child) {
//                   if (provider.isLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (provider.error != null) {
//                     return Center(child: Text("Error: ${provider.error}"));
//                   } else {
//                     final ugadiposters = provider.ugadi;
//                     return ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: ugadiposters.length,
//                       itemBuilder: (context, index) {
//                         final poster = ugadiposters[index];
//                         return _buildItemCard(poster, itemWidth, itemHeight, screenWidth);
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//             _buildSectionHeader('Chemical', context, sectionTitleSize, screenWidth),
//             SizedBox(
//               height: itemHeight + 10,
//               child: Consumer<ChemicalProvider>(
//                 builder: (context, provider, child) {
//                   if (provider.isLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (provider.error != null) {
//                     return Center(child: Text("Error: ${provider.error}"));
//                   } else {
//                     final chemicalposters = provider.chemical;

//                     return ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: chemicalposters.length,
//                       itemBuilder: (context, index) {
//                         final poster = chemicalposters[index];
//                         return _buildItemCard(poster, itemWidth, itemHeight, screenWidth);
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//             _buildSectionHeader('Clothing', context, sectionTitleSize, screenWidth),
//             SizedBox(
//               height: itemHeight + 10,
//               child: Consumer<ClothingProvider>(
//                 builder: (context, provider, child) {
//                   if (provider.isLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (provider.error != null) {
//                     return Center(child: Text("Error: ${provider.error}"));
//                   } else {
//                     final clothingposters = provider.clothing;

//                     return ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: clothingposters.length,
//                       itemBuilder: (context, index) {
//                         final poster = clothingposters[index];
//                         return _buildItemCard(poster, itemWidth, itemHeight, screenWidth);
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//             _buildSectionHeader('Beauty', context, sectionTitleSize, screenWidth),
//             SizedBox(
//               height: itemHeight + 10,
//               child: Consumer<BeautyProvider>(
//                 builder: (context, provider, child) {
//                   if (provider.isLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (provider.error != null) {
//                     return Center(child: Text("Error: ${provider.error}"));
//                   } else {
//                     final beautyposters = provider.beauty;

//                     return ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: beautyposters.length,
//                       itemBuilder: (context, index) {
//                         final poster = beautyposters[index];
//                         return _buildItemCard(poster, itemWidth, itemHeight, screenWidth);
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       )),
//     );
//   }

//   // Helper method to build a consistent section header with responsive spacing
//   Widget _buildSectionHeader(String title, BuildContext context, double fontSize, double screenWidth) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
//         ),
//         Row(
//           children: [
//             TextButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(category: 'ugadi')));
//               },
//               child: const Text(
//                 'View All',
//                 style: TextStyle(color: Colors.black),
//               ),
//             ),
//             const Icon(Icons.arrow_forward_ios,size: 18,)
//           ],
//         ),
//       ],
//     );
//   }

//   // Helper method to build item cards with responsive dimensions
//   Widget _buildItemCard(dynamic poster, double width, double height, double screenWidth) {
//     return Container(
//       width: width,
//       margin: EdgeInsets.only(right: screenWidth * 0.03),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: const Color.fromARGB(255, 247, 158, 106),
//         boxShadow: const [BoxShadow(color: Colors.black12)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(
//               top: Radius.circular(12),
//             ),
//             child: Image.network(
//               poster.images.isNotEmpty
//                   ? poster.images[0]
//                   : 'https://via.placeholder.com/120x100',
//               height: height,
//               width: width,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:company_project/providers/category_providerr.dart';
// import 'package:company_project/views/presentation/pages/home/details_screen.dart';
// import 'package:company_project/views/presentation/pages/home/poster/poster_maker_screen.dart';
// import 'package:company_project/views/presentation/pages/home/search_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({super.key});

//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   final List<String> categories = [
//     'Business Ads',
//     'Education',
//     'Ugadi',
//     'Beauty',
//     'Chemical',
//     'Clothing'
//   ];

//   // Categories to display in the screen sections
//   final List<String> displayCategories = [
//     'ugadi',
//     'chemical',
//     'clothing',
//     'beauty'
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Fetch all categories data at once
//     Future.microtask(() =>
//         Provider.of<CategoryProviderr>(context, listen: false)
//             .fetchMultipleCategories(displayCategories));
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Get the screen size using MediaQuery
//     final MediaQueryData mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;

//     // Define responsive sizes based on screen width
//     final double paddingSize = screenWidth * 0.04; // 4% of screen width
//     final double itemWidth =
//         screenWidth < 600 ? 120 : 150; // Increase item width on larger screens
//     final double itemHeight =
//         screenWidth < 600 ? 100 : 120; // Increase item height on larger screens
//     final double titleFontSize =
//         screenWidth < 600 ? 26 : 32; // Larger title font on bigger screens
//     final double sectionTitleSize =
//         screenWidth < 600 ? 18 : 22; // Larger section titles on bigger screens

//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(paddingSize),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header with title and action buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Categories',
//                     style: TextStyle(
//                       fontSize: titleFontSize,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           showModalBottomSheet(
//                             context: context,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.vertical(
//                                   top: Radius.circular(20)),
//                             ),
//                             builder: (BuildContext context) {
//                               return Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 20),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     ListTile(
//                                       title: const Text('Telugu'),
//                                       onTap: () {
//                                         Navigator.pop(context);
//                                         // TODO: Handle Telugu language change
//                                       },
//                                     ),
//                                     ListTile(
//                                       title: const Text('English'),
//                                       onTap: () {
//                                         Navigator.pop(context);
//                                         // TODO: Handle English language change
//                                       },
//                                     ),
//                                     ListTile(
//                                       title: const Text('Hindi'),
//                                       onTap: () {
//                                         Navigator.pop(context);
//                                         // TODO: Handle Hindi language change
//                                       },
//                                     ),
//                                     ListTile(
//                                       title: const Text('Tamil'),
//                                       onTap: () {
//                                         Navigator.pop(context);
//                                         // TODO: Handle Tamil language change
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                         child: Container(
//                           padding: EdgeInsets.all(screenWidth * 0.02),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: const Icon(Icons.translate),
//                         ),
//                       ),
//                       SizedBox(width: screenWidth * 0.03),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => SearchScreen()));
//                         },
//                         child: CircleAvatar(
//                           backgroundColor: Colors.grey[200],
//                           child: const Icon(Icons.search),
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//               SizedBox(height: screenHeight * 0.025),

//               // Category chips
//               // SingleChildScrollView(
//               //   scrollDirection: Axis.horizontal,
//               //   child: Row(
//               //     children: categories.map((cat) {
//               //       return Padding(
//               //         padding: EdgeInsets.only(right: screenWidth * 0.02),
//               //         child: Chip(
//               //           label: Text(cat),
//               //           backgroundColor: cat == 'Business Ads'
//               //               ? const Color.fromARGB(255, 107, 22, 255)
//               //               : const Color.fromARGB(255, 250, 250, 250),
//               //           labelStyle: TextStyle(
//               //               color: cat == 'Business Ads'
//               //                   ? Colors.white
//               //                   : Colors.grey),
//               //         ),
//               //       );
//               //     }).toList(),
//               //   ),
//               // ),
//               SizedBox(height: screenHeight * 0.011),

//               // Category sections - dynamically created from displayCategories list
//               for (final category in displayCategories)
//                 Column(
//                   children: [
//                     _buildSectionHeader(_capitalizeFirstLetter(category),
//                         context, sectionTitleSize, screenWidth, category),
//                     SizedBox(
//                       height: itemHeight + 10,
//                       child: _buildCategoryItemsList(context, category,
//                           itemWidth, itemHeight, screenWidth),
//                     ),
//                     SizedBox(height: screenHeight * 0.02),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper method to build the category items list
//   Widget _buildCategoryItemsList(BuildContext context, String category,
//       double itemWidth, double itemHeight, double screenWidth) {
//     return Consumer<CategoryProviderr>(
//       builder: (context, provider, child) {
//         if (provider.isLoadingCategory(category)) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (provider.getErrorForCategory(category) != null) {
//           return Center(
//               child: Text("Error: ${provider.getErrorForCategory(category)}"));
//         } else {
//           final items = provider.getItemsByCategory(category);
//           return ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: items.length,
//             itemBuilder: (context, index) {
//               final item = items[index];
//               return _buildItemCard(item, itemWidth, itemHeight, screenWidth);
//             },
//           );
//         }
//       },
//     );
//   }

//   // Helper method to build a consistent section header with responsive spacing
//   Widget _buildSectionHeader(String title, BuildContext context,
//       double fontSize, double screenWidth, String category) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
//         ),
//         Row(
//           children: [
//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             DetailsScreen(category: category)));
//               },
//               child: const Text(
//                 'View All',
//                 style: TextStyle(color: Colors.black),
//               ),
//             ),
//             const Icon(Icons.arrow_forward_ios, size: 18)
//           ],
//         ),
//       ],
//     );
//   }

//   // Helper method to build item cards with responsive dimensions
//   Widget _buildItemCard(
//       dynamic item, double width, double height, double screenWidth) {
//     return Container(
//       width: width,
//       margin: EdgeInsets.only(right: screenWidth * 0.03),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: const Color.fromARGB(255, 247, 158, 106),
//         boxShadow: const [BoxShadow(color: Colors.black12)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(
//               top: Radius.circular(12),
//             ),
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => PosterMakerApp(
//                       poster: item,
//                       isCustom: false,
//                     ),
//                   ),
//                 );
//               },
//               child: Image.network(
//                 item.images.isNotEmpty
//                     ? item.images[0]
//                     : 'https://via.placeholder.com/120x100',
//                 height: height,
//                 width: width,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper method to capitalize first letter of a string
//   String _capitalizeFirstLetter(String text) {
//     if (text.isEmpty) return '';
//     return text[0].toUpperCase() + text.substring(1);
//   }
// }

import 'package:company_project/models/category_modell.dart';
import 'package:company_project/providers/poster_provider.dart'; // Added import for PosterProvider
import 'package:company_project/views/presentation/pages/home/details_screen.dart';
import 'package:company_project/views/presentation/pages/home/poster/poster_maker_screen.dart';
import 'package:company_project/views/presentation/pages/home/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<String> categories = [
    'Business Ads',
    'Education',
    'Ugadi',
    'Beauty',
    'Chemical',
    'Clothing'
  ];

  @override
  void initState() {
    super.initState();
    // Fetch all posters data at once instead of by category
    Future.microtask(() =>
        Provider.of<PosterProvider>(context, listen: false).fetchPosters());
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size using MediaQuery
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    // Define responsive sizes based on screen width
    final double paddingSize = screenWidth * 0.04; // 4% of screen width
    final double itemWidth =
        screenWidth < 600 ? 120 : 150; // Increase item width on larger screens
    final double itemHeight =
        screenWidth < 600 ? 100 : 120; // Increase item height on larger screens
    final double titleFontSize =
        screenWidth < 600 ? 26 : 32; // Larger title font on bigger screens
    final double sectionTitleSize =
        screenWidth < 600 ? 18 : 22; // Larger section titles on bigger screens

    return Scaffold(
      body: SafeArea(
        child: Consumer<PosterProvider>(
          builder: (context, posterProvider, child) {
            // Check if data is loading
            if (posterProvider.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            // Check if there was an error
            if (posterProvider.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${posterProvider.error}'),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<PosterProvider>(context, listen: false)
                            .fetchPosters();
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            // Extract unique categories from posters
            final List<String> uniqueCategories =
                _extractUniqueCategories(posterProvider.posters);

            // If no categories found
            if (uniqueCategories.isEmpty) {
              return Center(
                child: Text('No categories available'),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(paddingSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with title and action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          title: const Text('Telugu'),
                                          onTap: () {
                                            Navigator.pop(context);
                                            // TODO: Handle Telugu language change
                                          },
                                        ),
                                        ListTile(
                                          title: const Text('English'),
                                          onTap: () {
                                            Navigator.pop(context);
                                            // TODO: Handle English language change
                                          },
                                        ),
                                        ListTile(
                                          title: const Text('Hindi'),
                                          onTap: () {
                                            Navigator.pop(context);
                                            // TODO: Handle Hindi language change
                                          },
                                        ),
                                        ListTile(
                                          title: const Text('Tamil'),
                                          onTap: () {
                                            Navigator.pop(context);
                                            // TODO: Handle Tamil language change
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.translate),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SearchScreen()));
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: const Icon(Icons.search),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.025),

                  SizedBox(height: screenHeight * 0.011),

                  // Category sections - dynamically created from actual available categories
                  for (final category in uniqueCategories)
                    Column(
                      children: [
                        _buildSectionHeader(
                          _capitalizeFirstLetter(category),
                          context,
                          sectionTitleSize,
                          screenWidth,
                          category,
                        ),
                        SizedBox(
                          height: itemHeight + 10,
                          child: _buildCategoryItemsList(
                            context,
                            category,
                            itemWidth,
                            itemHeight,
                            screenWidth,
                            posterProvider.posters,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Extract unique categories from the posters list
  List<String> _extractUniqueCategories(List<dynamic> posters) {
    final Set<String> categories = {};

    for (var poster in posters) {
      if (poster is CategoryModel && poster.categoryName.isNotEmpty) {
        categories.add(poster.categoryName);
      }
    }

    return categories.toList();
  }

  // Get posters for a specific category
  List<CategoryModel> _getPostersByCategory(
      String category, List<dynamic> allPosters) {
    return allPosters
        .where((poster) {
          return poster is CategoryModel &&
              poster.categoryName.toLowerCase() == category.toLowerCase();
        })
        .cast<CategoryModel>()
        .toList();
  }

  // Helper method to build the category items list
  Widget _buildCategoryItemsList(
    BuildContext context,
    String category,
    double itemWidth,
    double itemHeight,
    double screenWidth,
    List<dynamic> allPosters,
  ) {
    final List<CategoryModel> categoryPosters =
        _getPostersByCategory(category, allPosters);
    print('meeeeeeeeeeeeeeeeeeeeeeeee${categoryPosters[0].images[0]}');
    if (categoryPosters.isEmpty) {
      return Center(child: Text("No items available in this category"));
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categoryPosters.length,
      itemBuilder: (context, index) {
        final item = categoryPosters[index];
        return _buildItemCard(item, itemWidth, itemHeight, screenWidth);
      },
    );
  }

  // Shimmer loading effect for category items
  Widget _buildShimmerLoading(
      double itemWidth, double itemHeight, double screenWidth) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Show 5 shimmer items
        itemBuilder: (context, index) {
          return Container(
            width: itemWidth,
            height: itemHeight,
            margin: EdgeInsets.only(right: screenWidth * 0.03),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ),
    );
  }

  // Helper method to build a consistent section header with responsive spacing
  Widget _buildSectionHeader(String title, BuildContext context,
      double fontSize, double screenWidth, String category) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(category: category)));
              },
              child: const Text(
                'View All',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18)
          ],
        ),
      ],
    );
  }

  // Helper method to build item cards with responsive dimensions
  Widget _buildItemCard(
      CategoryModel item, double width, double height, double screenWidth) {
    return Container(
      width: width,
      margin: EdgeInsets.only(right: screenWidth * 0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(255, 247, 158, 106),
        boxShadow: const [BoxShadow(color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PosterMakerApp(
                      poster: item,
                      isCustom: false,
                    ),
                  ),
                );
              },
              child: Image.network(
                "https://posterbnaobackend.onrender.com/${item.images[0]}",
                //  "https://posterbnaobackend.onrender.com/uploads/${['images'][0]}",

                // item.images.isNotEmpty
                //     ? item.images[0].toString()
                //     : 'https://via.placeholder.com/120x100',

                height: height,
                width: width,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: height,
                    width: width,
                    color: Colors.grey[300],
                    child: Icon(Icons.image_not_supported,
                        color: Colors.grey[600]),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: height,
                    width: width,
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to capitalize first letter of a string
  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }
}
