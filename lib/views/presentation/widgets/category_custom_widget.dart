import 'package:company_project/models/category_modell.dart';
import 'package:flutter/material.dart';
import 'package:company_project/models/poster_model.dart';

class PosterGroupedListView extends StatelessWidget {
  final List<CategoryModel> posters;
   
  const PosterGroupedListView({
    Key? key,
    required this.posters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Group posters by categoryName
    final Map<String, List<CategoryModel>> groupedByCategory = {};

    for (var poster in posters) {
      final category = poster.categoryName;
      if (groupedByCategory.containsKey(category)) {
        groupedByCategory[category]!.add(poster);
      } else {
        groupedByCategory[category] = [poster];
      }
    }

    return ListView(
      children: groupedByCategory.entries.map((entry) {
        final categoryName = entry.key;
        final postersInCategory = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(
                categoryName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // Horizontal ListView of posters
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: postersInCategory.length,
                itemBuilder: (context, index) {
                  final poster = postersInCategory[index];
                  return Container(
                    width: 140,
                    margin: const EdgeInsets.only(left: 16, right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.grey.withOpacity(0.2),
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (poster.images != null && poster.images.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.network(
                              poster.images[0],
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            poster.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
