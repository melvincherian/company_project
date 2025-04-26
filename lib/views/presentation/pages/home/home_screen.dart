// // ignore_for_file: use_build_context_synchronously
// import 'package:company_project/providers/poster_provider.dart';
// import 'package:company_project/views/presentation/pages/home/details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
// @override
// void initState() {
//   super.initState();
//   print('HomeScreen init - about to fetch posters');
//   Future.microtask(() {
//     print('Inside microtask - calling provider');
//     final provider = Provider.of<PosterProvider>(context, listen: false);
//     provider.fetchPosters().then((_) {
//       print('Fetch completed - poster count: ${provider.posters.length}');
//     });
//   });
// }

//   @override
//   Widget build(BuildContext context) {
//       final posterprovider = Provider.of<PosterProvider>(context);
  
//   print('Building HomeScreen - Provider isLoading: ${posterprovider.isLoading}');
//   print('Building HomeScreen - Provider error: ${posterprovider.error}');
//   print('Building HomeScreen - Poster count: ${posterprovider.posters.length}');
  
//   final posters = posterprovider.posters;
//   final ugadiPosters = posters
//     .where((poster) => poster.categoryName.toLowerCase() == 'ugadi')
//     .toList();
//   final nonUgadiPosters = posters
//     .where((poster) => poster.categoryName.toLowerCase() != 'ugadi')
//     .toList();
    
