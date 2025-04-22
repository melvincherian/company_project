import 'package:company_project/features/presentation/pages/home/business/bakery_clothing_screen.dart';
import 'package:flutter/material.dart';

class VirtualBusinessScreen extends StatelessWidget {
  const VirtualBusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual Business Card',style: TextStyle(fontWeight: FontWeight.bold),),
        leading:  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (context, index) {
                  final titles = ['Professional', 'Single Page', 'Multi Page', 'Micro'];
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 35),
                        child: Column(
                          children: [
                          
                            CircleAvatar(
                              
                              radius: 30,
                              backgroundImage: NetworkImage('https://s3-alpha-sig.figma.com/img/6587/0f9b/0822fcf05ccb90322b60619df1b47c86?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=IU7XlnJBOJlPwd~t-kfV2mCmP5ceWg7xP0i8BROTLiiDUWEKcMOFx5Kq0tDTFqeyHYUiVIGWfQ7n~O4ZFQ~Mqdp8rF9eN591BlmmLf0s3gPM-C7BjfLSQB2OOqxMKgiejKrS2n7QHjwzxZbVgTHp3FmbxPoMQIAzgtKM8yNznLpK49FKar55gByyhURWpEZwZ9P4Bj~-mFyBEbogZHJyk~0tWMi3gyL7K61bvyAQ9~6JZjgtmSM9vlZ-9~UysDKRI5fwigFnmIQ2hjCIGg4fuMvoMjXWRYvXGghIRY8FJCSUWILt4DVKWOun2K2Fw1aZBypK1Z6Dp-UHYKg4EKqMFA__'),
                            ),
                            const SizedBox(height: 4),
                            Text(titles[index], style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            _sectionTitle("Bakery & Clothing Cards",context),
            _cardList(),

            _sectionTitle("Trending Cards",context),
            _cardList(),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title,context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BakeryCards()));
            },
            child: const Text('View All', style: TextStyle(color: Colors.black))),
        ],
      ),
    );
  }

  Widget _cardList() {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        padding: const EdgeInsets.only(left: 12),
        itemBuilder: (context, index) {
          return _businessCard();
        },
      ),
    );
  }

  Widget _businessCard() {
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
          Image.network('https://s3-alpha-sig.figma.com/img/4a7b/1cfa/0f786a0abe78d4b2afdba27b4863f29a?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=sf0T-1o1kfke-z9y738n5-VQ6ipQoapjOAGQd36kb~rMEfa51o-R6O7K4VKqFScAEuN0qpZer7XCj68DoV3PstVHrIr-K5--aorSK0LIJYKA9X-xUQ5CbN-rGizqnaLxMl9UsvkkfKkkFmD5~H4FraNGI5jToPoN~PX77~cScAzEk20OSdYePSSNqzqxJuW3YnFcr6NiCOUW7XO4jmNpy0qlqrC6k~8-OIwd9WmdGGxq46ao99HcvjE~5MSAIGu7YmykHX4Xbmjw1tC01Oc-SW7rFnRLUj82rKHnow3ruJOSTYHlEA~WVmB7cWNag6NBpHV1TVAy1F9EYQWqv9jpfA__',fit: BoxFit.cover,height: 125,width: 300,),
          const SizedBox(height: 8),
          const Text(
            'BUSINESS CONFERENCE',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const Text('SPEAKER', style: TextStyle(color: Colors.blue, fontSize: 10)),
          const Text('Matthew Smith', style: TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          const Text('01.14.20XX', style: TextStyle(fontSize: 12)),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('₹250', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('₹350',
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  )),
              Text('40% Off', style: TextStyle(color: Colors.green)),
            ],
          ),
        ],
      ),
    );
  }
}
