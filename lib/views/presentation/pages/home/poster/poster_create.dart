// ignore_for_file: prefer_const_constructors_in_immutables, avoid_unnecessary_containers

import 'package:company_project/views/presentation/pages/home/Logo/logo_making_screen.dart';
import 'package:company_project/views/presentation/pages/home/poster/create_post.dart';
import 'package:company_project/views/presentation/pages/home/poster/create_poster_template.dart';
import 'package:company_project/views/presentation/pages/home/video/add_image.dart';
import 'package:flutter/material.dart';

// class PosterScreen extends StatelessWidget {
//   const PosterScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Column(
//         children: [
//           ClipRRect(
//              borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(30),
//               bottomRight: Radius.circular(30),
//             ),
//             child: Container(
//                color: const Color.fromARGB(255, 138, 135, 198),
//                child: AppBar(
//                 backgroundColor:const Color.fromARGB(255, 138, 135, 198),
//                 elevation: 0,
//                 automaticallyImplyLeading: false,

//                ),
//             ),
//           ),
//           Container(
             
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: [
//                  Container(
//                    decoration: BoxDecoration(
//                      color: Colors.white,
//                      borderRadius: BorderRadius.circular(30),
          
//                    ),
//                    padding:const EdgeInsets.all(4),
//                    child: Row(
//                      children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>const CreatePost()));
//                           },
//                           child: _TabButton(text: 'Create Poster', selected: true)),
//                         _TabButton(text: 'Video Ad Maker', selected: false)
//                      ],
//                    ),
//                  )
//                ],
//              ),
          
//            ),
//                 // ClipPath(
//           //   clipper: AppbarClipper(),
//           //   child: Container(
//           //     padding: EdgeInsets.only(top: 50,left: 16,right: 16,bottom: 24),
//           //     color: const Color.fromARGB(255, 169, 165, 241),
//           //     width: double.infinity,
//           //     child: Row(
//           //       mainAxisAlignment: MainAxisAlignment.center,
//           //       children: [
//           //         Container(
//           //           decoration: BoxDecoration(
//           //             color: Colors.white,
//           //             borderRadius: BorderRadius.circular(30),

//           //           ),
//           //           padding: EdgeInsets.all(4),
//           //           child: Row(
//           //             children: [
//           //                _TabButton(text: 'Create Poster', selected: true),
//           //                _TabButton(text: 'Video Ad Maker', selected: false)
//           //             ],
//           //           ),
//           //         )
//           //       ],
//           //     ),

//           //   ),
//           // ),
//        const   SizedBox(
//             height: 30,
          
//           ),
//           Padding(padding:const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Wrap(
//             spacing: 12,
//             runSpacing: 12,
//             children: [
//                GestureDetector(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const PosterTemplate()));
//                 },
//                  child: FeatureCard(
//                     icon: Icons.dashboard_customize_outlined,
//                     label: 'Create Template',
//                   ),
//                ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>const LogoMakingScreen()));
//                   },
//                   child: FeatureCard(
//                     icon: Icons.design_services,
//                     label: 'Logo Design',
//                   ),
//                 ),
//                 FeatureCard(
//                   icon: Icons.video_file,
//                   label: 'Image to Video',
//                 ),
//             ],
//           ),
//           )
//         ],
//       ),
    
//     );
//   }
// }
// class _TabButton extends StatelessWidget{
//   final String text;
//   final bool selected;

//   _TabButton({
//     required this.text,
//     required this.selected,
//   });

//   @override
//   Widget build(BuildContext context){
//     return Container(
//       padding:const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
//       decoration: BoxDecoration(
//         color: selected?const Color.fromARGB(255, 169, 165, 241):Colors.transparent,
//         borderRadius: BorderRadius.circular(30)
//       ),
//       child: Text(
//         text,
//         style: TextStyle(color: selected?Colors.white:Colors.black87,
//         fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
// }

// class FeatureCard extends StatelessWidget{
//   final IconData icon;
//   final String label;

//   FeatureCard({
//     super.key,
//     required this.icon,
//     required this.label
//   });

//    @override
//    Widget build(BuildContext context){
//     return SizedBox(
//       width: 110,
//       height: 110,
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//           side:const BorderSide(color: Colors.deepPurple),

//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon,color: Colors.deepPurple,size: 30,),
//           const  SizedBox(height: 8,),
//             Text(
//               label,
//               textAlign: TextAlign.center,
//               style:const TextStyle(fontWeight: FontWeight.bold),
//             )
//           ],
//         ),
//       ),
//     );
//    }
// }





class PosterScreen extends StatelessWidget {
  const PosterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Container(
              color: const Color.fromARGB(255, 253, 224, 59),
              child: AppBar(
                backgroundColor: const Color.fromARGB(255, 253, 224, 59),
                elevation: 0,
                automaticallyImplyLeading: false,
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => const CreatePost())
                          // );
                        },
                        child: const _TabButton(text: 'Create Poster', selected: true)
                      ),
                      // const _TabButton(text: 'Video Ad Maker', selected: false)
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PosterMaker(isCustom: false,))
                    );
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePost()));
                    },
                    child: const FeatureCard(
                      icon: Icons.dashboard_customize_outlined,
                      label: 'Create Template',
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LogoMakingScreen())
                    );
                  },
                  child: const FeatureCard(
                    icon: Icons.design_services,
                    label: 'Logo Design',
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddImage()));
                  },
                  child: const FeatureCard(
                    icon: Icons.video_file,
                    label: 'Image to Video',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const FeatureCard({super.key, 
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 48) / 3, // Adjust as needed for your layout
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: Colors.purple,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String text;
  final bool selected;

  const _TabButton({
    required this.text,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.purple : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}