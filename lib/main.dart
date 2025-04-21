import 'package:company_project/features/presentation/pages/onboarding_screen.dart';
import 'package:company_project/features/presentation/widgets/navbar/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavbarProvider>(create: (_)=>BottomNavbarProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SampleScreen(),
      ),
      );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Company Project',
    //   theme: ThemeData(
    //     scaffoldBackgroundColor: Colors.white,
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: const SampleScreen()
    // );
  }
}

