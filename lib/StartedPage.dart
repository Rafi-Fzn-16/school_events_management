import 'package:flutter/material.dart';
import 'package:flutter_application_2/LoginPage.dart';

class StartedPage extends StatelessWidget {
  const StartedPage({super.key});

  static const red = Color(0xFFF45155);
  static const black = Color(0xFF111111);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'YOUR SCHOOL. YOUR MOMENTS.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: red, fontSize: 12),
                ),
                const SizedBox(height: 12),
                const Text(
                  'School Event',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: black,
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Text(
                  'Management',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: red,
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Join an event or bring one to life.\n'
                  'Choose your role to get started.\nStudent',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF555555), height: 1.2),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: 262,
                  height: 66,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push<void>(
                      context,
                      PageRouteBuilder<void>(
                        pageBuilder: (_, _, _) => const LoginPage(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.arrow_forward, size: 28),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
