import 'package:company_project/models/get_all_plan_model.dart';
import 'package:flutter/material.dart';

class AnimatedPlanList extends StatefulWidget {
  final List<GetAllPlanModel> plans;
  final Function(GetAllPlanModel) onPlanSelected;

  const AnimatedPlanList({
    Key? key,
    required this.plans,
    required this.onPlanSelected,
  }) : super(key: key);

  @override
  State<AnimatedPlanList> createState() => _AnimatedPlanListState();
}

class _AnimatedPlanListState extends State<AnimatedPlanList> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controllers for each plan
    _controllers = List.generate(
      widget.plans.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 400 + (index * 100)),
        vsync: this,
      ),
    );
    
    // Create animations
    _animations = _controllers.map((controller) {
      return CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutQuad,
      );
    }).toList();
    
    // Start animations sequentially
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var controller in _controllers) {
        controller.forward();
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: List.generate(widget.plans.length, (index) {
          final plan = widget.plans[index];
          
          // Determine plan styling based on tier
          Map<String, dynamic> planStyle = _getPlanStyle(plan.name);
          
          return FadeTransition(
            opacity: _animations[index],
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.2),
                end: Offset.zero,
              ).animate(_animations[index]),
              child: GestureDetector(
                onTap: () => widget.onPlanSelected(plan),
                child: Hero(
                  tag: 'plan-${plan.id}',
                  flightShuttleBuilder: (
                    BuildContext flightContext,
                    Animation<double> animation,
                    HeroFlightDirection direction,
                    BuildContext fromHeroContext,
                    BuildContext toHeroContext,
                  ) {
                    return Material(
                      color: Colors.transparent,
                      child: toHeroContext.widget,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: planStyle['gradient'],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: planStyle['shadowColor'],
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        splashColor: Colors.white.withOpacity(0.1),
                        highlightColor: Colors.white.withOpacity(0.05),
                        onTap: () => widget.onPlanSelected(plan),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        planStyle['icon'],
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        plan.name.toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (plan.discountPercentage > 0)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        '${plan.discountPercentage}% OFF',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    plan.offerPrice == 0 ? '₹Free' : '₹${plan.offerPrice}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  if (plan.originalPrice > plan.offerPrice)
                                    Text(
                                      '₹${plan.originalPrice}',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 16,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  const Spacer(),
                                  Text(
                                    (plan.duration).toString(),
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Show first 2 features
                              ...plan.features.take(2).map((feature) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          feature,
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.9),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              if (plan.features.length > 2)
                                Text(
                                  '+${plan.features.length - 2} more benefits',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 13,
                                  ),
                                ),
                              const SizedBox(height: 20),
                              Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  'Choose Plan',
                                  style: TextStyle(
                                    color: planStyle['buttonTextColor'],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
  
  Map<String, dynamic> _getPlanStyle(String planName) {
    final name = planName.toUpperCase();
    
    if (name.contains('COPPER')) {
      return {
        'gradient': [Colors.orange.shade400, Colors.deepOrange.shade600],
        'shadowColor': Colors.orange.withOpacity(0.3),
        'icon': Icons.workspace_premium,
        'buttonTextColor': Colors.orange.shade700,
      };
    } else if (name.contains('SILVER')) {
      return {
        'gradient': [Colors.blueGrey.shade300, Colors.blueGrey.shade700],
        'shadowColor': Colors.blueGrey.withOpacity(0.3),
        'icon': Icons.star,
        'buttonTextColor': Colors.blueGrey.shade700,
      };
    } else if (name.contains('GOLD')) {
      return {
        'gradient': [Colors.amber.shade300, Colors.amber.shade700],
        'shadowColor': Colors.amber.withOpacity(0.3),
        'icon': Icons.auto_awesome,
        'buttonTextColor': Colors.amber.shade800,
      };
    } else {
      return {
        'gradient': [Colors.teal.shade400, Colors.teal.shade700],
        'shadowColor': Colors.teal.withOpacity(0.3),
        'icon': Icons.verified_user,
        'buttonTextColor': Colors.teal.shade700,
      };
    }
  }
}