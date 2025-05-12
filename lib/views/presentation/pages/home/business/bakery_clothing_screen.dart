import 'package:company_project/views/presentation/pages/home/business/business_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../models/business_poster_model.dart';
import '../../../../../providers/business_poster_provider.dart';

class AllBusinessCardsScreen extends StatelessWidget {
  final String title;
  
  const AllBusinessCardsScreen({
    super.key, 
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final posterProvider = Provider.of<BusinessPosterProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: posterProvider.isLoading 
          ? const Center(child: CircularProgressIndicator())
          : posterProvider.error != null
              ? Center(child: Text('Error: ${posterProvider.error}'))
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Filter Chips
                      // SizedBox(
                      //   height: 40,
                      //   child: ListView(
                      //     scrollDirection: Axis.horizontal,
                      //     children: const [
                      //       FilterChipWidget(label: "All", selected: true),
                      //       FilterChipWidget(label: "Business Ads"),
                      //       FilterChipWidget(label: "Education"),
                      //       FilterChipWidget(label: "Bakery"),
                      //       FilterChipWidget(label: "Clothing"),
                      //       FilterChipWidget(label: "Beauty"),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(height: 12),
                      // Cards Grid
                      Expanded(
                        child: GridView.builder(
                          itemCount: posterProvider.posters.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.62,
                          ),
                          itemBuilder: (context, index) {
                            return BusinessCard(poster: posterProvider.posters[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}

class FilterChipWidget extends StatelessWidget {
  final String label;
  final bool selected;

  const FilterChipWidget({
    super.key,
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(label),
        backgroundColor: selected ? Colors.deepPurple : Colors.grey.shade200,
        labelStyle: TextStyle(
          color: selected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class BusinessCard extends StatelessWidget {
  final BusinessPosterModel poster;
  
  const BusinessCard({
    super.key,
    required this.poster,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(2, 4),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BusinessDetailScreen(poster: poster),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: poster.images.isNotEmpty
                ? Image.network(
                    poster.images.first,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : const Placeholder(fallbackHeight: 150),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            poster.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            poster.categoryName,
            style: const TextStyle(color: Colors.blue, fontSize: 10),
          ),
          Text(
            poster.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${poster.price}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '₹${poster.offerPrice}',
                style: const TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                  fontSize: 12,
                ),
              ),
              Text(
                '${((1 - (poster.price / poster.offerPrice)) * 100).round()}% Off',
                style: const TextStyle(color: Colors.green, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}