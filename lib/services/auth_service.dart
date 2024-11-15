import 'package:http/http.dart' as http;
import 'dart:convert'; // Import this for JSON encoding/decoding

class AuthService {
  static const baseUrl = 'http://yourbackendurl.com/api/auth';

  Future<void> signup(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}), // Use json.encode to convert data
    );

    // Handle response
    if (response.statusCode == 200) {
      print('Signup successful');
    } else {
      print('Signup failed');
    }
  }
}