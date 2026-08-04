import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_service.dart';

class AuthService {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("${ApiService.baseUrl}/auth/login"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> signup({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    final response = await http.post(
      Uri.parse("${ApiService.baseUrl}/auth/signup"),
      headers: {
        "Content-Type": "application/json",
      },
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
}

