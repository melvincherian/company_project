import 'package:flutter/material.dart';
// Import the intl package for date formatting (if needed for date formatting)
import 'package:intl/intl.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  // Function to format the date (uncomment when needed)
  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(date);
  }

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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // backgroundColor: Colors.blueAccent, // AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Login Mobile Number
              _buildSectionTitle('Login Mobile Number'),
              _buildReadOnlyField('65788788768'),

              // Current Plan and Media Credits
              _buildRowSection(
                'Current Plan',
                'Trail Plan',
                'Media Credits',
                '500',
              ),
              const Divider(),

              // Expires on and Allowed Accounts
              _buildRowSection(
                'Expires on',
                'Life Time',
                'Allowed Accounts',
                '01',
              ),
              const Divider(),

              // City
              _buildSectionTitle('City'),
              _buildReadOnlyField('Kakinada, AP'),
              const Divider(),

              // Purchased History
              _buildSectionTitle('Purchased History'),
              const SizedBox(height: 8),
              _buildTransactionHistory(purchaseHistory),
            ],
          ),
        ),
      ),
    );
  }

  // Section Title with custom style
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Read-only TextField
  Widget _buildReadOnlyField(String value) {
    return TextField(
      decoration: InputDecoration(
        hintText: value,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        filled: true,
        fillColor: Colors.grey.shade200,
      ),
      style: const TextStyle(fontSize: 18),
      readOnly: true,
    );
  }

  // Row Section with two columns
  Widget _buildRowSection(String title1, String value1, String title2, String value2) {
    return Row(
      children: [
        Expanded(
          child: _buildColumnSection(title1, value1),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildColumnSection(title2, value2),
        ),
      ],
    );
  }

  // Column Section for each title-value pair
  Widget _buildColumnSection(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  // Transaction History Section
  Widget _buildTransactionHistory(List<Map<String, dynamic>> history) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final transaction = history[index];
        return Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.credit_card,
                    color: Colors.blue,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction['transactionType'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Transaction ID: ${transaction['transactionId']}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formatDate(transaction['date']),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
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
    );
  }
}
