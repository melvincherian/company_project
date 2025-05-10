import 'package:company_project/models/get_all_plan_model.dart';
import 'package:flutter/material.dart';

class PlanDetailsAndPaymentScreen extends StatefulWidget {
  final GetAllPlanModel plan;

  const PlanDetailsAndPaymentScreen({
    Key? key,
    required this.plan,
  }) : super(key: key);

  @override
  State<PlanDetailsAndPaymentScreen> createState() => _PlanDetailsAndPaymentScreenState();
}

class _PlanDetailsAndPaymentScreenState extends State<PlanDetailsAndPaymentScreen> {
  String? selectedPaymentMethod;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Determine color scheme based on plan name
    Color headerColor = Colors.teal;
    Color accentColor = Colors.teal.shade200;
    IconData planIcon = Icons.verified_user;

    if (widget.plan.name.toUpperCase().contains('COPPER')) {
      headerColor = Colors.orange;
      accentColor = Colors.orange.shade200;
      planIcon = Icons.workspace_premium;
    } else if (widget.plan.name.toUpperCase().contains('SILVER')) {
      headerColor = Colors.blueGrey;
      accentColor = Colors.blueGrey.shade200;
      planIcon = Icons.star;
    } else if (widget.plan.name.toUpperCase().contains('GOLD')) {
      headerColor = Colors.amber.shade700;
      accentColor = Colors.amber.shade200;
      planIcon = Icons.auto_awesome;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Plan Details'),
        backgroundColor: headerColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Plan header
            Container(
              padding: const EdgeInsets.all(20),
              color: headerColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    planIcon,
                    size: 50,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.plan.name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.plan.offerPrice == 0 ? '₹Free' : '₹${widget.plan.offerPrice}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 5),
                      if (widget.plan.originalPrice > widget.plan.offerPrice)
                        Text(
                          '₹${widget.plan.originalPrice}',
                          style: const TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.white70,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    (widget.plan.duration).toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  if (widget.plan.discountPercentage > 0)
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '${widget.plan.discountPercentage}% OFF',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: headerColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // Plan features
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Plan Features',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...widget.plan.features.map((feature) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: headerColor,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              feature,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Payment options
            if (widget.plan.offerPrice > 0)
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment Method',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildPaymentOption(
                      'Credit/Debit Card',
                      Icons.credit_card,
                      'Pay securely using your card',
                    ),
                    _buildPaymentOption(
                      'UPI',
                      Icons.account_balance,
                      'Pay using UPI apps like Google Pay, PhonePe',
                    ),
                    _buildPaymentOption(
                      'Net Banking',
                      Icons.account_balance_wallet,
                      'Pay using your bank account',
                    ),
                  ],
                ),
              ),

            // Subscribe button
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: isLoading 
                    ? null 
                    : () => _processSubscription(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: headerColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        widget.plan.offerPrice == 0 ? 'Subscribe for Free' : 'Subscribe Now',
                        style: const TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, IconData icon, String description) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedPaymentMethod = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedPaymentMethod == title
                ? Theme.of(context).primaryColor
                : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: selectedPaymentMethod == title
                  ? Theme.of(context).primaryColor
                  : Colors.grey.shade600,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: selectedPaymentMethod == title
                          ? Theme.of(context).primaryColor
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (selectedPaymentMethod == title)
              Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
              ),
          ],
        ),
      ),
    );
  }

  void _processSubscription(BuildContext context) {
    // Implement your subscription logic here
    setState(() {
      isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Subscription Successful'),
          content: Text('You have successfully subscribed to ${widget.plan.name} plan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to previous screen
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }
}