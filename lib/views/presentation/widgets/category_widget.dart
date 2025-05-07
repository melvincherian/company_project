import 'package:flutter/material.dart';
import 'package:company_project/models/category_modell.dart';

class CategoryGridView extends StatelessWidget {
  final List<CategoryModel> categoryList;

  const CategoryGridView({Key? key, required this.categoryList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: categoryList.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 items per row
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 3 / 4, // Adjust for card shape
      ),
      itemBuilder: (context, index) {
        final item = categoryList[index];
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.image, size: 60, color: Colors.grey), // Placeholder for image
                const SizedBox(height: 8),
                Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text("Category: ${item.categoryName}"),
                const SizedBox(height: 4),
                Text("Price: ₹${item.price}", style: const TextStyle(color: Colors.green)),
              ],
            ),
          ),
        );
      },
    );
  }
}
