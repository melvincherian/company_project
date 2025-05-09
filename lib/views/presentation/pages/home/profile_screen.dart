// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:company_project/models/business_poster_model.dart';
import 'package:company_project/views/presentation/pages/home/business/business_detail_screen.dart';
import 'package:company_project/views/presentation/widgets/business_category_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/business_poster_provider.dart';
import '../../../../../providers/business_category_provider.dart';

class VirtualBusinessScreen extends StatefulWidget {
  const VirtualBusinessScreen({super.key});

  @override
  State<VirtualBusinessScreen> createState() => _VirtualBusinessScreenState();
}

class _VirtualBusinessScreenState extends State<VirtualBusinessScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<BusinessPosterProvider>(context, listen: false)
          .fetchPosters();
      Provider.of<BusinessCategoryProvider>(context, listen: false)
          .fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final posterProvider = Provider.of<BusinessPosterProvider>(context);
    final categoryProvider = Provider.of<BusinessCategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual Business Card',
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: posterProvider.isLoading || categoryProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : posterProvider.error != null
              ? Center(child: Text('Poster Error: ${posterProvider.error}'))
              : categoryProvider.errorMessage != null
                  ? Center(
                      child: Text(
                          'Category Error: ${categoryProvider.errorMessage}'))
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCategoryCircleAvatars(categoryProvider),
                          _sectionTitle("Bakery & Clothing Cards", context),
                          _cardList(posterProvider.posters),
                          _sectionTitle("Trending Cards", context),
                          _cardList(posterProvider.posters),
                        ],
                      ),
                    ),
    );
  }

  Widget _buildCategoryCircleAvatars(BusinessCategoryProvider provider) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: provider.categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemBuilder: (context, index) {
          final category = provider.categories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    final categoryName = category.categoryName ?? '';
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CategoryPostersScreen(categoryName: categoryName),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: category.image != null
                        ? NetworkImage(category.image!)
                        : null,
                    backgroundColor: Colors.grey[300],
                    child: category.image == null
                        ? const Icon(Icons.image_not_supported)
                        : null,
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 70,
                  child: Text(
                    category.categoryName ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _sectionTitle(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (_) => const BakeryCards()));
            },
            child: const Row(
              children: [
                Text('View All', style: TextStyle(color: Colors.black)),
                Icon(Icons.arrow_forward_ios, size: 19),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardList(List<BusinessPosterModel> posters) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: posters.length,
        padding: const EdgeInsets.only(left: 12),
        itemBuilder: (context, index) {
          return _businessCard(context, posters[index]);
        },
      ),
    );
  }

  Widget _businessCard(BuildContext context, BusinessPosterModel poster) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BusinessDetailScreen(poster: poster)));
            },
            child: poster.images.isNotEmpty
                ? Image.network(poster.images.first,
                    height: 125, width: 300, fit: BoxFit.cover)
                : const Placeholder(fallbackHeight: 125),
          ),
          const SizedBox(height: 8),
          Text(
            poster.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          Text(poster.categoryName,
              style: const TextStyle(color: Colors.blue, fontSize: 10)),
          Text(poster.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Text(poster.createdAt.toString().split('T').first,
              style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('₹${poster.price}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('₹${poster.offerPrice}',
                  style: const TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  )),
              Text(
                  '${((1 - (poster.price / poster.offerPrice)) * 100).round()}% Off',
                  style: const TextStyle(color: Colors.green)),
            ],
          ),
        ],
      ),
    );
  }
}
