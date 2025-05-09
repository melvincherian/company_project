import 'package:company_project/models/invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:company_project/providers/poster_provider.dart';
import 'package:company_project/providers/invoice_provider.dart';

class PosterGridView extends StatelessWidget {
  const PosterGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final posterProvider = Provider.of<PosterProvider>(context);
    final invoiceProvider = Provider.of<InvoiceProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Posters"),
        actions: [
          Consumer<InvoiceProvider>(
            builder: (context, provider, child) {
              return Badge(
                label: Text('${provider.itemCount}'),
                isLabelVisible: provider.itemCount > 0,
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: provider.itemCount > 0 
                    ? () => Navigator.pop(context)
                    : null,
                ),
              );
            },
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (posterProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (posterProvider.error != null) {
            return Center(child: Text(posterProvider.error!));
          }

          final posters = posterProvider.posters;

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: posters.length,
            itemBuilder: (context, index) {
              final poster = posters[index];
              final imageUrl = poster.images.isNotEmpty ? poster.images.first : null;

              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: InkWell(
                  onTap: () {
                    // Add poster to invoice
                    final invoiceItem = InvoiceItem.fromPoster(poster);
                    invoiceProvider.addItem(invoiceItem);
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Added ${poster.name} to invoice'),
                        duration: const Duration(seconds: 1),
                        action: SnackBarAction(
                          label: 'VIEW',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: imageUrl != null
                                ? Image.network(
                                    imageUrl,
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.broken_image, size: 100),
                                  )
                                : const SizedBox(
                                    height: 100,
                                    child: Center(child: Icon(Icons.image_not_supported, size: 40)),
                                  ),
                          ),
                          Consumer<InvoiceProvider>(
                            builder: (context, provider, child) {
                              // Convert IDs to strings for comparison if needed
                              final isInCart = provider.items.any((item) => 
                                item.id.toString() == poster.id.toString());
                              
                              if (isInCart) {
                                return Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          poster.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Category: ${poster.categoryName}",
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "₹${poster.price}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Consumer<InvoiceProvider>(
                              builder: (context, provider, child) {
                                // Convert IDs to strings for comparison if needed
                                final isInCart = provider.items.any((item) => 
                                  item.id.toString() == poster.id.toString());
                                  
                                return IconButton(
                                  icon: Icon(
                                    isInCart ? Icons.check_circle : Icons.add_circle_outline,
                                    color: isInCart ? Colors.green : Colors.blue,
                                  ),
                                  onPressed: () {
                                    final invoiceItem = InvoiceItem.fromPoster(poster);
                                    provider.addItem(invoiceItem);
                                  },
                                );
                              },
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
      floatingActionButton: Consumer<InvoiceProvider>(
        builder: (context, provider, child) {
          return provider.itemCount > 0
              ? FloatingActionButton.extended(
                  onPressed: () => Navigator.pop(context),
                  backgroundColor: Colors.green,
                  icon: const Icon(Icons.check),
                  label: const Text('Done'),
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}