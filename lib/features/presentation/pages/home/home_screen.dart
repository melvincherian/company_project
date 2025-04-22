import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            'https://s3-alpha-sig.figma.com/img/4030/79b6/b3230e238d25d0e18c175d870e3223de?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=XFySyNNVp3PIu-XaWNdAbIr4ipi8vE4GvLA984rKxzrxcgvMnQ3sKQf37zHJAFsI1a46RUbURiGjrAYwrhXnaLXN~KvgpTungrOfy5WeGmRoTfswG64j5e~G-aYWYO3ZhyUpp-rJyncxufgg4f7StZ-NKtQ7Mp1GM2hNvNVVvr2r0QLxoH4rJMfzqklSsDodO8V02IG-cm~-hWHq-MNdZIMyboqBZ-RThbeU3-0T5pG1YVP9X66yQbUo59mcGyn22laQ0sSwMlvla~NNe8N7pqq88AnFs0cySqZExNz2tI31U4YNDLLxRLV4dA6BPvYBWcGtFptCtQttxXLijvxo7A__',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
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
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Icon(Icons.translate, size: 24),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey[600], size: 24),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search Poster by Topic',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: Color(0xFF6C4EF9),
                        child: Icon(Icons.mic, color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
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
                            const  Text(
                                'Ugadi Posters\nare Ready',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            const  SizedBox(
                                height: 8,
                              ),
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  child:const Text(
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
                      itemBuilder: (context, index) =>const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 16,
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      'https://s3-alpha-sig.figma.com/img/a092/3fb0/85f706b30752e1c21ad66b14ce160e67?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=KwBBfdas3pCqKgG54~kj~3aVD6BFd66U1REkY8Ug~rQX1ZXyPlQyHjDa6beeL3CkV9FO~IDjygcgUFyO-Jq0UlKEkt4kOBoPlv2mpud-UD9RWweXFUSlc~C1UwPBTYgfpvlXUQzbtm3F6Fl3Ay-D2cGWFmT~r0pb9FTTlKSBfFsTIbYIrvM5Iyt1EeDSesHkmZBv8XlSiIwcbo309PuFywTYAiNdhqY0z12-31~12SGejo~niRFv-U7abHecL6Dw3Q9PRFCmSvL~TM4Ht0Vt1tyyuogxpIF-75qbSKnZ8JgL4jbhAN~HIOGab5B~ODdC7D27NXAWJwSrmlYSSnawuA__'),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Your Story',
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                          )),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Upcoming Festivals',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),),
                  ],
                ),
                SizedBox(height: 15,),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        final isSelected = index == 0;
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('${13 + index}')
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  const  Text(
                      'Ugadi',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(onPressed: () {}, 
                    child:const Text('View All',style: TextStyle(color: Colors.black),))
                  ],
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) => Container(
                            width: 120,
                            margin:const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color:const Color.fromARGB(255, 169, 137, 126),
                                boxShadow:const [
                                  BoxShadow(color: Colors.black12, blurRadius: 4)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius:const BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.network(
                                    'https://s3-alpha-sig.figma.com/img/1f3a/2ea2/0e854d5fb1e4924513dfcce9ccefa3e0?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=HHgEXFEt4br9HgPFlB0zYc0rxkawN2j-ucMirhXKUSqLT9YpxRlPsDimsuFsMVhWNmS5zpGT3PKSp2f8lV8g1vx5-ujAG~n3zuM~8JQdUFOJMvnuyG6XhBoC29hcmoEVEE~3NZUW~t5nJTCWuDLa0QalSUuX2C1KlN1eTeRBOKf6edb31XpFoS7ibDZ4-FjVGXMfDGlPk3k7-OZGcUfTK7kBaHgwdJVPtn-Lz2gcRY--QnNHphtrYzt~XHu37N4gMmPadnFc8hRfJAqMW3VSWHeWAg~kgFzlsvqwZ5tQb1uBRQnqUgPHntIPKGNWSyuRnZH43PGCjnpsIHfX7RuhCg__',
                                    height: 100,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding:const EdgeInsets.all(6.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        
                                        Text(index==0?'Free':'₹ 100',style:const TextStyle(fontSize: 12),),
                                       
                                      ],
                                    ),
                                  ),
                                  )
                              ],
                            ),
                          )),
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  const  Text(
                      'Clothing/Beauty/Chemical',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(onPressed: () {}, child:const Text('View All',style: TextStyle(color: Colors.black),))
                  ],
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) => Container(
                            width: 120,
                            margin:const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromARGB(255, 169, 137, 126),
                                boxShadow:const [
                                  BoxShadow(color: Colors.black12, blurRadius: 4)
                                ]),
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
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        
                                        Text(index==0?'Free':'₹ 100',style: TextStyle(fontSize: 12),),
                                        // Icon(Icons.download)
                                      ],
                                    ),
                                  ),
                                  )
                              ],
                            ),
                          )),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
