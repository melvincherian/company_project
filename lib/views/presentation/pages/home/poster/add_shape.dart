// import 'package:flutter/material.dart';

// class AddShape extends StatelessWidget {
//   const AddShape({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     }, icon: const Icon(Icons.arrow_back_ios)),
//                 const Text(
//                   'Shapes',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
//                 )
//               ],
//             ),
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     Image.network('https://s3-alpha-sig.figma.com/img/f4f2/fb96/ac1e3dda2c517ea563b266770f6f67f6?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=iXxTpJZnC1PTTOtSRNHyupBP-eR42lObUyHOnRSoMTWjB-nnNJulxWVgXBCB8QNmRKvvL9E161jF4I16N3HbSob7u3wcYDPBMaEFcCPN5P0QeJvOYkKTWlgb3SRWTEcqNq~35BcGVeP9pVyhfHfp6e1wOF~FjSq2CNEHNqN3Xh99Cgh0TC1sR9S~6sTUY~2GjvJDbyQHaX-sumwvBJXZjLyfMzfnb7tBOQoNGNsyE0B3Jtf46UyAYKpMQZlrCHse7nS9tob6DalauQ9v2i5u0GBLNjLZONxro25x8QRodbk-riPtpHU2C6LbszO3uL~OQJMJGd2u52nG1Tnig-iPUw__',
//                     width: 70,
//                     height: 50,
//                     ),
//                     SizedBox(width: 16,),
//                     Image.network('https://s3-alpha-sig.figma.com/img/9183/aa16/25caf2fd94221696c89d4b4a64e55435?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=qqAgs7eqqHeB5wuJ-DtVU1XFfNcXRLLTDa0mcNV7N4nNchq3uQM1jgayvUtW-kaVIPIOCoqGbl~29oN28av4mf72Hqr2KYzOkvLkCDWABa3bawm8pMuNx8VZYzJOEjNd0wVm940fTLrFcel1KQQG-sv07aLUDJZAkf4VW9Jltb28b9Atf90IpuHLVRZB3HIRiyaPIy~8H8tAfcD99c2QLF8nU9eYHZdzreoRh2S2JNDmu2H4gG9q-e6iOwzLruYLO6kufOLqvX7b23o9phBs27lirnJ66BiZvf7BfWEZDBceBw3o7Lm~GnaZYJ2ECxqeIP7mDF3DDkz3kn8XasRGAA__',
//                     width: 70,
//                     height: 50,
//                     ),
//                      SizedBox(width: 16,),
//                     Image.network('https://s3-alpha-sig.figma.com/img/9b85/0983/08c2dea636e26c1808c231f071c5df68?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=XzkX8nyqNca9O6kLhuhO6en9cD~NyJ8o0lCodlbrSlKJeFZpJqzoy39PnIRsDewlTWJKw3mTv9gBnNobFz5f82uXhvy0Alyw9fZgcQO~lNuf-5-HVHZkcm8FZBncXJ4EX4SLg5QbWsubZIST~99h~ix9onnDwS60i9xgS3s5zO3oUVeUhYcaOme6HW1Jk9QXheyjnugC3pmCWf10pk82GViFzvPHHiYB~ak-as~IK3F7L~w4TjRZl40oMJGwCDLVBy47mKWLP1~qzZydF5lJEw3vCWk15fsxShwB3MrYHOiZxcjIIlwQrCnd7AktbIraiCYmoyAr5hwes4EIEQEL~Q__',
//                     width: 70,
//                     height: 50,
//                     ),
//                      SizedBox(width: 16,),
//                     Image.network('https://s3-alpha-sig.figma.com/img/cb3b/e9d1/dc7bb0c86857ffd85e7a9e95732923f0?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=NvjkQRCDo7JqEx4~q7Hfy-uWZJdHyiXNQbgmFp14tVwoN2fSez7lVgl1ffoJgncbAULlmCyKwMM5yVxBxLNgDzsqIj7ro9DvErXKbg608UEF5ZZG67IwB99c7ihaBy34azJJixprOHqVXsStG7EMxcS6oypFUSfE5qAVVYPHDJEry6DORKzHpt3ZHFEEa5b1FPp-6aRYxGiMca8IZPUYqAVjWbxbmESGiJ0lVmYoh7VeU2rkmNITx8BklrxF6uq-i80rO-jhO5ESkQKQnO8Q9AGBEKtXFDKAwJpPwovIFX~tbtPmLRMTKAa2VdH5biTAeeytrBASQ9DHRF63dXol0w__',
//                     width: 70,
//                     height: 50,
//                     ),
//                       SizedBox(width: 16,),
//                     Image.network('https://s3-alpha-sig.figma.com/img/9b52/4c81/7cfcfa5b10913b2d937c21e0da49c91e?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=JBIhGGUteqaTLJOUJ-21jIH5-TTRJdE7LLUpABNWPCAoRM1xMC-FlQWGejgMuZiSL3pCYZZ4WBvF0FIPlFkiBaMpA8HyRm220PQNeXiW7wOY9DHR-~Pi3eDkVvCrYyjmkU5BkMLz4vSDVrEYjENy9MnTlJyDX8~fd3MXkVpzMgyUklx3Q3ycayFIcEXXg5Z2JkikKHM469MFHZ7Mwc9Hd3vPrubgurK2yVpFvjrkD9xR~OE3Ql3U-0hueWKDjyRCTnwC5IKF16FTJzOLozceMd090R9hFw0yS~B5pkmdKn-l~q4OgfU44P1tZnhs7N2Qy7YoUUVvdcIQP4flGpG6Ow__',
//                     width: 30,
//                     height: 50,
//                     ),

                    
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 20,),
//              Column(
//               children: [
//                 Row(
//                   children: [
//                     Image.network('https://s3-alpha-sig.figma.com/img/f4f2/fb96/ac1e3dda2c517ea563b266770f6f67f6?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=iXxTpJZnC1PTTOtSRNHyupBP-eR42lObUyHOnRSoMTWjB-nnNJulxWVgXBCB8QNmRKvvL9E161jF4I16N3HbSob7u3wcYDPBMaEFcCPN5P0QeJvOYkKTWlgb3SRWTEcqNq~35BcGVeP9pVyhfHfp6e1wOF~FjSq2CNEHNqN3Xh99Cgh0TC1sR9S~6sTUY~2GjvJDbyQHaX-sumwvBJXZjLyfMzfnb7tBOQoNGNsyE0B3Jtf46UyAYKpMQZlrCHse7nS9tob6DalauQ9v2i5u0GBLNjLZONxro25x8QRodbk-riPtpHU2C6LbszO3uL~OQJMJGd2u52nG1Tnig-iPUw__',
//                     width: 70,
//                     height: 50,
//                     ),
//                     SizedBox(width: 16,),
//                     Image.network('https://s3-alpha-sig.figma.com/img/9183/aa16/25caf2fd94221696c89d4b4a64e55435?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=qqAgs7eqqHeB5wuJ-DtVU1XFfNcXRLLTDa0mcNV7N4nNchq3uQM1jgayvUtW-kaVIPIOCoqGbl~29oN28av4mf72Hqr2KYzOkvLkCDWABa3bawm8pMuNx8VZYzJOEjNd0wVm940fTLrFcel1KQQG-sv07aLUDJZAkf4VW9Jltb28b9Atf90IpuHLVRZB3HIRiyaPIy~8H8tAfcD99c2QLF8nU9eYHZdzreoRh2S2JNDmu2H4gG9q-e6iOwzLruYLO6kufOLqvX7b23o9phBs27lirnJ66BiZvf7BfWEZDBceBw3o7Lm~GnaZYJ2ECxqeIP7mDF3DDkz3kn8XasRGAA__',
//                     width: 70,
//                     height: 50,
//                     ),
//                      SizedBox(width: 16,),
//                     Image.network('https://s3-alpha-sig.figma.com/img/9b85/0983/08c2dea636e26c1808c231f071c5df68?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=XzkX8nyqNca9O6kLhuhO6en9cD~NyJ8o0lCodlbrSlKJeFZpJqzoy39PnIRsDewlTWJKw3mTv9gBnNobFz5f82uXhvy0Alyw9fZgcQO~lNuf-5-HVHZkcm8FZBncXJ4EX4SLg5QbWsubZIST~99h~ix9onnDwS60i9xgS3s5zO3oUVeUhYcaOme6HW1Jk9QXheyjnugC3pmCWf10pk82GViFzvPHHiYB~ak-as~IK3F7L~w4TjRZl40oMJGwCDLVBy47mKWLP1~qzZydF5lJEw3vCWk15fsxShwB3MrYHOiZxcjIIlwQrCnd7AktbIraiCYmoyAr5hwes4EIEQEL~Q__',
//                     width: 70,
//                     height: 50,
//                     ),
//                      SizedBox(width: 16,),
//                     Image.network('https://s3-alpha-sig.figma.com/img/cb3b/e9d1/dc7bb0c86857ffd85e7a9e95732923f0?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=NvjkQRCDo7JqEx4~q7Hfy-uWZJdHyiXNQbgmFp14tVwoN2fSez7lVgl1ffoJgncbAULlmCyKwMM5yVxBxLNgDzsqIj7ro9DvErXKbg608UEF5ZZG67IwB99c7ihaBy34azJJixprOHqVXsStG7EMxcS6oypFUSfE5qAVVYPHDJEry6DORKzHpt3ZHFEEa5b1FPp-6aRYxGiMca8IZPUYqAVjWbxbmESGiJ0lVmYoh7VeU2rkmNITx8BklrxF6uq-i80rO-jhO5ESkQKQnO8Q9AGBEKtXFDKAwJpPwovIFX~tbtPmLRMTKAa2VdH5biTAeeytrBASQ9DHRF63dXol0w__',
//                     width: 70,
//                     height: 50,
//                     ),
//                       SizedBox(width: 16,),
//                     Image.network('https://s3-alpha-sig.figma.com/img/9b52/4c81/7cfcfa5b10913b2d937c21e0da49c91e?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=JBIhGGUteqaTLJOUJ-21jIH5-TTRJdE7LLUpABNWPCAoRM1xMC-FlQWGejgMuZiSL3pCYZZ4WBvF0FIPlFkiBaMpA8HyRm220PQNeXiW7wOY9DHR-~Pi3eDkVvCrYyjmkU5BkMLz4vSDVrEYjENy9MnTlJyDX8~fd3MXkVpzMgyUklx3Q3ycayFIcEXXg5Z2JkikKHM469MFHZ7Mwc9Hd3vPrubgurK2yVpFvjrkD9xR~OE3Ql3U-0hueWKDjyRCTnwC5IKF16FTJzOLozceMd090R9hFw0yS~B5pkmdKn-l~q4OgfU44P1tZnhs7N2Qy7YoUUVvdcIQP4flGpG6Ow__',
//                     width: 30,
//                     height: 50,
//                     ),

                    
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 20,),
//              Column(
//               children: [
//                 Row(
//                   children: [
//                     Image.network('https://s3-alpha-sig.figma.com/img/f4f2/fb96/ac1e3dda2c517ea563b266770f6f67f6?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=iXxTpJZnC1PTTOtSRNHyupBP-eR42lObUyHOnRSoMTWjB-nnNJulxWVgXBCB8QNmRKvvL9E161jF4I16N3HbSob7u3wcYDPBMaEFcCPN5P0QeJvOYkKTWlgb3SRWTEcqNq~35BcGVeP9pVyhfHfp6e1wOF~FjSq2CNEHNqN3Xh99Cgh0TC1sR9S~6sTUY~2GjvJDbyQHaX-sumwvBJXZjLyfMzfnb7tBOQoNGNsyE0B3Jtf46UyAYKpMQZlrCHse7nS9tob6DalauQ9v2i5u0GBLNjLZONxro25x8QRodbk-riPtpHU2C6LbszO3uL~OQJMJGd2u52nG1Tnig-iPUw__',
//                     width: 70,
//                     height: 50,
//                     ),
//                     SizedBox(width: 16,),
//                     Image.network('https://s3-alpha-sig.figma.com/img/9183/aa16/25caf2fd94221696c89d4b4a64e55435?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=qqAgs7eqqHeB5wuJ-DtVU1XFfNcXRLLTDa0mcNV7N4nNchq3uQM1jgayvUtW-kaVIPIOCoqGbl~29oN28av4mf72Hqr2KYzOkvLkCDWABa3bawm8pMuNx8VZYzJOEjNd0wVm940fTLrFcel1KQQG-sv07aLUDJZAkf4VW9Jltb28b9Atf90IpuHLVRZB3HIRiyaPIy~8H8tAfcD99c2QLF8nU9eYHZdzreoRh2S2JNDmu2H4gG9q-e6iOwzLruYLO6kufOLqvX7b23o9phBs27lirnJ66BiZvf7BfWEZDBceBw3o7Lm~GnaZYJ2ECxqeIP7mDF3DDkz3kn8XasRGAA__',
//                     width: 70,
//                     height: 50,
//                     ),
//                      SizedBox(width: 16,),
//                     Image.network('https://s3-alpha-sig.figma.com/img/9b85/0983/08c2dea636e26c1808c231f071c5df68?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=XzkX8nyqNca9O6kLhuhO6en9cD~NyJ8o0lCodlbrSlKJeFZpJqzoy39PnIRsDewlTWJKw3mTv9gBnNobFz5f82uXhvy0Alyw9fZgcQO~lNuf-5-HVHZkcm8FZBncXJ4EX4SLg5QbWsubZIST~99h~ix9onnDwS60i9xgS3s5zO3oUVeUhYcaOme6HW1Jk9QXheyjnugC3pmCWf10pk82GViFzvPHHiYB~ak-as~IK3F7L~w4TjRZl40oMJGwCDLVBy47mKWLP1~qzZydF5lJEw3vCWk15fsxShwB3MrYHOiZxcjIIlwQrCnd7AktbIraiCYmoyAr5hwes4EIEQEL~Q__',
//                     width: 70,
//                     height: 50,
//                     ),
//                      SizedBox(width: 16,),
//                     Image.network('https://s3-alpha-sig.figma.com/img/cb3b/e9d1/dc7bb0c86857ffd85e7a9e95732923f0?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=NvjkQRCDo7JqEx4~q7Hfy-uWZJdHyiXNQbgmFp14tVwoN2fSez7lVgl1ffoJgncbAULlmCyKwMM5yVxBxLNgDzsqIj7ro9DvErXKbg608UEF5ZZG67IwB99c7ihaBy34azJJixprOHqVXsStG7EMxcS6oypFUSfE5qAVVYPHDJEry6DORKzHpt3ZHFEEa5b1FPp-6aRYxGiMca8IZPUYqAVjWbxbmESGiJ0lVmYoh7VeU2rkmNITx8BklrxF6uq-i80rO-jhO5ESkQKQnO8Q9AGBEKtXFDKAwJpPwovIFX~tbtPmLRMTKAa2VdH5biTAeeytrBASQ9DHRF63dXol0w__',
//                     width: 70,
//                     height: 50,
//                     ),
//                       SizedBox(width: 16,),
//                     Image.network('https://s3-alpha-sig.figma.com/img/9b52/4c81/7cfcfa5b10913b2d937c21e0da49c91e?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=JBIhGGUteqaTLJOUJ-21jIH5-TTRJdE7LLUpABNWPCAoRM1xMC-FlQWGejgMuZiSL3pCYZZ4WBvF0FIPlFkiBaMpA8HyRm220PQNeXiW7wOY9DHR-~Pi3eDkVvCrYyjmkU5BkMLz4vSDVrEYjENy9MnTlJyDX8~fd3MXkVpzMgyUklx3Q3ycayFIcEXXg5Z2JkikKHM469MFHZ7Mwc9Hd3vPrubgurK2yVpFvjrkD9xR~OE3Ql3U-0hueWKDjyRCTnwC5IKF16FTJzOLozceMd090R9hFw0yS~B5pkmdKn-l~q4OgfU44P1tZnhs7N2Qy7YoUUVvdcIQP4flGpG6Ow__',
//                     width: 30,
//                     height: 50,
//                     ),

                    
//                   ],
//                 ),
//               ],
//             )
//           ],
//         ),
//       )),
//     );
//   }
// }






import 'package:company_project/models/deitor_item.dart';
import 'package:flutter/material.dart';

class AddShape extends StatelessWidget {
  const AddShape({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> shapes = [
      {'name': 'Rectangle', 'type': ShapeType.rectangle},
      {'name': 'Circle', 'type': ShapeType.circle},
      {'name': 'Triangle', 'type': ShapeType.triangle},
      {'name': 'Star', 'type': ShapeType.star},
    ];

    List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.teal,
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Add Shape')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Shape',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: shapes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context, {
                      'shapeType': shapes[index]['type'],
                      'color': Colors.blue,
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: _buildShapeIcon(shapes[index]['type']),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Select Color',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: colors.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Color selection logic
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors[index],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShapeIcon(ShapeType shapeType) {
    switch (shapeType) {
      case ShapeType.rectangle:
        return Container(
          width: 40,
          height: 30,
          color: Colors.blue,
        );
      case ShapeType.circle:
        return Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        );
      case ShapeType.triangle:
        return CustomPaint(
          size: const Size(40, 40),
          painter: TrianglePainter(color: Colors.blue),
        );
      case ShapeType.star:
        return const Icon(Icons.star, color: Colors.blue, size: 40);
      default:
        return Container();
    }
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
