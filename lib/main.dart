import 'package:company_project/providers/auth_provider.dart';
import 'package:company_project/providers/beauty_provider.dart';
import 'package:company_project/providers/category_poster_provider.dart';
import 'package:company_project/providers/category_provider.dart';
import 'package:company_project/providers/chemical_provider.dart';
import 'package:company_project/providers/clothing_provider.dart';
import 'package:company_project/providers/festival_provider.dart';
import 'package:company_project/providers/poster_provider.dart';
import 'package:company_project/providers/ugadi_provider.dart';
import 'package:company_project/views/presentation/pages/auth/splash_screen.dart';
import 'package:company_project/views/presentation/widgets/navbar/bottom_navbar.dart';
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
        ChangeNotifierProvider<BottomNavbarProvider>(create: (_)=>BottomNavbarProvider()),
        ChangeNotifierProvider(create: (_)=>AuthProvider()),
        ChangeNotifierProvider(create: (_)=>CategoryProvider()),
        ChangeNotifierProvider(create: (_)=>PosterProvider()),
        ChangeNotifierProvider(create: (_)=>ChemicalProvider()),
        ChangeNotifierProvider(create: (_)=>ClothingProvider()),
        ChangeNotifierProvider(create: (_)=>BeautyProvider()),
        ChangeNotifierProvider(create: (_)=>UgadiProvider()),
        ChangeNotifierProvider(create: (_)=>FestivalProvider()),
        ChangeNotifierProvider(create: (_) => CategoryPosterProvider()),

        
      ],
      child:const MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: SampleScreen(),
        home: SplashScreen(),
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

