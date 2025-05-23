// ignore_for_file: use_key_in_widget_constructors

import 'package:company_project/views/presentation/pages/home/poster/edit_brand.dart';
import 'package:flutter/material.dart';

class FlyerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.arrow_back_ios_new),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.layers),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download, color: Colors.white),
                    label: const Text(
                      "Download",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C47FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Center Image
            Expanded(
              child: Center(
                child: Image.network(
                  'https://s3-alpha-sig.figma.com/img/9cf6/9546/ebfe8be7faa0bcece189903d1e14b4d7?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=YGwJR0j8WDu-tfa~nvJd90b9coqrtqXsWyqXePok5XUXvpyN5lVWahW33A5oomX6R05rIsJnDgFouHZMy3-~iGFbdXhbaupOkOAtNM2p3O6o9iBJDeil8qfb519bIUiu-7dZBHmy~y~UUOf-eymwdj9ikjqOY~XTlycxvxcZJE3rwdcZg6pAptH6Kw~nVTymvMpIq~eLrcrq2vLxVdWVhw7jNLHAZkpfIe0jCALLAgmQ5nyZNvMqRwmnAcpSKxwjudRM0ZsDqcCUukmupdFSNCB8fbpurIjoTK7v9KR6S0WCkv5MpzD0sJiXfsXGVLHK80RHO69RMXtGZAPhRsRNkQ__',
                ),
              ),
            ),

            // Bottom Panel
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Brand Info",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditBrand()),
                          );
                        },
                        child: const CircleAvatar(
                          child: Icon(Icons.edit, color: Colors.blue),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Edit',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Button Row with Equal Spacing
                  Row(
                    children: [
                      Expanded(
                        child: _buildBrandButton(Icons.phone, "Contact Number"),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _buildBrandButton(Icons.location_on, "Address"),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _buildBrandButton(Icons.share, "Social Media"),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _buildBrandButton(Icons.image, "Company Logo"),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBrandButton(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.black),
        ),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 10),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}








// import 'package:flutter/material.dart';

// class FlyerScreen extends StatelessWidget {
//   const FlyerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Brand Info')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Brand Details',
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             const TextField(
//               decoration: InputDecoration(
//                 labelText: 'Brand Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const TextField(
//               decoration: InputDecoration(
//                 labelText: 'Tagline',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const TextField(
//               decoration: InputDecoration(
//                 labelText: 'Contact Info',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const TextField(
//               decoration: InputDecoration(
//                 labelText: 'Website',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const TextField(
//               maxLines: 3,
//               decoration: InputDecoration(
//                 labelText: 'Description',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const Spacer(),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Brand info added to poster')),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.indigo,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//                 ),
//                 child: const Text('Add to Poster'),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }