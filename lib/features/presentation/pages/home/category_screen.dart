import 'package:company_project/features/presentation/pages/home/details_screen.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final List<String> categories = [
    'Business Ads',
    'Education',
    'Ugadi',
    'Beauty',
    'Chemical'
  ];

  final Map<String, List<String>> sectionItems = {
    'Ugadi Special': ['Ugadi1', 'Ugadi2', 'Ugadi3'],
    'Chemical': ['Chemical1', 'Chemical2', 'Chemical3'],
    'Clothing': ['Clothing1', 'Clothing2', 'Clothing3'],
    'Beauty': ['Beauty1', 'Beauty2', 'Beauty3']
  };

  CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.translate),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: const Icon(Icons.search),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: categories.map((cat) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Chip(
                    
                    label: Text(cat),
                    backgroundColor: cat == 'Business Ads'
                        ? const Color.fromARGB(255, 107, 22, 255)
                        : const Color.fromARGB(255, 250, 250, 250),
                    labelStyle: TextStyle(
                        color: cat == 'Business Ads'
                            ? Colors.white
                            : Colors.grey),
                  ),
                );
              }).toList()),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ugadi Special',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 165,),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View All',
                      style: TextStyle(color: Colors.black),
                    )),
                    Icon(Icons.arrow_forward_ios)
              ],
            ),
            SizedBox(
              height: 110,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => Container(
                        width: 120,
                        margin: const EdgeInsets.only(right: 12),
                        
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: Image.network(
                                'https://s3-alpha-sig.figma.com/img/1f3a/2ea2/0e854d5fb1e4924513dfcce9ccefa3e0?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=HHgEXFEt4br9HgPFlB0zYc0rxkawN2j-ucMirhXKUSqLT9YpxRlPsDimsuFsMVhWNmS5zpGT3PKSp2f8lV8g1vx5-ujAG~n3zuM~8JQdUFOJMvnuyG6XhBoC29hcmoEVEE~3NZUW~t5nJTCWuDLa0QalSUuX2C1KlN1eTeRBOKf6edb31XpFoS7ibDZ4-FjVGXMfDGlPk3k7-OZGcUfTK7kBaHgwdJVPtn-Lz2gcRY--QnNHphtrYzt~XHu37N4gMmPadnFc8hRfJAqMW3VSWHeWAg~kgFzlsvqwZ5tQb1uBRQnqUgPHntIPKGNWSyuRnZH43PGCjnpsIHfX7RuhCg__',
                                height: 100,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      )),
            ),
            Row(
           
              children: [
                const Text(
                  'Chemical',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                 SizedBox(width: 199,),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View All',
                      style: TextStyle(color: Colors.black),
                    )),
                  const  Icon(Icons.arrow_forward_ios)
              ],
            ),
            SizedBox(
              height: 110,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => Container(
                        width: 120,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(255, 247, 158, 106),
                          boxShadow: const[
                            BoxShadow(color: Colors.black)
                          ]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: Image.network(
                                'https://s3-alpha-sig.figma.com/img/9cf6/9546/ebfe8be7faa0bcece189903d1e14b4d7?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=YGwJR0j8WDu-tfa~nvJd90b9coqrtqXsWyqXePok5XUXvpyN5lVWahW33A5oomX6R05rIsJnDgFouHZMy3-~iGFbdXhbaupOkOAtNM2p3O6o9iBJDeil8qfb519bIUiu-7dZBHmy~y~UUOf-eymwdj9ikjqOY~XTlycxvxcZJE3rwdcZg6pAptH6Kw~nVTymvMpIq~eLrcrq2vLxVdWVhw7jNLHAZkpfIe0jCALLAgmQ5nyZNvMqRwmnAcpSKxwjudRM0ZsDqcCUukmupdFSNCB8fbpurIjoTK7v9KR6S0WCkv5MpzD0sJiXfsXGVLHK80RHO69RMXtGZAPhRsRNkQ__',
                                height: 100,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      )),
            ),
            Row(
      
              children: [
                const Text(
                  'Clothing',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
               const  SizedBox(width: 210,),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View All',
                      style: TextStyle(color: Colors.black),
                    )),
                 const   Icon(Icons.arrow_forward_ios)
              ],
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => Container(
                        width: 120,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(255, 247, 158, 106),
                          boxShadow:const [
                            BoxShadow(color: Colors.black)
                          ]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DetailsScreen()));
                                },
                                child: Image.network(
                                  'https://s3-alpha-sig.figma.com/img/9cf6/9546/ebfe8be7faa0bcece189903d1e14b4d7?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=YGwJR0j8WDu-tfa~nvJd90b9coqrtqXsWyqXePok5XUXvpyN5lVWahW33A5oomX6R05rIsJnDgFouHZMy3-~iGFbdXhbaupOkOAtNM2p3O6o9iBJDeil8qfb519bIUiu-7dZBHmy~y~UUOf-eymwdj9ikjqOY~XTlycxvxcZJE3rwdcZg6pAptH6Kw~nVTymvMpIq~eLrcrq2vLxVdWVhw7jNLHAZkpfIe0jCALLAgmQ5nyZNvMqRwmnAcpSKxwjudRM0ZsDqcCUukmupdFSNCB8fbpurIjoTK7v9KR6S0WCkv5MpzD0sJiXfsXGVLHK80RHO69RMXtGZAPhRsRNkQ__',
                                  height: 100,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
            ),
            Row(

              children: [
                const Text(
                  'Beauty',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 220,),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View All',
                      style: TextStyle(color: Colors.black),
                    )),
                  const  Icon(Icons.arrow_forward_ios)
              ],
            ),
            SizedBox(
              height: 110,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => Container(
                        width: 120,
                        margin:const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(255, 247, 158, 106),
                          boxShadow: [
                            BoxShadow(color: Colors.black)
                          ]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius:const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: Image.network(
                                'https://s3-alpha-sig.figma.com/img/9cf6/9546/ebfe8be7faa0bcece189903d1e14b4d7?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=YGwJR0j8WDu-tfa~nvJd90b9coqrtqXsWyqXePok5XUXvpyN5lVWahW33A5oomX6R05rIsJnDgFouHZMy3-~iGFbdXhbaupOkOAtNM2p3O6o9iBJDeil8qfb519bIUiu-7dZBHmy~y~UUOf-eymwdj9ikjqOY~XTlycxvxcZJE3rwdcZg6pAptH6Kw~nVTymvMpIq~eLrcrq2vLxVdWVhw7jNLHAZkpfIe0jCALLAgmQ5nyZNvMqRwmnAcpSKxwjudRM0ZsDqcCUukmupdFSNCB8fbpurIjoTK7v9KR6S0WCkv5MpzD0sJiXfsXGVLHK80RHO69RMXtGZAPhRsRNkQ__',
                                height: 100,
                                width: 120,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      )),
            ),
          ],
        ),
      )),
    );
  }

  Widget buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            const  Text(
                'View all',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 140,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 120,
                  margin:const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(12),
                      image:const DecorationImage(
                          image: NetworkImage(
                              'https://s3-alpha-sig.figma.com/img/1f3a/2ea2/0e854d5fb1e4924513dfcce9ccefa3e0?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=HHgEXFEt4br9HgPFlB0zYc0rxkawN2j-ucMirhXKUSqLT9YpxRlPsDimsuFsMVhWNmS5zpGT3PKSp2f8lV8g1vx5-ujAG~n3zuM~8JQdUFOJMvnuyG6XhBoC29hcmoEVEE~3NZUW~t5nJTCWuDLa0QalSUuX2C1KlN1eTeRBOKf6edb31XpFoS7ibDZ4-FjVGXMfDGlPk3k7-OZGcUfTK7kBaHgwdJVPtn-Lz2gcRY--QnNHphtrYzt~XHu37N4gMmPadnFc8hRfJAqMW3VSWHeWAg~kgFzlsvqwZ5tQb1uBRQnqUgPHntIPKGNWSyuRnZH43PGCjnpsIHfX7RuhCg__'),
                          fit: BoxFit.cover)),
                );
              }),
        )
      ],
    );
  }
}
