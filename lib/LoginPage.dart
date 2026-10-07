import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const red = Color(0xFFF45155);
  static const black = Color(0xFF111111);

  final formKey = GlobalKey<FormState>();
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
      borderSide: BorderSide.none,
    ),
  );

  // Cetak nilai input untuk sementara, tanpa proses login.
  void printLoginInput() {
    if (!formKey.currentState!.validate()) return;
    debugPrint('Username: ${username.text}\nPassword: ${password.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: 110,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Center(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              icon: const Icon(Icons.arrow_back, size: 16),
              label: const Text('BACK'),
              style: ElevatedButton.styleFrom(
                backgroundColor: red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset('assets/Logo.png', width: 140, height: 140),
                  const SizedBox(height: 28),
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
                        TextSpan(
                          text: '-',
                          style: TextStyle(color: red),
                        ),
                        TextSpan(text: 'in'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),
                  TextFormField(
                    controller: username,
                    decoration: fieldStyle('Enter username'),
                    validator: (value) => value?.trim().isNotEmpty == true
                        ? null
                        : 'Username wajib diisi',
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: fieldStyle('Enter password'),
                    validator: (value) => value?.isNotEmpty == true
                        ? null
                        : 'Password wajib diisi',
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: printLoginInput,
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
      ),
    );
  }
}
