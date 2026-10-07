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
  static const _lightShadow = Colors.white;
  static const _darkShadow = Color(0xFFC7C1C0);
  static const _accent = Color(0xFFEF5757);

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildBrand() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: Row(
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

  Widget _buildInput({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              label,
              style: const TextStyle(
                color: _text,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: _background,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: _darkShadow,
                  offset: Offset(4, 4),
                  blurRadius: 9,
                ),
                BoxShadow(
                  color: _lightShadow,
                  offset: Offset(-4, -4),
                  blurRadius: 9,
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              style: const TextStyle(color: _text, fontSize: 14),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Color(0xFF9A999E)),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                suffixIcon: suffixIcon,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: _accent, width: 1.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _printCredentials() {
    debugPrint(
      'Username: ${_usernameController.text}\n'
      'Password: ${_passwordController.text}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
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
                              'Welcome Back',
                              style: TextStyle(
                                color: _text,
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 7),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 28),
                              child: Text(
                                'Login to continue to School Event.',
                                style: TextStyle(
                                  color: _softText,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            _buildInput(
                              label: 'Username',
                              hint: 'Enter username',
                              controller: _usernameController,
                            ),
                            _buildInput(
                              label: 'Password',
                              hint: 'Enter password',
                              controller: _passwordController,
                              obscureText: !_passwordVisible,
                              suffixIcon: IconButton(
                                tooltip: _passwordVisible
                                    ? 'Hide password'
                                    : 'Show password',
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                color: _passwordVisible ? _accent : _softText,
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                            const SizedBox(height: 3),
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _printCredentials,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _accent,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: const Text(
                                  'Login',
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
            Positioned(
              top: 16,
              left: 16,
              child: Material(
                color: _background,
                borderRadius: BorderRadius.circular(14),
                elevation: 0,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => Navigator.of(context).maybePop(),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: _darkShadow,
                          offset: Offset(5, 5),
                          blurRadius: 11,
                        ),
                        BoxShadow(
                          color: _lightShadow,
                          offset: Offset(-5, -5),
                          blurRadius: 11,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back, color: _text),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
