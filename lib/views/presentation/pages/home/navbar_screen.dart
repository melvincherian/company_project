import 'package:company_project/views/presentation/pages/home/category_screen.dart';
import 'package:company_project/views/presentation/pages/home/home_screen.dart';
import 'package:company_project/views/presentation/pages/home/planning_screen.dart';
import 'package:company_project/views/presentation/pages/home/poster/poster_create.dart';
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
      backgroundColor: Colors.white,
      body: pages[bottomnavbarProvider.currentIndex],
      bottomNavigationBar: Container(
        color: const Color(0xFF101526), // Dark navy background
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: const Color(0xFF101526),
          buttonBackgroundColor: Colors.yellow,
          height: 65,
          index: bottomnavbarProvider.currentIndex,
          onTap: (index) {
            bottomnavbarProvider.setIndex(index);
          },
          items: const [
            _NavBarItem(icon: Icons.home, label: 'Home'),
            _NavBarItem(icon: Icons.category, label: 'Category'),
            _NavBarItem(icon: Icons.edit, label: 'Create'),
            _NavBarItem(icon: Icons.business_center_outlined, label: 'VbizCard'),
            _NavBarItem(icon: Icons.menu, label: 'Menu'),
          ],
          animationDuration: Duration(milliseconds: 300),
          animationCurve: Curves.easeOut,
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _NavBarItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 26, color: Colors.white),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
