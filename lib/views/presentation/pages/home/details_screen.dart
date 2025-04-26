import 'package:company_project/views/presentation/pages/home/poster/create_poster_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:company_project/providers/category_poster_provider.dart';

// class DetailsScreen extends StatefulWidget {
//   final String category;
  
//   const DetailsScreen({super.key, required this.category});

//   @override
//   State<DetailsScreen> createState() => _DetailsScreenState();
// }

// class _DetailsScreenState extends State<DetailsScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch the posters for this specific category when screen loads
//     Future.microtask(() {
//       final provider = Provider.of<CategoryPosterProvider>(context, listen: false);
//       provider.fetchPostersByCategory(widget.category);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Icon(Icons.arrow_back_ios, size: 26),
//                   ),
//                   const SizedBox(width: 16),
//                   Text(
//                     widget.category,
//                     style: const TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
              
//               Expanded(
//                 child: Consumer<CategoryPosterProvider>(
//                   builder: (context, provider, child) {
//                     if (provider.isLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
                    
//                     if (provider.error.isNotEmpty) {
//                       return Center(
//                         child: Text(
//                           'Error: ${provider.error}',
//                           style: const TextStyle(color: Colors.red),
//                         ),
//                       );
//                     }
                    
//                     if (provider.categoryPosters.isEmpty) {
//                       return const Center(
//                         child: Text('No posters available for this category'),
//                       );
//                     }
                    
//                     return GridView.builder(
//                       itemCount: provider.categoryPosters.length,
//                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 16,
//                         mainAxisSpacing: 16,
//                         childAspectRatio: 0.8,
//                       ),
//                       itemBuilder: (context, index) {
//                         final poster = provider.categoryPosters[index];
//                         return Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: const Color.fromARGB(255, 169, 137, 126),
//                             boxShadow: const [
//                               BoxShadow(color: Colors.black12, blurRadius: 4)
//                             ],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                 child: ClipRRect(
//                                   borderRadius: const BorderRadius.vertical(
//                                     top: Radius.circular(20),
//                                   ),
//                                   child: Image.network(
//                                     poster.images[0],
//                                     fit: BoxFit.cover,
//                                     width: double.infinity,
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return Container(
//                                         color: Colors.grey[300],
//                                         child: const Icon(Icons.image_not_supported),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(12.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       poster.price == 0 ? 'Free' : '₹ ${poster.price}',
//                                       style: const TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const Icon(
//                                       Icons.favorite_border,
//                                       size: 20,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }










class DetailsScreen extends StatefulWidget {
  final String category;
  
  const DetailsScreen({super.key, required this.category});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the posters for this specific category when screen loads
    Future.microtask(() {
      final provider = Provider.of<CategoryPosterProvider>(context, listen: false);
      provider.fetchPostersByCategory(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios, size: 26),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    widget.category,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              Expanded(
                child: Consumer<CategoryPosterProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    
                    if (provider.error.isNotEmpty) {
                      return Center(
                        child: Text(
                          'Error: ${provider.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    
                    if (provider.categoryPosters.isEmpty) {
                      return const Center(
                        child: Text('No posters available for this category'),
                      );
                    }
                    
                    return GridView.builder(
                      itemCount: provider.categoryPosters.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        final poster = provider.categoryPosters[index];
                        return GestureDetector(
                          // Add navigation to PosterTemplate when a poster is tapped
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PosterTemplate(
                                  poster: poster, // Pass the selected poster
                                  isCustom: false,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 169, 137, 126),
                              boxShadow: const [
                                BoxShadow(color: Colors.black12, blurRadius: 4)
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                    child: Image.network(
                                      poster.images[0],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[300],
                                          child: const Icon(Icons.image_not_supported),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        poster.price == 0 ? 'Free' : '₹ ${poster.price}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.favorite_border,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}