//   print('Ugadi poster count: ${ugadiPosters.length}');
//   print('Non-Ugadi poster count: ${nonUgadiPosters.length}');

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         const CircleAvatar(
//                           radius: 25,
//                           backgroundImage: NetworkImage(
//                             'https://s3-alpha-sig.figma.com/img/4030/79b6/b3230e238d25d0e18c175d870e3223de?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=XFySyNNVp3PIu-XaWNdAbIr4ipi8vE4GvLA984rKxzrxcgvMnQ3sKQf37zHJAFsI1a46RUbURiGjrAYwrhXnaLXN~KvgpTungrOfy5WeGmRoTfswG64j5e~G-aYWYO3ZhyUpp-rJyncxufgg4f7StZ-NKtQ7Mp1GM2hNvNVVvr2r0QLxoH4rJMfzqklSsDodO8V02IG-cm~-hWHq-MNdZIMyboqBZ-RThbeU3-0T5pG1YVP9X66yQbUo59mcGyn22laQ0sSwMlvla~NNe8N7pqq88AnFs0cySqZExNz2tI31U4YNDLLxRLV4dA6BPvYBWcGtFptCtQttxXLijvxo7A__',
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'PMS Software',
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               'Hyderabad',
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.black.withOpacity(0.6),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: Colors.black12),
//                       ),
//                       child: const Icon(Icons.translate, size: 24),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(Icons.search, color: Colors.grey[600], size: 24),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: 'Search Poster by Topic',
//                             hintStyle: TextStyle(color: Colors.grey[600]),
//                           ),
//                         ),
//                       ),
//                       const CircleAvatar(
//                         radius: 23,
//                         backgroundColor: Color(0xFF6C4EF9),
//                         child: Icon(Icons.mic, color: Colors.white),
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 Container(
//                   height: 140,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       image: const DecorationImage(
//                           image: NetworkImage(
//                             'https://s3-alpha-sig.figma.com/img/4db5/04a1/da2c0272db46bf139b7be4d117bf4487?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Xtl5w3ekVoQ5pF-dngqC9b0aDQLbXZe-01RIu8NM5R-q7lOS7BB-WH3BZq-HXgBnyn6u8v-8KmtXbp3TH8HypbC1RHV20mK349uX5cUbmnW1PaU2agjjKzk9oAS116IM~U5feRKf~5uR2XY6HuEFckUXXTXcz1k-j415gh5p-t7okCAHN2-EjDajLkiw53cIZ1HKtniPBIKOLPb2l7YiXdKZzw1KjPHs8eX6uJXj~GBwTgwQhfntvC7W5jU8Z1IaZTjkhdJGrxAfWSp9-TFR-M~SFr-6GA4V~qaLs4PvY7xbBiC46U0pqtfSzWQ~BasllLKaY0ssP4LgUmKtatP-vw__',
//                           ),
//                           fit: BoxFit.cover)),
//                   child: Stack(
//                     children: [
//                       Positioned(
//                           top: 16,
//                           left: 16,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Ugadi Posters\nare Ready',
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                               const SizedBox(
//                                 height: 8,
//                               ),
//                               ElevatedButton(
//                                   onPressed: () {

//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.white,
//                                       foregroundColor: Colors.black,
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(8))),
//                                   child: const Text(
//                                     'Explore Now',
//                                     style: TextStyle(fontSize: 17),
//                                   ))
//                             ],
//                           )),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 120,
//                   child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: 4,
//                       itemBuilder: (context, index) => const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 14),
//                             child: Column(
//                               children: [
//                                 SizedBox(
//                                   height: 16,
//                                 ),
//                                 CircleAvatar(
//                                   radius: 30,
//                                   backgroundImage: NetworkImage(
//                                       'https://s3-alpha-sig.figma.com/img/a092/3fb0/85f706b30752e1c21ad66b14ce160e67?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=KwBBfdas3pCqKgG54~kj~3aVD6BFd66U1REkY8Ug~rQX1ZXyPlQyHjDa6beeL3CkV9FO~IDjygcgUFyO-Jq0UlKEkt4kOBoPlv2mpud-UD9RWweXFUSlc~C1UwPBTYgfpvlXUQzbtm3F6Fl3Ay-D2cGWFmT~r0pb9FTTlKSBfFsTIbYIrvM5Iyt1EeDSesHkmZBv8XlSiIwcbo309PuFywTYAiNdhqY0z12-31~12SGejo~niRFv-U7abHecL6Dw3Q9PRFCmSvL~TM4Ht0Vt1tyyuogxpIF-75qbSKnZ8JgL4jbhAN~HIOGab5B~ODdC7D27NXAWJwSrmlYSSnawuA__'),
//                                 ),
//                                 SizedBox(
//                                   height: 4,
//                                 ),
//                                 Text(
//                                   'Your Story',
//                                   style: TextStyle(color: Colors.black),
//                                 )
//                               ],
//                             ),
//                           )),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Upcoming Festivals',
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 SizedBox(
//                   height: 50,
//                   child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                      itemCount: 5,
//                       itemBuilder: (context, index) {
//                         final isSelected = index == 0;
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 6),
//                           child: Container(
//                             width: 60,
//                             height: 90,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                                 color:
//                                     isSelected ? Colors.blue[50] : Colors.white,
//                                 border: Border.all(color: Colors.grey.shade300),
//                                 borderRadius: BorderRadius.circular(12)),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   ['Sun', 'Mon', 'Tue', 'Wed', 'Thu'][index],
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Text('${13 + index}')
//                               ],
//                             ),
//                           ),
//                         );
//                       }),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Ugadi',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     TextButton(
//                         onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen()));},
//                         child: const Text(
//                           'View All',
//                           style: TextStyle(color: Colors.black),
//                         ))
//                   ],
//                 ),
//                 SizedBox(
//                   height: 150,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: ugadiPosters.length,
//                     itemBuilder: (context, index) {
//                       final poster = ugadiPosters[index];

