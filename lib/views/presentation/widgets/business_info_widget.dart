
// import 'package:company_project/models/brand_model.dart';
// import 'package:flutter/material.dart';

// class BusinessInfoWidget extends StatelessWidget {
//   final BrandDataModel brandData;
  
//   const BusinessInfoWidget({
//     Key? key,
//     required this.brandData,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.8),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Business name
//           if (brandData.businessName.isNotEmpty)
//             Text(
//               brandData.businessName,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
          
//           const SizedBox(height: 4),
          
//           // Contact info - mobile and email
//           if (brandData.mobileNumber.isNotEmpty)
//             Row(
//               children: [
//                 const Icon(Icons.phone, size: 14, color: Colors.deepPurple),
//                 const SizedBox(width: 4),
//                 Text(
//                   brandData.mobileNumber,
//                   style: const TextStyle(fontSize: 12, color: Colors.black87),
//                 ),
//               ],
//             ),
            
//           if (brandData.email.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.only(top: 2),
//               child: Row(
//                 children: [
//                   const Icon(Icons.email, size: 14, color: Colors.deepPurple),
//                   const SizedBox(width: 4),
//                   Text(
//                     brandData.email,
//                     style: const TextStyle(fontSize: 12, color: Colors.black87),
//                   ),
//                 ],
//               ),
//             ),
          
//           if (brandData.address.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.only(top: 2),
//               child: Row(
//                 children: [
//                   const Icon(Icons.location_on, size: 14, color: Colors.deepPurple),
//                   const SizedBox(width: 4),
//                   Text(
//                     brandData.address,
//                     style: const TextStyle(fontSize: 12, color: Colors.black87),
//                   ),
//                 ],
//               ),
//             ),
            
//           // Display social media icons if selected
//           if (brandData.selectedSocialMedia.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.only(top: 6),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: _buildSocialMediaIcons(),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
  
//   List<Widget> _buildSocialMediaIcons() {
//     final Map<String, IconData> socialIcons = {
//       'facebook': Icons.facebook,
//       'instagram': Icons.camera_alt,
//       'whatsapp': Icons.whatshot,
//       'youtube': Icons.play_arrow,
//       'linkedin': Icons.link,
//       'twitter': Icons.tag,
//     };
    
//     return brandData.selectedSocialMedia.map((social) {
//       final IconData iconData = socialIcons[social] ?? Icons.link;
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 4),
//         child: Container(
//           padding: const EdgeInsets.all(4),
//           decoration: BoxDecoration(
//             color: const Color(0xFF8C52FF),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             iconData,
//             size: 14,
//             color: Colors.white,
//           ),
//         ),
//       );
//     }).toList();
//   }
// }