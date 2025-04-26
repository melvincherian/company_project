import 'package:company_project/views/presentation/pages/home/business/business_detail_screen.dart';
import 'package:flutter/material.dart';

class BakeryCards extends StatelessWidget {
  const BakeryCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text(
          'Bakery & Clothing Cards',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Chips
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  FilterChipWidget(label: "Business Ads", selected: true),
                  FilterChipWidget(label: "Education"),
                  FilterChipWidget(label: "Ugadi"),
                  FilterChipWidget(label: "Beauty"),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Cards Grid
            Expanded(
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.62,
                ),
                itemBuilder: (context, index) {
                  return const BusinessCard();
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
  const BusinessCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    

          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const BusinessDetailScreen()));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://s3-alpha-sig.figma.com/img/4a7b/1cfa/0f786a0abe78d4b2afdba27b4863f29a?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=sf0T-1o1kfke-z9y738n5-VQ6ipQoapjOAGQd36kb~rMEfa51o-R6O7K4VKqFScAEuN0qpZer7XCj68DoV3PstVHrIr-K5--aorSK0LIJYKA9X-xUQ5CbN-rGizqnaLxMl9UsvkkfKkkFmD5~H4FraNGI5jToPoN~PX77~cScAzEk20OSdYePSSNqzqxJuW3YnFcr6NiCOUW7XO4jmNpy0qlqrC6k~8-OIwd9WmdGGxq46ao99HcvjE~5MSAIGu7YmykHX4Xbmjw1tC01Oc-SW7rFnRLUj82rKHnow3ruJOSTYHlEA~WVmB7cWNag6NBpHV1TVAy1F9EYQWqv9jpfA__',
                height: 240,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Spacer(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("₹250", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("₹350",
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough, fontSize: 12)),
              Text("40% Off",
                  style: TextStyle(color: Colors.green, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }
}
