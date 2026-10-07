import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _backgroundColor = Color(0xFFEEEAE9);
  static const _textColor = Color(0xFF303238);
  static const _softTextColor = Color(0xFF77777D);
  static const _lightShadow = Color(0xFFFFFFFF);
  static const _darkShadow = Color(0xFFC7C1C0);
  static const _accentColor = Color(0xFFEF5757);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _classController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final Map<String, Map<String, String>> _accounts = {};

  bool _isRegistering = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _classController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (_isRegistering) {
      _accounts[username] = {
        'name': _nameController.text.trim(),
        'class': _classController.text.trim(),
        'password': password,
      };
      _passwordController.clear();
      _confirmPasswordController.clear();
      setState(() => _isRegistering = false);
      _showMessage('Registrasi berhasil. Silakan login.');
      return;
    }

    final account = _accounts[username];
    if (account == null || account['password'] != password) {
      _showMessage('Username atau password salah.');
      return;
    }

    _showMessage('Login berhasil. Selamat datang, ${account['name']}!');
  }

  void _switchForm() {
    _formKey.currentState?.reset();
    _usernameController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    setState(() {
      _isRegistering = !_isRegistering;
      _isPasswordVisible = false;
      _isConfirmPasswordVisible = false;
    });
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
              color: _backgroundColor,
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
                color: _accentColor,
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
                  color: _textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Management System',
                style: TextStyle(color: _softTextColor, fontSize: 12),
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
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
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
                color: _textColor,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: _backgroundColor,
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
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              validator:
                  validator ??
                  (value) => value == null || value.trim().isEmpty
                      ? 'Bagian ini wajib diisi.'
                      : null,
              style: const TextStyle(color: _textColor, fontSize: 14),
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
                  borderSide: const BorderSide(color: _accentColor, width: 1.5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Colors.red, width: 1.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordInput({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback onVisibilityChanged,
    String? Function(String?)? validator,
  }) {
    return _buildInput(
      label: label,
      hint: hint,
      controller: controller,
      obscureText: !isVisible,
      validator: validator,
      suffixIcon: IconButton(
        tooltip: isVisible ? 'Sembunyikan password' : 'Tampilkan password',
        onPressed: onVisibilityChanged,
        color: isVisible ? _accentColor : _softTextColor,
        icon: Icon(isVisible ? Icons.visibility_off : Icons.visibility),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_isRegistering) ...[
            _buildInput(
              label: 'Full Name',
              hint: 'Enter your full name',
              controller: _nameController,
            ),
            _buildInput(
              label: 'Class',
              hint: 'e.g. X-PPLG',
              controller: _classController,
            ),
          ],
          _buildInput(
            label: 'Username',
            hint: _isRegistering ? 'Choose username' : 'Enter username',
            controller: _usernameController,
            validator: (value) {
              final username = value?.trim() ?? '';
              if (username.isEmpty) return 'Username wajib diisi.';
              if (_isRegistering && _accounts.containsKey(username)) {
                return 'Username sudah digunakan.';
              }
              return null;
            },
          ),
          _buildPasswordInput(
            label: 'Password',
            hint: _isRegistering ? 'Create password' : 'Enter password',
            controller: _passwordController,
            isVisible: _isPasswordVisible,
            onVisibilityChanged: () {
              setState(() => _isPasswordVisible = !_isPasswordVisible);
            },
          ),
          if (_isRegistering)
            _buildPasswordInput(
              label: 'Confirm Password',
              hint: 'Repeat password',
              controller: _confirmPasswordController,
              isVisible: _isConfirmPasswordVisible,
              onVisibilityChanged: () {
                setState(
                  () => _isConfirmPasswordVisible = !_isConfirmPasswordVisible,
                );
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Konfirmasi password wajib diisi.';
                }
                if (value != _passwordController.text) {
                  return 'Konfirmasi password tidak sama.';
                }
                return null;
              },
            ),
          const SizedBox(height: 3),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: _accentColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                shadowColor: _darkShadow,
              ),
              child: Text(
                _isRegistering ? 'Create Account' : 'Login',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 17),
          Center(
            child: TextButton(
              onPressed: _switchForm,
              style: TextButton.styleFrom(
                foregroundColor: _accentColor,
                textStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: Text(
                _isRegistering
                    ? 'Already have an account? Login'
                    : 'New here? Create an account',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
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
                        Text(
                          _isRegistering ? 'Create Account' : 'Welcome Back',
                          style: const TextStyle(
                            color: _textColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 28),
                          child: Text(
                            _isRegistering
                                ? 'Register as a student to join school events.'
                                : 'Login to continue to School Event.',
                            style: const TextStyle(
                              color: _softTextColor,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        _buildForm(),
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
