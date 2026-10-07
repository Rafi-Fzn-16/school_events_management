import 'package:flutter/material.dart';
import 'package:flutter_application_2/StartedPage.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFEF5757)),
        scaffoldBackgroundColor: const Color(0xFFEEEAE9),
        useMaterial3: true,
      ),
      home: const StartedPage(),
    );
  }
}
