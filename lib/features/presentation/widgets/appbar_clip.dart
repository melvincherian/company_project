import 'package:flutter/material.dart';

class AppbarClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    final path=Path();
    path.lineTo(0, size.height-30);
    path.quadraticBezierTo(
      size.width/2,
       size.height+30,
        size.width,
         size.height-30
      );
      path.lineTo(size.width, 0);
      path.close();
      return path;
  }

  @override
  bool shouldClip(CustomClipper<Path>oldclipper)=>false;
  
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
   
    throw UnimplementedError();
  }
}