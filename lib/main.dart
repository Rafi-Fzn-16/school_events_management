import 'package:flutter/material.dart';
import 'package:school_events_management/StartedPage.dart';

// Titik awal aplikasi Flutter.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School Event Management System',
      // Terapkan warna utama aplikasi ke seluruh halaman.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF45155)),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      // Tampilkan halaman Get Started saat aplikasi dibuka.
      home: const StartedPage(),
    );
  }
}
