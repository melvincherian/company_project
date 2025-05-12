// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:company_project/models/business_poster_model.dart';
// import 'package:company_project/views/presentation/pages/home/business/add_business.dart';

// class BusinessDetailScreen extends StatefulWidget {
//   final BusinessPosterModel poster;

//   const BusinessDetailScreen({super.key, required this.poster});

//   @override
//   State<BusinessDetailScreen> createState() => _BusinessDetailScreenState();
// }

// class _BusinessDetailScreenState extends State<BusinessDetailScreen> {
//   Duration remaining = const Duration(hours: 5, minutes: 37, seconds: 45);
//   late Timer _timer;

//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       if (remaining.inSeconds > 0) {
//         setState(() {
//           remaining = remaining - const Duration(seconds: 1);
//         });
//       } else {
//         _timer.cancel();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   String twoDigits(int n) => n.toString().padLeft(2, '0');

//   @override
//   Widget build(BuildContext context) {
//     final discount = ((1 - (widget.poster.price / widget.poster.offerPrice)) * 100).round();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () => Navigator.of(context).pop(),
//                     icon: const Icon(Icons.arrow_back_ios),
//                   ),
//                   const SizedBox(width: 10),
//                   Text(
//                     widget.poster.categoryName,
//                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Center(
//                 child: Container(
//                   width: 200,
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 10,
//                         offset: Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       widget.poster.images.isNotEmpty
//                           ? Image.network(
//                               widget.poster.images.first,
//                               height: 200,
//                               width: 400,
//                               fit: BoxFit.cover,
//                             )
//                           : const Placeholder(fallbackHeight: 125),
//                       const SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             '₹${widget.poster.price}',
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 18),
//                           ),
//                           Text(
//                             '₹${widget.poster.offerPrice}',
//                             style: const TextStyle(
//                                 decoration: TextDecoration.lineThrough),
//                           ),
//                           Text(
//                             '$discount% Off',
//                             style: const TextStyle(color: Colors.green),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: const Color(0xffe8f5ff),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     _TimerBox(title: "Hours", value: twoDigits(remaining.inHours)),
//                     _TimerBox(title: "Min", value: twoDigits(remaining.inMinutes.remainder(60))),
//                     _TimerBox(title: "Sec", value: twoDigits(remaining.inSeconds.remainder(60))),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'What will I get?',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 widget.poster.description,
//                 style: const TextStyle(color: Colors.black87),
//               ),
//               const SizedBox(height: 30),
//               Row(
//                 children: [
//                   // Expanded(
//                   //   child: OutlinedButton.icon(
//                   //     onPressed: () {
//                   //       // Implement free trial functionality here
//                   //     },
//                   //     icon: const Icon(Icons.download, color: Colors.black),
//                   //     label: const Text(
//                   //       'Free Trial',
//                   //       style: TextStyle(color: Colors.black),
//                   //     ),
//                   //     style: OutlinedButton.styleFrom(
//                   //       side: const BorderSide(color: Colors.grey),
//                   //       shape: RoundedRectangleBorder(
//                   //         borderRadius: BorderRadius.circular(20),
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const BusinessCardMaker(),
//                           ),
//                         );
//                       },
//                       icon: const Icon(Icons.shopping_cart_outlined),
//                       label: const Text('Buy Now'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepPurple,
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _TimerBox extends StatelessWidget {
//   final String title;
//   final String value;

//   const _TimerBox({required this.title, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: const TextStyle(
//               fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           title,
//           style: const TextStyle(color: Colors.black54),
//         ),
//       ],
//     );
//   }
// }






// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:company_project/models/business_poster_model.dart';
// import 'package:company_project/views/presentation/pages/home/business/add_business.dart';

// class BusinessDetailScreen extends StatefulWidget {
//   final BusinessPosterModel poster;

//   const BusinessDetailScreen({super.key, required this.poster});

//   @override
//   State<BusinessDetailScreen> createState() => _BusinessDetailScreenState();
// }

// class _BusinessDetailScreenState extends State<BusinessDetailScreen> {
//   Duration remaining = const Duration(hours: 5, minutes: 37, seconds: 45);
//   late Timer _timer;

//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       if (remaining.inSeconds > 0) {
//         setState(() {
//           remaining = remaining - const Duration(seconds: 1);
//         });
//       } else {
//         _timer.cancel();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   String twoDigits(int n) => n.toString().padLeft(2, '0');

//   @override
//   Widget build(BuildContext context) {
//     final discount = ((1 - (widget.poster.price / widget.poster.offerPrice)) * 100).round();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () => Navigator.of(context).pop(),
//                     icon: const Icon(Icons.arrow_back_ios),
//                   ),
//                   const SizedBox(width: 10),
//                   Text(
//                     widget.poster.categoryName,
//                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Center(
//                 child: Container(
//                   width: 200,
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 10,
//                         offset: Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       widget.poster.images.isNotEmpty
//                           ? Image.network(
//                               widget.poster.images.first,
//                               height: 200,
//                               width: 400,
//                               fit: BoxFit.cover,
//                             )
//                           : const Placeholder(fallbackHeight: 125),
//                       const SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             '₹${widget.poster.price}',
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 18),
//                           ),
//                           Text(
//                             '₹${widget.poster.offerPrice}',
//                             style: const TextStyle(
//                                 decoration: TextDecoration.lineThrough),
//                           ),
//                           Text(
//                             '$discount% Off',
//                             style: const TextStyle(color: Colors.green),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: const Color(0xffe8f5ff),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     _TimerBox(title: "Hours", value: twoDigits(remaining.inHours)),
//                     _TimerBox(title: "Min", value: twoDigits(remaining.inMinutes.remainder(60))),
//                     _TimerBox(title: "Sec", value: twoDigits(remaining.inSeconds.remainder(60))),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'What will I get?',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 widget.poster.description,
//                 style: const TextStyle(color: Colors.black87),
//               ),
//               const SizedBox(height: 30),
//               Row(
//                 children: [
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const BusinessCardMaker(shouldSaveOnCreate: true),
//                           ),
//                         );
//                       },
//                       icon: const Icon(Icons.shopping_cart_outlined),
//                       label: const Text('Buy Now'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepPurple,
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _TimerBox extends StatelessWidget {
//   final String title;
//   final String value;

//   const _TimerBox({required this.title, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: const TextStyle(
//               fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           title,
//           style: const TextStyle(color: Colors.black54),
//         ),
//       ],
//     );
//   }
// }




import 'dart:async';
import 'package:flutter/material.dart';
import 'package:company_project/models/business_poster_model.dart';
import 'package:company_project/views/presentation/pages/home/business/add_business.dart';

class BusinessDetailScreen extends StatefulWidget {
  final BusinessPosterModel poster;

  const BusinessDetailScreen({super.key, required this.poster});

  @override
  State<BusinessDetailScreen> createState() => _BusinessDetailScreenState();
}

class _BusinessDetailScreenState extends State<BusinessDetailScreen> {
  Duration remaining = const Duration(hours: 5, minutes: 37, seconds: 45);
  late Timer _timer;
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (remaining.inSeconds > 0) {
        setState(() {
          remaining = remaining - const Duration(seconds: 1);
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  // void _handleBuyNow() {
  //   setState(() {
  //     _isDownloading = true;
  //   });
    
  //   // Add a slight delay to show the loading state
  //   Future.delayed(const Duration(milliseconds: 300), () {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const BusinessCardMaker(shouldSaveOnCreate: true),
  //       ),
  //     ).then((_) {
  //       // When returning from the BusinessCardMaker screen
  //       if (mounted) {
  //         setState(() {
  //           _isDownloading = false;
  //         });
  //       }
  //     });
  //   });
  // }


  void _handleBuyNow() {
  setState(() {
    _isDownloading = true;
  });
  
  // Add a slight delay to show the loading state
  Future.delayed(const Duration(milliseconds: 300), () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BusinessCardMaker(
          shouldSaveOnCreate: true,
          posterImageUrl: widget.poster.images.isNotEmpty ? widget.poster.images.first : null,
        ),
      ),
    ).then((_) {
      // When returning from the BusinessCardMaker screen
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    });
  });
}


  @override
  Widget build(BuildContext context) {
    final discount = ((1 - (widget.poster.price / widget.poster.offerPrice)) * 100).round();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.poster.categoryName,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Container(
                      width: 200,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.poster.images.isNotEmpty
                              ? Image.network(
                                  widget.poster.images.first,
                                  height: 200,
                                  width: 400,
                                  fit: BoxFit.cover,
                                )
                              : const Placeholder(fallbackHeight: 125),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₹${widget.poster.price}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                '₹${widget.poster.offerPrice}',
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough),
                              ),
                              Text(
                                '$discount% Off',
                                style: const TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xffe8f5ff),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _TimerBox(title: "Hours", value: twoDigits(remaining.inHours)),
                        _TimerBox(title: "Min", value: twoDigits(remaining.inMinutes.remainder(60))),
                        _TimerBox(title: "Sec", value: twoDigits(remaining.inSeconds.remainder(60))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'What will I get?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.poster.description,
                    style: const TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _isDownloading ? null : _handleBuyNow,
                          icon: _isDownloading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.shopping_cart_outlined),
                          label: Text(_isDownloading ? 'Downloading...' : 'Buy Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Full-screen loading overlay
            if (_isDownloading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(color: Colors.deepPurple),
                        SizedBox(height: 16),
                        Text(
                          'Preparing your business card...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TimerBox extends StatelessWidget {
  final String title;
  final String value;

  const _TimerBox({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(color: Colors.black54),
        ),
      ],
    );
  }
}