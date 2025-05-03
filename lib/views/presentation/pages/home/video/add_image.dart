// import 'package:company_project/views/presentation/pages/home/poster/audio_screen.dart';
// import 'package:company_project/views/presentation/pages/home/poster/upload_image.dart';
// import 'package:flutter/material.dart';

// class AddImage extends StatelessWidget {
//   const AddImage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       icon: const Icon(Icons.arrow_back_ios)),
//                   const SizedBox(
//                     width: 210,
//                   ),
//                   Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 51, 68, 196),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: const Icon(Icons.share, color: Colors.white),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 51, 68, 196),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Icon(
//                         Icons.download_sharp,
//                         color: Colors.white,
//                       ))
//                 ],
//               ),
//               const SizedBox(
//                 height: 270,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadImage()));
//                     },
//                     icon: const Icon(Icons.add),
//                   ),
//                 ],
//               ),
//               const Text(
//                 'Add Image',
//                 style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//   type: BottomNavigationBarType.fixed,
//   backgroundColor: Colors.black,
//   selectedItemColor: Colors.white,
//   unselectedItemColor: Colors.white70,
//   selectedFontSize: 14, // Set to a more reasonable size
//   unselectedFontSize: 12, // Optional: keep consistent sizing
//   iconSize: 27,
//   items:  <BottomNavigationBarItem>[
//     BottomNavigationBarItem(
//       icon: Icon(Icons.wb_incandescent_outlined),
//       label: 'Filter',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.movie_creation_outlined),
//       label: 'Animation',
//     ),
//     BottomNavigationBarItem(
//       icon: GestureDetector(
//         onTap: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context)=>AudioScreen()));
//         },
//         child: Icon(Icons.volume_up_outlined)),
//       label: 'Audio',
//     ),
//   ],
// ),

//     );
//   }
// }







import 'package:company_project/views/presentation/pages/home/poster/upload_image.dart';
import 'package:flutter/material.dart';

class AddImage extends StatelessWidget {
  const AddImage({super.key});

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
                      icon: const Icon(Icons.arrow_back_ios)),
                  const SizedBox(
                    width: 210,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 51, 68, 196),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.share, color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 51, 68, 196),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.download_sharp,
                        color: Colors.white,
                      ))
                ],
              ),
              const SizedBox(
                height: 270,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadImage()));
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const Text(
                'Add Image',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
  type: BottomNavigationBarType.fixed,
  backgroundColor: Colors.black,
  selectedItemColor: Colors.white,
  unselectedItemColor: Colors.white70,
  selectedFontSize: 14, // Set to a more reasonable size
  unselectedFontSize: 12, // Optional: keep consistent sizing
  iconSize: 27,
  items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.wb_incandescent_outlined),
      label: 'Filter',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.movie_creation_outlined),
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