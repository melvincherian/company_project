import 'package:flutter/material.dart';

class RemoveBackgroundScreen extends StatelessWidget {
  const RemoveBackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon:const Icon(Icons.arrow_back_ios)),
        title:const Text('RemoveBackground',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }
}