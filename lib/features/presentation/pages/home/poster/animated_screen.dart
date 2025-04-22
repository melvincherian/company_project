import 'package:flutter/material.dart';

class AnimatedScreen extends StatelessWidget {
  const AnimatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios),
        actions: [
          Container(
            width: 50,
            height: 50,
            
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 51, 68, 196),
              borderRadius: BorderRadius.circular(12)
            ),
            child: IconButton(
              icon: const Icon(Icons.share,color: Colors.white,),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 10,),
           Container(
            width: 50,
            height: 50,
            
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 51, 68, 196),
              borderRadius: BorderRadius.circular(12)
            ),
            child: IconButton(
              icon: const Icon(Icons.download,color: Colors.white,),
              onPressed: () {},
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          
          Expanded(
            child: Center(
              child: Image.network('https://s3-alpha-sig.figma.com/img/1fa6/8002/d5fce3019c9d28c19b64aab8d8ba4732?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=DyTFsqO4tkNV-ZokVOWGcbtsBU5EJrbJ6U~IkZjFFbD4aoz2tgR3HNHIQNmb6YQ4S-810VtYIUzaYIc~7jo5BE3aANJx3nPUzIWggaJ9g5-IngkXmqZsFoTEMKL-EiOrE2eX0TYXora15YlQwZpBZqGz-1bjViV28wmPkYnCMsvR~T2J9l0IMnhb4Xm569y9aQagV7~BALuB6ndplmgAbhkaLt~-4ULU0aFukJpFtULcppSsqfLRmMPGELmj853IG1mXRQSSrFHSx-kg5mvT5R2nH5lEqnLLMUQX-dkc1aoxqAMlp7pc6286ph7N02eWgP-qspjRyFpKuFLKnxszRw__',
              fit: BoxFit.cover,
              width: 50,
              height: 40,
              )
            ),
          ),
          
          // Filter Selector
          Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, bottom: 8),
                  child: Text(
                    'Animation',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildFilterThumbnail("LeftRight", 'https://media.istockphoto.com/id/2030840748/vector/bridge-construction-gradient-solid-icon.jpg?b=1&s=170x170&k=20&c=YzbQAZpsdrwVAx0HnhdLQ3yhA31_vSPlw9OALDx_gIc='),
                      _buildFilterThumbnail("upDown", 'https://media.istockphoto.com/id/2030840748/vector/bridge-construction-gradient-solid-icon.jpg?b=1&s=170x170&k=20&c=YzbQAZpsdrwVAx0HnhdLQ3yhA31_vSPlw9OALDx_gIc='),
                      _buildFilterThumbnail("Window", 'https://media.istockphoto.com/id/2030840748/vector/bridge-construction-gradient-solid-icon.jpg?b=1&s=170x170&k=20&c=YzbQAZpsdrwVAx0HnhdLQ3yhA31_vSPlw9OALDx_gIc='),
                      _buildFilterThumbnail("Gradient", 'https://media.istockphoto.com/id/2030840748/vector/bridge-construction-gradient-solid-icon.jpg?b=1&s=170x170&k=20&c=YzbQAZpsdrwVAx0HnhdLQ3yhA31_vSPlw9OALDx_gIc='),
                      _buildFilterThumbnail("Translation", 'https://media.istockphoto.com/id/2030840748/vector/bridge-construction-gradient-solid-icon.jpg?b=1&s=170x170&k=20&c=YzbQAZpsdrwVAx0HnhdLQ3yhA31_vSPlw9OALDx_gIc='),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterThumbnail(String label, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imagePath,
              width: 60,
              height: 45,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}