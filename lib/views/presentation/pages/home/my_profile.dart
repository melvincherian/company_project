import 'package:flutter/material.dart';
// Import the intl package for date formatting

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> purchaseHistory = [
      {
        'transactionType': 'Cash-in',
        'transactionId': '564925374920',
        'amount': 100.00,
        'date': DateTime(2023, 9, 17, 10, 34),
        'status': 'confirmed',
      },
      {
        'transactionType': 'Cash-in',
        'transactionId': '564925374920',
        'amount': 100.00,
        'date': DateTime(2023, 9, 17, 10, 34),
        'status': 'confirmed',
      },
      {
        'transactionType': 'Cash-in',
        'transactionId': '564925374920',
        'amount': 100.00,
        'date': DateTime(2023, 9, 17, 10, 34),
        'status': 'confirmed',
      },
    ];

    // String formatDate(DateTime date) {
    //   return Date('dd MMM yyyy hh:mm a').format(date);
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Login Mobile Number
              const Text(
                'Login Mobile Number',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const TextField(
                //keyboardType: TextInputType.phone, //Consider adding this
                decoration: InputDecoration(
                  hintText: '65788788768', // Use the value from your data
                ),
                style: TextStyle(fontSize: 18),
                readOnly: true, // The number should not be editable
              ),
              const Divider(),

              // Current Plan and Media Credits
              const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Plan',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Trail Plan', // Use the plan name from your data
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Media Credits',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '500', // Use the credit amount from your data
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),

              // Expires on and Allowed Accounts
              const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expires on',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Life Time', // Use the expiry from your data
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Allowed Accounts',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '01', // Use the account limit from your data
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),

              // City
              const Text(
                'City',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const Text(
                'Kakinada, AP', // Use the city from your data
                style: TextStyle(fontSize: 18),
              ),
              const Divider(),

              // Purchased History
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Purchased History',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: purchaseHistory.length,
                itemBuilder: (context, index) {
                  final transaction = purchaseHistory[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8)), // Rounded corners
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.credit_card,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transaction['transactionType'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Transaction ID:\n ${transaction['transactionId']}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                // Text(
                                //   formatDate(transaction['date']),  // Use the formatDate function
                                //   style: const TextStyle(
                                //     fontSize: 12,
                                //     color: Colors.grey,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Text(
                            '\$${transaction['amount'].toStringAsFixed(2)}', // Format to 2 decimal places
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
