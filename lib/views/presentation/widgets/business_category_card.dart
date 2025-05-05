
import 'package:company_project/views/presentation/pages/home/business/business_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/business_poster_provider.dart';

class CategoryPostersScreen extends StatelessWidget {
  final String categoryName;

  const CategoryPostersScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final posterProvider = Provider.of<BusinessPosterProvider>(context);
    final filteredPosters = posterProvider.posters
        .where((poster) => poster.categoryName == categoryName)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: filteredPosters.isEmpty
          ? const Center(child: Text('No posters found for this category.'))
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredPosters.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                final poster = filteredPosters[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>  BusinessDetailScreen(poster: poster)
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        poster.images.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  poster.images.first,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Placeholder(fallbackHeight: 120),
                        const SizedBox(height: 8),
                        Text(poster.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                        Text(poster.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 11)),
                        const Spacer(),
                        Text('₹${poster.price}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Text('₹${poster.offerPrice}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                              decoration: TextDecoration.lineThrough,
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
