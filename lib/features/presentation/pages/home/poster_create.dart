import 'package:company_project/features/presentation/pages/home/create_post.dart';
import 'package:company_project/features/presentation/pages/home/poster/create_poster_template.dart';
import 'package:company_project/features/presentation/widgets/appbar_clip.dart';
import 'package:flutter/material.dart';

class PosterScreen extends StatelessWidget {
  const PosterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          ClipRRect(
             borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Container(
               color: const Color.fromARGB(255, 138, 135, 198),
               child: AppBar(
                backgroundColor: Color.fromARGB(255, 138, 135, 198),
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
                   padding: EdgeInsets.all(4),
                   child: Row(
                     children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePost()));
                          },
                          child: _TabButton(text: 'Create Poster', selected: true)),
                        _TabButton(text: 'Video Ad Maker', selected: false)
                     ],
                   ),
                 )
               ],
             ),
          
           ),
                // ClipPath(
          //   clipper: AppbarClipper(),
          //   child: Container(
          //     padding: EdgeInsets.only(top: 50,left: 16,right: 16,bottom: 24),
          //     color: const Color.fromARGB(255, 169, 165, 241),
          //     width: double.infinity,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Container(
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             borderRadius: BorderRadius.circular(30),

          //           ),
          //           padding: EdgeInsets.all(4),
          //           child: Row(
          //             children: [
          //                _TabButton(text: 'Create Poster', selected: true),
          //                _TabButton(text: 'Video Ad Maker', selected: false)
          //             ],
          //           ),
          //         )
          //       ],
          //     ),

          //   ),
          // ),
          SizedBox(
            height: 30,
          
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
               GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PosterTemplate()));
                },
                 child: FeatureCard(
                    icon: Icons.dashboard_customize_outlined,
                    label: 'Create Template',
                  ),
               ),
                FeatureCard(
                  icon: Icons.design_services,
                  label: 'Logo Design',
                ),
                FeatureCard(
                  icon: Icons.video_file,
                  label: 'Image to Video',
                ),
            ],
          ),
          )
        ],
      ),
    
    );
  }
}
class _TabButton extends StatelessWidget{
  final String text;
  final bool selected;

  _TabButton({
    required this.text,
    required this.selected,
  });

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      decoration: BoxDecoration(
        color: selected?const Color.fromARGB(255, 169, 165, 241):Colors.transparent,
        borderRadius: BorderRadius.circular(30)
      ),
      child: Text(
        text,
        style: TextStyle(color: selected?Colors.white:Colors.black87,
        fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget{
  final IconData icon;
  final String label;

  FeatureCard({
    super.key,
    required this.icon,
    required this.label
  });

   @override
   Widget build(BuildContext context){
    return SizedBox(
      width: 110,
      height: 110,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.deepPurple),

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,color: Colors.deepPurple,size: 30,),
            SizedBox(height: 8,),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
   }
}