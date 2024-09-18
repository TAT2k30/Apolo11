import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripbudgeter/features/auth/view_models/auth_view_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const routeName = '/register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _errorEmail = '';
  String _errorPassword = '';
  String _errorConfirmPassword = '';

  void _onSubmit() {
    setState(() {
      _errorEmail = _emailController.text.isEmpty ? 'Email is required' : '';
      _errorPassword =
          _passwordController.text.isEmpty ? 'Password is required' : '';
      _errorConfirmPassword = _confirmPasswordController.text.isEmpty
          ? 'Confirm Password is required'
          : '';
    });

    if (_errorEmail.isEmpty &&
        _errorPassword.isEmpty &&
        _errorConfirmPassword.isEmpty) {
      // Do login
      Provider.of<AuthViewModel>(context, listen: false).login(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Navigate to next screen
      Navigator.pushNamed(context, '/home');

      // Clear form
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login success'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                errorText: _errorEmail,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                errorText: _errorPassword,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                hintText: 'Confirm Password',
                errorText: _errorConfirmPassword,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _onSubmit,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
