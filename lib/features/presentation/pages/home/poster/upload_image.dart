import 'package:company_project/features/presentation/pages/home/poster/animated_screen.dart';
import 'package:company_project/features/presentation/pages/home/poster/filter_screen.dart';
import 'package:flutter/material.dart';

class UploadImage extends StatelessWidget {
  const UploadImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    }, 
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Spacer(),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 51, 68, 196),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.share, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 51, 68, 196),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.download_sharp, color: Colors.white),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  ClipRRect(
                    child: Image.network('https://s3-alpha-sig.figma.com/img/1fa6/8002/d5fce3019c9d28c19b64aab8d8ba4732?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=DyTFsqO4tkNV-ZokVOWGcbtsBU5EJrbJ6U~IkZjFFbD4aoz2tgR3HNHIQNmb6YQ4S-810VtYIUzaYIc~7jo5BE3aANJx3nPUzIWggaJ9g5-IngkXmqZsFoTEMKL-EiOrE2eX0TYXora15YlQwZpBZqGz-1bjViV28wmPkYnCMsvR~T2J9l0IMnhb4Xm569y9aQagV7~BALuB6ndplmgAbhkaLt~-4ULU0aFukJpFtULcppSsqfLRmMPGELmj853IG1mXRQSSrFHSx-kg5mvT5R2nH5lEqnLLMUQX-dkc1aoxqAMlp7pc6286ph7N02eWgP-qspjRyFpKuFLKnxszRw__',
                    width: 70,
                    height: 90,
                     fit: BoxFit.cover
                    ),
                  ),
                ],
              )
             
            ],
          ),
        ),
      ),
       bottomNavigationBar: BottomNavigationBar(
        
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        selectedFontSize: 26,
        
        iconSize: 27,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_incandescent_outlined),
            label: 'Upload Image',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FilterScreen()));
              },
              child: Icon(Icons.wb_incandescent_outlined)),
            label: 'Filter',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const AnimatedScreen()));
              },
              child: Icon(Icons.movie_creation_outlined)),
            label: 'Animation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volume_up_outlined),
            label: 'Audio',
          ),
        ],
      ),
    );
  }
}
