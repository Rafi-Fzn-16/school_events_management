import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/event.dart';

class AuthService {
  static const String _studentsKey = 'students';
  static const String _roleKey = 'logged_in';
  static const String _usernameKey = 'current_username';

  static const String adminUsername = 'admin';
  static const String adminPassword = 'admin123';

  static Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    if (username == adminUsername && password == adminPassword) {
      await prefs.setString(_roleKey, 'admin');
      await prefs.setString(_usernameKey, username);
      return true;
    }

    final students = await getStudents();

    for (final student in students) {
      if (student.username == username && student.password == password) {
        await prefs.setString(_roleKey, 'student');
        await prefs.setString(_usernameKey, username);
        return true;
      }
    }

    return false;
  }

  static Future<bool> registerStudent(StudentAccount student) async {
    final students = await getStudents();

    if (students.any((item) => item.username == student.username)) {
      return false;
    }

    students.add(student);
    await _saveStudents(students);
    return true;
  }

  static Future<List<StudentAccount>> getStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_studentsKey);

    if (data == null || data.isEmpty) {
      return [];
    }

    final List<dynamic> decoded = jsonDecode(data);
    return decoded
        .map((item) => StudentAccount.fromMap(item))
        .toList();
  }

  static Future<void> _saveStudents(List<StudentAccount> students) async {
    final prefs = await SharedPreferences.getInstance();
    final data = students.map((student) => student.toMap()).toList();
    await prefs.setString(_studentsKey, jsonEncode(data));
  }

  static Future<String?> getLoggedInRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey);
  }

  static Future<String?> getCurrentUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  static Future<StudentAccount?> getCurrentStudent() async {
    final username = await getCurrentUsername();

    if (username == null) {
      return null;
    }

    final students = await getStudents();

    for (final student in students) {
      if (student.username == username) {
        return student;
      }
    }

    return null;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_roleKey);
    await prefs.remove(_usernameKey);
  }
}
