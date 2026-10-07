import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const red = Color(0xFFF45155);
  static const black = Color(0xFF111111);

  final username = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  InputDecoration fieldStyle(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: const Color(0xFFFFF8F7),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: red),
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: TextButton.icon(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, size: 16),
        label: const Text('BACK'),
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            children: [
              const Text(
                'School Event',
                style: TextStyle(
                  color: black,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'Management',
                style: TextStyle(
                  color: red,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 28),
              const Text.rich(
                TextSpan(
                  style: TextStyle(
                    color: black,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                  children: [
                    TextSpan(text: 'Log'),
                    TextSpan(text: '-', style: TextStyle(color: red)),
                    TextSpan(text: 'in'),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              TextField(
                controller: username,
                decoration: fieldStyle('Enter username'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: password,
                obscureText: true,
                decoration: fieldStyle('Enter password'),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => debugPrint(
                    'Username: ${username.text}\nPassword: ${password.text}',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
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
  );
}
