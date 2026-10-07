import 'package:flutter/material.dart';
import 'package:flutter_application_2/LoginPage.dart';

class StartedPage extends StatelessWidget {
  const StartedPage({super.key});

  static const _background = Color(0xFFEEEAE9);
  static const _text = Color(0xFF303238);
  static const _softText = Color(0xFF77777D);
  static const _accent = Color(0xFFEF5757);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'School Event',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _text,
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Text(
                  'Management System',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _accent,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Manage school events, registrations, and participants '
                    'in one simple application.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _softText,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(builder: (_) => const LoginPage()),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Get Started'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
