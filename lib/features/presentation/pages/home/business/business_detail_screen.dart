import 'package:company_project/features/presentation/pages/home/business/add_business.dart';
import 'package:flutter/material.dart';

class BusinessDetailScreen extends StatelessWidget {
  const BusinessDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Bakery & Clothing Cards',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 16),

        
              Center(
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                    boxShadow:const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network('https://s3-alpha-sig.figma.com/img/4a7b/1cfa/0f786a0abe78d4b2afdba27b4863f29a?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=sf0T-1o1kfke-z9y738n5-VQ6ipQoapjOAGQd36kb~rMEfa51o-R6O7K4VKqFScAEuN0qpZer7XCj68DoV3PstVHrIr-K5--aorSK0LIJYKA9X-xUQ5CbN-rGizqnaLxMl9UsvkkfKkkFmD5~H4FraNGI5jToPoN~PX77~cScAzEk20OSdYePSSNqzqxJuW3YnFcr6NiCOUW7XO4jmNpy0qlqrC6k~8-OIwd9WmdGGxq46ao99HcvjE~5MSAIGu7YmykHX4Xbmjw1tC01Oc-SW7rFnRLUj82rKHnow3ruJOSTYHlEA~WVmB7cWNag6NBpHV1TVAy1F9EYQWqv9jpfA__') ,// Replace with your image
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹250',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            '₹350',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough),
                          ),
                          Text(
                            '40% Off',
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

     
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xffe8f5ff),
                  borderRadius: BorderRadius.circular(16),
                ),
                child:const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:  [
                    _TimerBox(title: "Hours", value: "05"),
                    _TimerBox(title: "Min", value: "37"),
                    _TimerBox(title: "Sec", value: "45"),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'What will i get?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
                'Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s...',
                style: TextStyle(color: Colors.black87),
              ),
              const SizedBox(height: 30),

          
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                      },
                      icon: const Icon(Icons.download,color: Colors.black,),
                      label: const Text('Free Trail',style: TextStyle(color: Colors.black),),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddBusiness()));

                      },
                      icon: const Icon(Icons.shopping_cart_outlined),
                      label: const Text('Buy Now'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TimerBox extends StatelessWidget {
  final String title;
  final String value;

  const _TimerBox({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(color: Colors.black54),
        ),
      ],
    );
  }
}
