import 'package:flutter/material.dart';
import 'views/login/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gantian',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffFAF8FF),
        primaryColor: const Color(0xff2563EB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff2563EB),
          primary: const Color(0xff2563EB),
          secondary: const Color(0xff0057C2),
        ),
        fontFamily: 'sans-serif', 
      ),
      home: const LoginView(),
    );
  }
}