//                       return Container(
//                         width: 120,
//                         margin: const EdgeInsets.only(right: 12),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: const Color.fromARGB(255, 169, 137, 126),
//                           boxShadow: const [
//                             BoxShadow(color: Colors.black12, blurRadius: 4)
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ClipRRect(
//                               borderRadius: const BorderRadius.vertical(
//                                   top: Radius.circular(12)),
//                               child: Image.network(
//                                 poster.images[0],
//                                 height: 100,
//                                 width: 120,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(6.0),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       poster.price == 0
//                                           ? 'Free'
//                                           : '₹ ${poster.price}',
//                                       style: const TextStyle(fontSize: 12),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Clothing/Beauty/Chemical',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     TextButton(
//                       onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen()));},
//                       child: const Text(
//                         'View All',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 150,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: nonUgadiPosters.length,
//                     itemBuilder: (context, index) {
//                       final poster = nonUgadiPosters[index];

//                       return Container(
//                         width: 120,
//                         margin: const EdgeInsets.only(right: 12),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: const Color.fromARGB(255, 169, 137, 126),
//                           boxShadow: const [
//                             BoxShadow(color: Colors.black12, blurRadius: 4)
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ClipRRect(
//                               borderRadius: const BorderRadius.vertical(
//                                   top: Radius.circular(12)),
//                               child: Image.network(
//                                 poster.images[0],
//                                 height: 100,
//                                 width: 120,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(6.0),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       poster.price == 0
//                                           ? 'Free'
//                                           : '₹ ${poster.price}',
//                                       style: const TextStyle(fontSize: 12),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }








// ignore_for_file: use_build_context_synchronously
import 'package:company_project/providers/poster_provider.dart';
import 'package:company_project/views/presentation/pages/home/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    print('HomeScreen init - about to fetch posters');
    Future.microtask(() {
      print('Inside microtask - calling provider');
      final provider = Provider.of<PosterProvider>(context, listen: false);
      provider.fetchPosters().then((_) {
        print('Fetch completed - poster count: ${provider.posters.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final posterprovider = Provider.of<PosterProvider>(context);
    
    print('Building HomeScreen - Provider isLoading: ${posterprovider.isLoading}');
    print('Building HomeScreen - Provider error: ${posterprovider.error}');
    print('Building HomeScreen - Poster count: ${posterprovider.posters.length}');
    
    final posters = posterprovider.posters;
    final ugadiPosters = posters
        .where((poster) => poster.categoryName.toLowerCase() == 'ugadi')
        .toList();
    
    // Separate lists for clothing, beauty and chemical
    final clothingPosters = posters
        .where((poster) => poster.categoryName.toLowerCase() == 'clothing')
        .toList();
    
    final beautyPosters = posters
        .where((poster) => poster.categoryName.toLowerCase() == 'beauty')
        .toList();
    
    final chemicalPosters = posters
        .where((poster) => poster.categoryName.toLowerCase() == 'chemical')
        .toList();
    
    print('Ugadi poster count: ${ugadiPosters.length}');
    print('Clothing poster count: ${clothingPosters.length}');
    print('Beauty poster count: ${beautyPosters.length}');
    print('Chemical poster count: ${chemicalPosters.length}');

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            'https://s3-alpha-sig.figma.com/img/4030/79b6/b3230e238d25d0e18c175d870e3223de?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=XFySyNNVp3PIu-XaWNdAbIr4ipi8vE4GvLA984rKxzrxcgvMnQ3sKQf37zHJAFsI1a46RUbURiGjrAYwrhXnaLXN~KvgpTungrOfy5WeGmRoTfswG64j5e~G-aYWYO3ZhyUpp-rJyncxufgg4f7StZ-NKtQ7Mp1GM2hNvNVVvr2r0QLxoH4rJMfzqklSsDodO8V02IG-cm~-hWHq-MNdZIMyboqBZ-RThbeU3-0T5pG1YVP9X66yQbUo59mcGyn22laQ0sSwMlvla~NNe8N7pqq88AnFs0cySqZExNz2tI31U4YNDLLxRLV4dA6BPvYBWcGtFptCtQttxXLijvxo7A__',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'PMS Software',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Hyderabad',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: const Icon(Icons.translate, size: 24),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey[600], size: 24),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search Poster by Topic',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ),
                      const CircleAvatar(
                        radius: 23,
                        backgroundColor: Color(0xFF6C4EF9),
                        child: Icon(Icons.mic, color: Colors.white),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: NetworkImage(
                            'https://s3-alpha-sig.figma.com/img/4db5/04a1/da2c0272db46bf139b7be4d117bf4487?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Xtl5w3ekVoQ5pF-dngqC9b0aDQLbXZe-01RIu8NM5R-q7lOS7BB-WH3BZq-HXgBnyn6u8v-8KmtXbp3TH8HypbC1RHV20mK349uX5cUbmnW1PaU2agjjKzk9oAS116IM~U5feRKf~5uR2XY6HuEFckUXXTXcz1k-j415gh5p-t7okCAHN2-EjDajLkiw53cIZ1HKtniPBIKOLPb2l7YiXdKZzw1KjPHs8eX6uJXj~GBwTgwQhfntvC7W5jU8Z1IaZTjkhdJGrxAfWSp9-TFR-M~SFr-6GA4V~qaLs4PvY7xbBiC46U0pqtfSzWQ~BasllLKaY0ssP4LgUmKtatP-vw__',
                          ),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 16,
                          left: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ugadi Posters\nare Ready',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  child: const Text(
                                    'Explore Now',
                                    style: TextStyle(fontSize: 17),
                                  ))
                            ],
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) => const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Column(
                              children: [
                                SizedBox(height: 16),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      'https://s3-alpha-sig.figma.com/img/a092/3fb0/85f706b30752e1c21ad66b14ce160e67?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=KwBBfdas3pCqKgG54~kj~3aVD6BFd66U1REkY8Ug~rQX1ZXyPlQyHjDa6beeL3CkV9FO~IDjygcgUFyO-Jq0UlKEkt4kOBoPlv2mpud-UD9RWweXFUSlc~C1UwPBTYgfpvlXUQzbtm3F6Fl3Ay-D2cGWFmT~r0pb9FTTlKSBfFsTIbYIrvM5Iyt1EeDSesHkmZBv8XlSiIwcbo309PuFywTYAiNdhqY0z12-31~12SGejo~niRFv-U7abHecL6Dw3Q9PRFCmSvL~TM4Ht0Vt1tyyuogxpIF-75qbSKnZ8JgL4jbhAN~HIOGab5B~ODdC7D27NXAWJwSrmlYSSnawuA__'),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Your Story',
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                          )),
                ),
                const SizedBox(height: 15),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Upcoming Festivals',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                     itemCount: 5,
                      itemBuilder: (context, index) {
                        final isSelected = index == 0;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Container(
                            width: 60,
                            height: 90,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color:
                                    isSelected ? Colors.blue[50] : Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ['Sun', 'Mon', 'Tue', 'Wed', 'Thu'][index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('${13 + index}')
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                
                // Ugadi Posters Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Ugadi',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailsScreen(category: 'ugadiposter')));
                        },
                        child: const Text(
                          'View All',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
                _buildPosterList(ugadiPosters),
                
                // Clothing Posters Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Clothing',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailsScreen(category: 'clothingposter',)));
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
                _buildPosterList(clothingPosters),
                
                // Beauty Posters Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Beauty',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailsScreen(category: 'beautyposter',)));
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
                _buildPosterList(beautyPosters),
                
                // Chemical Posters Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Chemical',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailsScreen(category: 'chemicalposter')));
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
                _buildPosterList(chemicalPosters),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  // Extracted method to build poster list to avoid code duplication
  Widget _buildPosterList(List posters) {
    return SizedBox(
      height: 150,
      child: posters.isEmpty
          ? const Center(
              child: Text(
                'No posters available',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: posters.length,
              itemBuilder: (context, index) {
                final poster = posters[index];
                return Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 169, 137, 126),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 4)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        child: Image.network(
                          poster.images[0],
                          height: 100,
                          width: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 100,
                              width: 120,
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                poster.price == 0
                                    ? 'Free'
                                    : '₹ ${poster.price}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}