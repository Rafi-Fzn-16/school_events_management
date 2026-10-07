import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  static const red = Color(0xFFF45155);
  static const black = Color(0xFF111111);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      // Logo dan nama aplikasi ditampilkan ringkas di kiri atas.
      title: Row(
        children: [
          Image.asset('assets/Logo.png', width: 36, height: 36),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'School Event Management',
                style: TextStyle(
                  color: black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'ADMIN',
                style: TextStyle(
                  color: red,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
      // Hapus halaman dashboard dari stack saat kembali ke login.
      actions: [
        TextButton.icon(
          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          icon: const Icon(Icons.logout, color: red),
          label: const Text('Logout', style: TextStyle(color: red)),
        ),
        const SizedBox(width: 8),
      ],
    ),
    body: const Center(
      child: Text(
        'Dashboard Admin',
        style: TextStyle(
          color: black,
          fontSize: 24,
          fontWeight: FontWeight.w900,
        ),
      ),
    ),
  );
}
