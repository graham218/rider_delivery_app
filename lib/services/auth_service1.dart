// frontend/lib/services/auth_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const String baseUrl = 'http://localhost:5000/auth';  // Backend URL

  // Sign up function
  Future<String> signUp(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      return 'User created successfully!';
    } else {
      return json.decode(response.body)['message'] ?? 'Error occurred';
    }
  }

  // Login function
  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['token'];  // Return the JWT token
    } else {
      return json.decode(response.body)['message'] ?? 'Error occurred';
    }
  }
}
