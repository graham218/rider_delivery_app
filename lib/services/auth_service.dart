import 'package:http/http.dart' as http;

class AuthService {
  static const baseUrl = 'http://yourbackendurl.com/api/auth';

  Future<void> signup(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    // Handle response
  }
}