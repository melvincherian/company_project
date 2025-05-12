import 'package:company_project/models/poster_template_model.dart';
import 'package:company_project/views/presentation/pages/home/details_screen.dart';
import 'package:flutter/material.dart';

class PosterGroupedListView extends StatelessWidget {
  final Map<String, List<Poster>> groupedPosters;

  const PosterGroupedListView({Key? key, required this.groupedPosters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: groupedPosters.entries.map((entry) {
        final categoryName = entry.key;
        final posters = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row with Category Title and "View All"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  categoryName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(category: categoryName.toLowerCase() + 'poster'),
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      Text('View All', style: TextStyle(color: Colors.black)),
                      Icon(Icons.arrow_forward_ios, size: 19, color: Colors.black),
                    ],
                  ),
                ),
              ],
            ),

            // Poster List
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: posters.length,
                itemBuilder: (context, index) {
                  final poster = posters[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        poster.imageUrl,
                        width: 150,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        );
      }).toList(),
    );
  }
}
