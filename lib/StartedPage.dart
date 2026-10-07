import 'package:flutter/material.dart';
import 'package:flutter_application_2/LoginPage.dart';

class StartedPage extends StatelessWidget {
  const StartedPage({super.key});

  static const _background = Color(0xFFEEEAE9);
  static const _text = Color(0xFF303238);
  static const _softText = Color(0xFF77777D);
  static const _lightShadow = Colors.white;
  static const _darkShadow = Color(0xFFC7C1C0);
  static const _accent = Color(0xFFEF5757);

  Widget _buildBrand() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 55,
            height: 55,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _background,
              borderRadius: BorderRadius.circular(17),
              boxShadow: const [
                BoxShadow(
                  color: _darkShadow,
                  offset: Offset(7, 7),
                  blurRadius: 15,
                ),
                BoxShadow(
                  color: _lightShadow,
                  offset: Offset(-7, -7),
                  blurRadius: 15,
                ),
              ],
            ),
            child: const Text(
              'SE',
              style: TextStyle(
                color: _accent,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'School Event',
                style: TextStyle(
                  color: _text,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Management System',
                style: TextStyle(color: _softText, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openLogin(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 60,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 460),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildBrand(),
                        const Text(
                          'School Event',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _text,
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.5,
                          ),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          'Management System',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _accent,
                            fontSize: 27,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 18, 10, 30),
                          child: Text(
                            'Manage school events, registrations, and '
                            'participants in one simple application.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _softText,
                              fontSize: 14,
                              height: 1.7,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => _openLogin(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _accent,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              shadowColor: _darkShadow,
                            ),
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
