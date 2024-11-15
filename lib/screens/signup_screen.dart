import 'package:flutter/material.dart';
import 'package:rider_delivery_app/services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  String? _errorMessage; // To display error messages

  // Handle the sign-up process
  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _errorMessage = null; // Clear any previous errors
      });

      final error = await _authService.signUp(
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
      );

      if (error == null) {
        // Sign-up successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign up successful! Please log in.')),
        );
        Navigator.pop(context); // Navigate back to login
      } else {
        // Display error message
        setState(() {
          _errorMessage = error;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_errorMessage != null)
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleSignUp,
                child: Text('Sign Up'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back to login screen
                },
                child: Text('Already have an account? Log in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
