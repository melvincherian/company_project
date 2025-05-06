import 'package:company_project/providers/auth_provider.dart';
import 'package:company_project/providers/brand_info_provider.dart';
import 'package:company_project/providers/business_category_provider.dart';
import 'package:company_project/providers/business_poster_provider.dart';
import 'package:company_project/providers/category_poster_provider.dart';
import 'package:company_project/providers/category_provider.dart';
import 'package:company_project/providers/category_providerr.dart';
import 'package:company_project/providers/customer_provider.dart';
import 'package:company_project/providers/date_time_provider.dart';
import 'package:company_project/providers/festival_provider.dart';
import 'package:company_project/providers/festivel_poster_provider.dart';
import 'package:company_project/providers/get_all_plan_provider.dart';
import 'package:company_project/providers/my_plan_provider.dart';
import 'package:company_project/providers/poster_provider.dart';
import 'package:company_project/providers/signup_provider.dart';
import 'package:company_project/providers/story_provider.dart';
import 'package:company_project/providers/user_data_provider.dart';
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
        ChangeNotifierProvider(create: (_)=>FestivalProvider()),
        ChangeNotifierProvider(create: (_) => CategoryPosterProvider()),
        ChangeNotifierProvider(create: (_)=>SignupProvider()),
        ChangeNotifierProvider(create: (_)=>StoryProvider()),
        ChangeNotifierProvider(create: (_)=>DateTimeProvider()),
        ChangeNotifierProvider(create: (_)=>FestivalPosterProvider()),
        ChangeNotifierProvider(create: (_)=>BrandInfoProvider()),
        ChangeNotifierProvider(create: (_)=>CreateCustomerProvider()),
        ChangeNotifierProvider(create: (_)=>CategoryProviderr()),
        ChangeNotifierProvider(create: (_)=>BusinessCategoryProvider()),
        ChangeNotifierProvider(create: (_)=>BusinessPosterProvider()),
        ChangeNotifierProvider(create: (_)=>GetAllPlanProvider()),
        ChangeNotifierProvider(create: (_)=>MyPlanProvider()),
        ChangeNotifierProvider(create: (_)=>UserDataProvider())
        
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

