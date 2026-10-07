import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Warna halaman login.
  static const _background = Color(0xFFEEEAE9);
  static const _text = Color(0xFF303238);
  static const _softText = Color(0xFF77777D);
  static const _accent = Color(0xFFEF5757);

  // Controller menyimpan teks yang diketik pada masing-masing kolom.
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    // Lepaskan controller saat halaman ditutup.
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  // Gaya kolom input supaya keduanya tampil konsisten.
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
      // AppBar menyediakan tombol kembali ke halaman sebelumnya.
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
                // Judul dan petunjuk login.
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
                // Kolom untuk memasukkan username.
                const Text('Username', style: TextStyle(color: _text)),
                const SizedBox(height: 8),
                TextField(
                  controller: _username,
                  decoration: _decoration('Enter username'),
                ),
                const SizedBox(height: 18),
                // Kolom password disamarkan demi privasi.
                const Text('Password', style: TextStyle(color: _text)),
                const SizedBox(height: 8),
                TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: _decoration('Enter password'),
                ),
                const SizedBox(height: 24),
                // Tampilkan input ke terminal; belum melakukan autentikasi.
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
