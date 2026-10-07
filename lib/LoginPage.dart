import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const _red = Color(0xFFF45155);
  static const _black = Color(0xFF111111);

  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  // Match the calendar and school logo on the Get Started page.
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

  InputDecoration _inputStyle(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: const Color(0xFFFFF8F7),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: _red),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    children: [
                      _logo(),
                      const SizedBox(height: 32),
                      const Text.rich(
                        TextSpan(
                          style: TextStyle(
                            color: _black,
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                          ),
                          children: [
                            TextSpan(text: 'Log'),
                            TextSpan(
                              text: '-',
                              style: TextStyle(color: _red),
                            ),
                            TextSpan(text: 'in'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 42),
                      TextField(
                        controller: _username,
                        decoration: _inputStyle('Enter username'),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _password,
                        obscureText: true,
                        decoration: _inputStyle('Enter password'),
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => debugPrint(
                            'Username: ${_username.text}\n'
                            'Password: ${_password.text}',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 24,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, size: 16),
                label: const Text('BACK'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
