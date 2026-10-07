import 'package:flutter/material.dart';
import 'pages/admin_dashboard.dart';
import 'pages/landing_page.dart';
import 'pages/student_page.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SchoolEventApp());
}

class SchoolEventApp extends StatelessWidget {
  const SchoolEventApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Event Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B5CF6),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0F0F14),
        useMaterial3: true,
      ),
      home: const StartRouter(),
    );
  }
}

class StartRouter extends StatelessWidget {
  const StartRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: AuthService.getLoggedInRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == 'admin') {
          return const AdminDashboard();
        }

        if (snapshot.data == 'student') {
          return const StudentPage();
        }

        return const LandingPage();
      },
    );
  }
}
