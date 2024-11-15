// login_screen.dart
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'signup_screen.dart'; // Import the sign-up screen
import 'package:rider_delivery_app/services/auth_service.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Inside your LoginScreen widget:
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorMessage; // Variable to hold the error message

  void handleLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    // Call the login method from AuthService
    final token = await _authService.login(email, password);

    if (token != null) {
      // Login successful, navigate to home or save the token
      print('Login successful! Token: $token');
      // Save token to local storage or navigate to the next screen

      // Navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(email: 'email',)),
      );
    } else {
      // Update the error message
      setState(() {
        _errorMessage = 'Incorrect username or password';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          // key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_errorMessage != null) // Show error message if not null
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              // Password Field
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: handleLogin,
                child: const Text('Login'),
              ),
              const SizedBox(height: 20),
              // Create Account link
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigate to the Sign Up screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: const Text(
                    'Create an Account',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
