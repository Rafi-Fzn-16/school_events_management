import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const _background = Color(0xFFEEEAE9);
  static const _text = Color(0xFF303238);
  static const _softText = Color(0xFF77777D);
  static const _accent = Color(0xFFEF5757);

  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: Color(0xFF9A999E)),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _accent),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        foregroundColor: _text,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    color: _text,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Login to continue to School Event.',
                  style: TextStyle(color: _softText),
                ),
                const SizedBox(height: 28),
                const Text('Username', style: TextStyle(color: _text)),
                const SizedBox(height: 8),
                TextField(
                  controller: _username,
                  decoration: _decoration('Enter username'),
                ),
                const SizedBox(height: 18),
                const Text('Password', style: TextStyle(color: _text)),
                const SizedBox(height: 8),
                TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: _decoration('Enter password'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => debugPrint(
                    'Username: ${_username.text}\nPassword: ${_password.text}',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
