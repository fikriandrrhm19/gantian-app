import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
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
        scaffoldBackgroundColor: const Color(0xffFAF8FF), // Background utama
        primaryColor: const Color(0xff2563EB), // Warna biru utama
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff2563EB),
          primary: const Color(0xff2563EB),
          secondary: const Color(0xff0057C2),
        ),
        fontFamily: 'sans-serif', 
      ),
      
      home: const LoginScreenPlaceholder(),
    );
  }
}

class LoginScreenPlaceholder extends StatelessWidget {
  const LoginScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Proyek Gantian Berhasil Disetup!\nReady untuk Slicing Langkah 2.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}