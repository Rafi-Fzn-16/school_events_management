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
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF5B32),
          secondary: Color(0xFFFF5B32),
          surface: Color(0xFF292D32),
          onSurface: Color(0xFFF0F0F0),
          onPrimary: Color(0xFFFFFFFF),
        ),
        scaffoldBackgroundColor: const Color(0xFF292D32),
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
