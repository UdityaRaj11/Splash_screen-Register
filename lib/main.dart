import 'package:flutter/material.dart';
import 'package:splash_screen_animation/screens/great_job_screen.dart';
import 'package:splash_screen_animation/screens/home_page_Screen.dart';
import 'package:splash_screen_animation/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      routes: {
        SplashScreen.routeName: (ctx) => const SplashScreen(),
        HomePageScreen.routeName: (ctx) => HomePageScreen(),
        GreatJobScreen.routeName: (ctx) => const GreatJobScreen(),
      },
    );
  }
}
