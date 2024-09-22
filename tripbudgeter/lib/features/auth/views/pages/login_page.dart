import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:tripbudgeter/features/auth/services/auth_services.dart';
import 'package:tripbudgeter/features/auth/view_models/auth_view_model.dart';
import 'package:tripbudgeter/features/auth/views/pages/register_page.dart';
import 'package:tripbudgeter/features/home/views/pages/homepage.dart';
import 'package:tripbudgeter/features/profile/custom_drawer/drawer_user_controller.dart';
import 'package:tripbudgeter/features/profile/custom_drawer/home_drawer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorEmail = '';
  String _errorPassword = '';
  bool _isPasswordVisible = true;

  void _onSubmit() async {
    setState(() {
      _errorEmail = _emailController.text.isEmpty ? 'Email is required' : '';
      _errorPassword =
          _passwordController.text.isEmpty ? 'Password is required' : '';
    });

    if (_errorEmail.isEmpty && _errorPassword.isEmpty) {
      try {
        // Gọi hàm login từ AuthViewModel
        await Provider.of<AuthViewModel>(context, listen: false).login(
          email: _emailController.text,
          password: _passwordController.text,
        );
        // Đăng nhập thành công
        const FlutterSecureStorage secureStorage = FlutterSecureStorage();
        String? lastRoute = await secureStorage.read(key: 'lastRoute');
        // Xóa thông tin đăng nhập cũ
        _emailController.clear();
        _passwordController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login success'),
          ),
        );

        if (lastRoute != null && lastRoute.isNotEmpty) {
          Navigator.pushNamed(context, lastRoute);
          await secureStorage.delete(key: 'lastRoute');
        } else {
          Navigator.pushNamed(context, '/home');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed'),
          ),
        );
      }
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
    AuthServices _authServices = AuthServices();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.withOpacity(0.9),
                    Colors.blue.withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  _header(context),
                  const SizedBox(height: 30),
                  _inputField(context),
                  const SizedBox(height: 20),
                  _forgotPassword(context),
                  _signup(context),
                  _socialButton(
                    context,
                    'assets/images/gmail.png',
                    'Continue with Google',
                    () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => DrawerUserController(),
                        ),
                      );
                    },
                    backgroundColor: Colors.white,
                    textColor: Colors.black87,
                    borderColor: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text("Enter your credentials to login",
            style: TextStyle(color: Colors.white)),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.email),
            errorText: _errorEmail.isEmpty ? null : _errorEmail,
            errorStyle: const TextStyle(color: Colors.red),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          obscureText:
              !_isPasswordVisible, // Ẩn mật khẩu nếu _isPasswordVisible là false
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.lock),
            errorText: _errorPassword.isEmpty ? null : _errorPassword,
            errorStyle: const TextStyle(color: Colors.red),
            // Thêm biểu tượng con mắt để ẩn/hiện mật khẩu
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible =
                      !_isPasswordVisible; // Đảo ngược trạng thái
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _onSubmit,
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.purple,
            elevation: 5,
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?",
            style: TextStyle(color: Colors.white)),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const RegisterPage(),
              ),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _socialButton(BuildContext context, String logoPath, String text,
      VoidCallback onPressed,
      {Color backgroundColor = Colors.white,
      Color textColor = Colors.black87,
      Color borderColor = Colors.grey}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderColor),
        ),
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shadowColor: const Color.fromARGB(255, 80, 232, 88).withOpacity(0.2),
        elevation: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            logoPath,
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
