import 'package:flutter/material.dart';
import 'package:flutter_application_2/LoginPage.dart';

class StartedPage extends StatelessWidget {
  const StartedPage({super.key});

  static const _red = Color(0xFFF45155);
  static const _black = Color(0xFF111111);

  // Calendar and school icons form a simple app logo.
  Widget _logo() => Container(
    width: 112,
    height: 112,
    decoration: BoxDecoration(
      color: const Color(0xFFFFF8F7),
      borderRadius: BorderRadius.circular(30),
      boxShadow: const [
        BoxShadow(color: Color(0x1F000000), offset: Offset(0, 8), blurRadius: 8),
      ],
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        const Icon(Icons.calendar_month_rounded, size: 78, color: _red),
        Positioned(
          right: 14,
          bottom: 18,
          child: Icon(Icons.school_rounded, size: 38, color: Colors.indigo[900]),
        ),
        const Positioned(
          top: 38,
          left: 38,
          child: Icon(Icons.star_rounded, size: 33, color: _red),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 80),
                    _logo(),
                    Column(
                      children: [
                        const Text(
                          'YOUR SCHOOL. YOUR MOMENTS.',
                          style: TextStyle(color: _red, fontSize: 12),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'School Event',
                          style: TextStyle(
                            color: _black,
                            fontSize: 27,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Text(
                          'Management',
                          style: TextStyle(
                            color: _red,
                            fontSize: 27,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Join an event or bring one to life.\n'
                          'Choose your role to get started.\nStudent',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF555555),
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 262,
                      height: 66,
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (_) => const LoginPage(),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
