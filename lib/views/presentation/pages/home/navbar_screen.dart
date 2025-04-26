import 'package:company_project/views/presentation/pages/home/category_screen.dart';
import 'package:company_project/views/presentation/pages/home/home_screen.dart';
import 'package:company_project/views/presentation/pages/home/planning_screen.dart';
import 'package:company_project/views/presentation/pages/home/poster_create.dart';
import 'package:company_project/views/presentation/pages/home/profile_screen.dart';
import 'package:company_project/views/presentation/widgets/navbar/bottom_navbar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavbarScreen extends StatelessWidget {
  const NavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomnavbarProvider = Provider.of<BottomNavbarProvider>(context);

    final pages = [
      const HomeScreen(),
      CategoryScreen(),
      const PosterScreen(),
      const VirtualBusinessScreen(),
      PlaningDetailsScreen()
    ];

    return Scaffold(
      body: pages[bottomnavbarProvider.currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.white,
        buttonBackgroundColor: const Color.fromARGB(255, 108, 120, 249),
        height: 65,
        index: bottomnavbarProvider.currentIndex,
        onTap: (index) {
          bottomnavbarProvider.setIndex(index);
        },
        items: const [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.grey,
          ),
          Icon(
            Icons.category,
            size: 30,
            color: Colors.grey,
          ),
          Icon(
            Icons.post_add,
            size: 30,
            color: Colors.grey,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.grey,
          ),
          Icon(
            Icons.book,
            size: 30,
            color: Colors.grey,
          ),
        ],
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeOut,
      ),
    );
  }
}
