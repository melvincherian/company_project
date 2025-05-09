import 'package:company_project/views/change_industry_screen.dart';
import 'package:company_project/views/presentation/pages/home/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({super.key});

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoScrollTimer;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final List<CarouselItem> _carouselItems = [
    CarouselItem(
      title: 'Ugadi Posters\nare Ready',
      buttonText: 'Explore Now',
      category: 'ugadi',
      imagePath: 'assets/assets/4db504a1da2c0272db46bf139b7be4d117bf4487.png',
    ),
    CarouselItem(
      title: 'Chemical Posters\nJust Arrived',
      buttonText: 'View All',
      category: 'chemical',
      imagePath: 'assets/assets/chemical.jpg',
    ),
    CarouselItem(
      title: 'Clothing Posters\nUp to 50% Off',
      buttonText: 'Shop Now',
      category: 'clothing',
      imagePath: 'assets/assets/clothing.jpg',
    ),
    CarouselItem(
      title: 'Beauty Posters\nUp to 50% Off',
      buttonText: 'Shop Now',
      category: 'beauty',
      imagePath: 'assets/assets/beauty.jpg',
    ),
  ];


  @override
  void initState() {
    super.initState();
    // Setup animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Start auto-scrolling
    _startAutoScroll();

    // Start animation
    _animationController.forward();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < _carouselItems.length - 1) {
        _pageController.animateToPage(
          _currentPage + 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoScrollTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _carouselItems.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
                // Reset animation and forward again for each page change
                _animationController.reset();
                _animationController.forward();
              });
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  // Apply scale animation
                  return Transform.scale(
                    scale: _currentPage == index ? _scaleAnimation.value : 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Hero(
                        tag: 'carousel_item_$index',
                        child: CarouselItemWidget(
                          carouselItem: _carouselItems[index],
                          isActive: _currentPage == index,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        SmoothPageIndicator(
          controller: _pageController,
          count: _carouselItems.length,
          effect: const ExpandingDotsEffect(
            activeDotColor: Colors.blue,
            dotColor: Colors.grey,
            dotHeight: 8,
            dotWidth: 8,
            spacing: 4,
          ),
        ),
      ],
    );
  }
}

class CarouselItem {
  final String title;
  final String buttonText;
  final String category;
  final String imagePath;

  CarouselItem({
    required this.title,
    required this.buttonText,
    required this.category,
    required this.imagePath,
  });
}

class CarouselItemWidget extends StatelessWidget {
  final CarouselItem carouselItem;
  final bool isActive;

  const CarouselItemWidget({
    super.key,
    required this.carouselItem,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ]
            : [],
        image: DecorationImage(
          image: AssetImage(carouselItem.imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Add a gradient overlay for better text readability
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  carouselItem.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 200),
                  tween: Tween<double>(begin: 0.0, end: isActive ? 1.0 : 0.8),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                        category: carouselItem.category,
                                      )));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          carouselItem.buttonText,
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
