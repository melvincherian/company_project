import 'package:company_project/views/presentation/pages/home/Logo/edit_logo.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class LogoMakingScreen extends StatefulWidget {
  const LogoMakingScreen({super.key});

  @override
  State<LogoMakingScreen> createState() => _LogoMakingScreenState();
}

class _LogoMakingScreenState extends State<LogoMakingScreen> {
  // final List<String> categories = ["Business Ads", "Education", "Ugadi", "Beauty"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Logo Maker",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Tabs
//           SizedBox(
//   height: 70,
//   child: ListView.builder(
//     scrollDirection: Axis.horizontal,
//     padding: const EdgeInsets.symmetric(horizontal: 16),
//     itemCount: categories.length,
//     itemBuilder: (context, index) {
//       final isSelected = index == selectedIndex;
//       return GestureDetector(
//         onTap: () => setState(() => selectedIndex = index),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 250),
//           curve: Curves.easeInOut,
//           margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//           decoration: BoxDecoration(
//             gradient: isSelected
//                 ? const LinearGradient(
//                     colors: [Colors.deepPurple, Colors.deepPurpleAccent],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   )
//                 : null,
//             color: isSelected ? null : Colors.white,
//             borderRadius: BorderRadius.circular(28),
//             border: Border.all(
//               color: isSelected ? Colors.deepPurple.shade100 : Colors.grey.shade300,
//               width: 1.2,
//             ),
//             boxShadow: isSelected
//                 ? [
//                     BoxShadow(
//                       color: Colors.deepPurple.withOpacity(0.3),
//                       blurRadius: 10,
//                       offset: const Offset(0, 4),
//                     ),
//                   ]
//                 : [],
//           ),
//           child: Center(
//             child: Text(
//               categories[index],
//               style: TextStyle(
//                 color: isSelected ? Colors.white : Colors.black87,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 15,
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//   ),
// ),

          const SizedBox(height: 10),

          // Logo Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: GridView.builder(
                itemCount: 8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) => const LogoTile(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LogoTile extends StatelessWidget {
  const LogoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First Image Card
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: GestureDetector(
              onTap: () {
                _showBottomPopupsecond(context);
              },
              child: Image.asset(
                'assets/assets/749a63d69697825d9370d3aa37338c6f45d73082.png',
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Second Image Card
        GestureDetector(
          onTap: () {
            _showBottomPopup(context);
          },
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 4,
            child: ClipRRect(
                 borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                'assets/assets/4e71f25b9da2a00e2c56e397c0aab306442e3108.png',
                height: 92,
                width: double.infinity,
               
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

   void _showBottomPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo with border
            DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(20),
              dashPattern: const [6, 4],
              color: Colors.orange,
              strokeWidth: 1.5,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/assets/4e71f25b9da2a00e2c56e397c0aab306442e3108.png',
                    height: 120,
                    width: 120,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>const EditLogo()));
                    
                    },
                    child: const Text("Edit Logo",style: TextStyle(color: Colors.black),),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      
                    ),
                    onPressed: () {
                    
                      Navigator.pop(context);
                    },
                    child: const Text("Download Logo",style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showBottomPopupsecond(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo with border
            DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(20),
              dashPattern: const [6, 4],
              color: Colors.orange,
              strokeWidth: 1.5,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/assets/749a63d69697825d9370d3aa37338c6f45d73082.png',
                    height: 120,
                    width: 120,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>const EditLogo()));
                    
                    },
                    child: const Text("Edit Logo",style: TextStyle(color: Colors.black),),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      
                    ),
                    onPressed: () {
                    
                      Navigator.pop(context);
                    },
                    child: const Text("Download Logo",style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  
}
