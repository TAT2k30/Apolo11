import 'package:flutter/material.dart';
import 'package:tripbudgeter/common/CodePopUpScreen.dart';
import 'package:tripbudgeter/features/auth/services/auth_services.dart';
import 'package:tripbudgeter/features/auth/views/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const routeName = '/register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthServices _authServices = AuthServices();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String _errorUsername = '';
  String _errorEmail = '';
  String _errorPassword = '';
  String _errorConfirmPassword = '';

  void _showCodeInputPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CodeInputPopup(),
    );
  }

  void _onSubmit() {
    setState(() {
      _errorUsername =
          _usernameController.text.isEmpty ? 'Username is required' : '';
      _errorEmail = _emailController.text.isEmpty ? 'Email is required' : '';
      _errorPassword =
          _passwordController.text.isEmpty ? 'Password is required' : '';
      _errorConfirmPassword = _confirmPasswordController.text.isEmpty
          ? 'Confirm Password is required'
          : (_confirmPasswordController.text != _passwordController.text
              ? 'Passwords do not match'
              : '');
    });

    if (_errorUsername.isEmpty &&
        _errorEmail.isEmpty &&
        _errorPassword.isEmpty &&
        _errorConfirmPassword.isEmpty) {
      // print('Username: ${_usernameController.text}');
      // print('Email: ${_emailController.text}');
      // print('Password: ${_passwordController.text}');

      // _showCodeInputPopup(context);
      try {
        var result = _authServices.handleRegister(_usernameController.text,
            _emailController.text, _passwordController.text);

        if (result != null) {
          
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Register failed, please try again later')),
          );
        }
      } catch (e) {
        print("Error register account :  ${e}");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration failed'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple.withOpacity(0.8),
                  Colors.blue.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    children: const <Widget>[
                      Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Create your account",
                        style: TextStyle(fontSize: 15, color: Colors.white70),
                      ),
                      SizedBox(height: 60),
                    ],
                  ),
                  _buildInputField("Username", Icons.person, false,
                      _usernameController, _errorUsername),
                  const SizedBox(height: 20),
                  _buildInputField("Email", Icons.email, false,
                      _emailController, _errorEmail),
                  const SizedBox(height: 20),
                  _buildInputField("Password", Icons.lock, true,
                      _passwordController, _errorPassword),
                  const SizedBox(height: 20),
                  _buildInputField("Confirm Password", Icons.lock, true,
                      _confirmPasswordController, _errorConfirmPassword,
                      isConfirmPassword: true),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _onSubmit,
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.purple,
                      elevation: 5, // Add shadow
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      "Or",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.white70),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String hintText, IconData icon, bool isPassword,
      TextEditingController controller, String errorText,
      {bool isConfirmPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: isPassword && !isConfirmPassword
              ? !_isPasswordVisible
              : isConfirmPassword
                  ? !_isConfirmPasswordVisible
                  : false,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white.withOpacity(0.2),
            prefixIcon: Icon(icon, color: Colors.white),
            hintStyle: const TextStyle(color: Colors.white70),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(20),
            errorText: errorText.isNotEmpty ? errorText : null,
            suffixIcon: isPassword || isConfirmPassword
                ? IconButton(
                    icon: Icon(
                      isConfirmPassword
                          ? (_isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off)
                          : (_isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      setState(() {
                        if (isConfirmPassword) {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        } else {
                          _isPasswordVisible = !_isPasswordVisible;
                        }
                      });
                    },
                  )
                : null,
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
