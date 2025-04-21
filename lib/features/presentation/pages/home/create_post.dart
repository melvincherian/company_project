import 'package:flutter/material.dart';

class CreatePost extends StatelessWidget {

    final List<Map<String, String>> postTypes = const [
    {"title": "Square Post", "size": "2400*2400"},
    {"title": "Story Post", "size": "750*1334"},
    {"title": "Cover Picture", "size": "812*312"},
    {"title": "Display Picture", "size": "1200*1200"},
    {"title": "Instagram Post", "size": "1080*1350"},
    {"title": "Youtube Thumbnail", "size": "1280*720"},
    {"title": "A4 Size", "size": "2480*3507"},
    {"title": "Certificate", "size": "850*1100"},
  ];
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         appBar: AppBar(
          title: Text('Create Custom Post',
          style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();
          }, icon: Icon(Icons.arrow_back_ios)),
         ),
         body: Padding(
          padding: EdgeInsets.all(19),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: postTypes.map((post){
              return GestureDetector(
                onTap: () {
                  
                },
                child: Container(
                  width: 160,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color:const Color.fromARGB(255, 112, 39, 176)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(post['title']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      ),
                      SizedBox(height: 8,),
                      Text('(${post['size']})',
                      style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
                
              );
            }).toList()
          ),
          ),
    );
  }
}