import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service.dart';

class AuthService {
  // ================= LOGIN =================

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("${ApiService.baseUrl}/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    return jsonDecode(response.body);
  }

  // ================= SIGNUP =================

  Future<Map<String, dynamic>> signup({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    final response = await http.post(
      Uri.parse("${ApiService.baseUrl}/auth/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "fullName": fullName,
        "email": email,
        "phone": phone,
        "password": password,
        "role": role,
      }),
    );

    return jsonDecode(response.body);
  }

  // ================= SAVE USER =================

  Future<void> saveUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("userId", user["_id"]);
    await prefs.setString("role", user["role"]);
    await prefs.setString("name", user["fullName"]);
    await prefs.setString("email", user["email"]);
  }

  // ================= GET USER ID =================

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("userId");
  }

  // ================= GET ROLE =================

  Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("role");
  }

  // ================= LOGOUT =================

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
