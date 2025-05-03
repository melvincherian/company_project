import 'package:company_project/providers/customer_provider.dart';
import 'package:company_project/views/cutomers/edit_customers.dart';
import 'package:company_project/views/cutomers/new_customers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCustomers extends StatefulWidget {
  const AddCustomers({super.key});

  @override
  State<AddCustomers> createState() => _AddCustomersState();
}

class _AddCustomersState extends State<AddCustomers> {
  final String userId = 'current_user_id';
  final String email='';
  final int mobileno=0;
  final String name='name';
  final String address='address';
  final int dob=0;
  final int anniversaryDate=0;
  final String gender='';
  

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final provider = Provider.of<CreateCustomerProvider>(context, listen: false);
    
    await provider.loadCustomersFromPrefs();
    
    try {
      await provider.fetchUser(userId);
    } catch (e) {
      print('Error fetching from API: $e');
    }
    
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add customers', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        elevation: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Consumer<CreateCustomerProvider>(
        builder: (context, customerProvider, child) {
          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return Column(
            children: [
              customerProvider.customers.isEmpty
                  ? const Expanded(
                      child: Center(
                        child: Text(
                          'No customers found',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    )
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => customerProvider.fetchUser(userId),
                        child: ListView.builder(
                          itemCount: customerProvider.customers.length,
                          itemBuilder: (context, index) {
                            final customer = customerProvider.customers[index];
                            return Column(
                              children: [
                                ListTile(
                                  leading: const CircleAvatar(
                                    child: Icon(Icons.person),
                                    backgroundColor: Color(0xFFE0E0E0),
                                    foregroundColor: Colors.black,
                                  ),
                                  title: Text(customer['name'] ?? 'Unknown'),
                                  subtitle: Text('Mail: ${customer['email'] ?? 'Not provided'}'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit, size: 20),
                                        onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditCustomerScreen(customer: customer)));
                                          //     final confirm = await showDialog<bool>(
                                          //   context: context,
                                          //   builder: (context) => AlertDialog(
                                          //     title: const Text('Delete Customer'),
                                          //     content: const Text('Are you sure you want to delete this customer?'),
                                          //     actions: [
                                          //       TextButton(
                                          //         onPressed: () => Navigator.pop(context, false),
                                          //         child: const Text('Cancel'),
                                          //       ),
                                          //       TextButton(
                                          //         onPressed: () => Navigator.pop(context, true),
                                          //         child: const Text('Delete'),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // );
                                          
                                          // if (confirm == true) {
                                          //   await customerProvider.updateCustomer(
                                          //     gender: gender,
                                          //     dob: dob.toString(),
                                          //     anniversaryDate: anniversaryDate.toString(),
                                          //     address:address ,
                                          //     mobile: mobileno.toString(),
                                          //     email:email ,
                                          //     userId: userId,
                                          //     name: name,
                                          //     customerId: customer['_id'] ?? '',
                                          //   );
                                          //   // Also update SharedPreferences
                                          //   await customerProvider.saveCustomersToPrefs();
                                          // }
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                                        onPressed: () async {
                                          // Show confirmation dialog
                                          final confirm = await showDialog<bool>(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('Delete Customer'),
                                              content: const Text('Are you sure you want to delete this customer?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context, false),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context, true),
                                                  child: const Text('Delete'),
                                                ),
                                              ],
                                            ),
                                          );
                                          
                                          if (confirm == true) {
                                            await customerProvider.deleteCustomer(
                                              userId: userId,
                                              customerId: customer['_id'] ?? '',
                                            );
                                            // Also update SharedPreferences
                                            await customerProvider.saveCustomersToPrefs();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(height: 1),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => const AddnewCustomers(),
                        )
                      ).then((_) {
                        // Refresh the list when returning from add screen
                        setState(() {});
                      });
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text('Add New Customer', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF29A8DF),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}