import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // Base URL of the backend server
  final String _baseUrl = 'http://localhost:5000';

  // Method to sign up a new user
  Future<String?> signUp(String username, String email, String password) async {
    final url = Uri.parse('$_baseUrl/auth/signup');

    try {
      // Send the HTTP POST request to the backend
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        // Sign up successful
        return null;
      } else if (response.statusCode == 400) {
        // Handle backend validation errors
        final responseBody = jsonDecode(response.body);
        return responseBody['error'] ?? 'An error occurred';
      } else {
        // Generic error message for other status codes
        return 'An unexpected error occurred';
      }
    } catch (e) {
      // Handle network or unexpected errors
      return 'Failed to connect to the server. Please try again later.';
    }
  }

  // Method to log in an existing user
  Future<String?> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/auth/login');

    try {
      // Send the HTTP POST request to the backend
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Login successful, return the token
        final responseBody = jsonDecode(response.body);
        return responseBody['token'];
      } else if (response.statusCode == 401) {
        // Invalid credentials
        return 'Incorrect email or password';
      } else {
        // Generic error message for other status codes
        return 'An unexpected error occurred';
      }
    } catch (e) {
      // Handle network or unexpected errors
      return 'Failed to connect to the server. Please try again later.';
    }
  }
}
