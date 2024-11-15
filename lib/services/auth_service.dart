import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const baseUrl = 'http://yourbackendurl.com/api/auth';

  // Signup method
  Future<void> signup(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    // Handle response
    if (response.statusCode == 200) {
      print('Signup successful');
    } else {
      print('Signup failed');
    }
  }

  // Login method
  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      print('Login successful');
      return true;
    } else {
      print('Login failed');
      return false;
    }
  }
}
