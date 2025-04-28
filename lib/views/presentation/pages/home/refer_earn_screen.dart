import 'package:flutter/material.dart';
// Import for Clipboard



class ReferEarnScreen extends StatelessWidget {
  const ReferEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    const Color primaryColor = Color(0xFF6842FF); // Purple
    const Color lightBlueColor = Color(0xFFE0F7FA);
    const TextStyle titleTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );
    const TextStyle contentTextStyle = TextStyle(
      fontSize: 14,
      color: Colors.black54,
    );
    const TextStyle buttonTextStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    );

 
    void showSnackBar(BuildContext context, String text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
           Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Refer & Earn',
          style: titleTextStyle,
        ),
      
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
        
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: lightBlueColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '₹100',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            'Total Earning till date',
                            style: contentTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 241, 185, 169),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '₹100',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            'Current Balance',
                            style: contentTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Redeem Now Button
              ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Redeem Now',
                  style: buttonTextStyle,
                ),
              ),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:  const Color(0xFFF8FBFF), // Light background
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Refer & Earn BIG !',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Introduce a Friend & Get 30 Credit INSTANTLY!',
                      style: contentTextStyle,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Bonus! Get 50 Credit More When They Make a Purchase!',
                      style: contentTextStyle,
                    ),
                    SizedBox(height: 12),
                   
                    // ElevatedButton(
                    //   onPressed: () {
                    //     //  Add your earn now logic
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: primaryColor,
                    //     padding: const EdgeInsets.symmetric(vertical: 12),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //   ),
                    //   child: const Text(
                    //     'Earn now',
                    //     style: buttonTextStyle,
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

               const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Earn Now',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                      ],
                    ),
                    const SizedBox(height: 18,),

              // Additional Info Section
              const Text(
                'Did you know you can earn up to AED 3000 by\n referring 10 friends in a month? That\'s equal to a\n month\'s subscription.',
                style: contentTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),


              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'HGT9LL8MEE', 
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Clipboard.setData(const ClipboardData(text: 'HGT9LL8MEE')); // Replace with your code
                    //     showSnackBar(context, 'Invite code copied!');
                    //   },
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //     child: const Text(
                    //       'Copy invite code',
                    //       style: TextStyle(
                    //         color: primaryColor,
                    //         fontWeight: FontWeight.w600,
                    //         fontSize: 12
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
                const SizedBox(height: 20),
              // Share Invite Code Button
              ElevatedButton(
                onPressed: () {
            
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Share invite code',
                  style: buttonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
