import 'package:flutter/material.dart';
import 'package:tripbudgeter/features/auth/views/pages/login_page.dart';
import 'package:tripbudgeter/features/auth/views/pages/register_page.dart';
import 'package:tripbudgeter/features/home/views/pages/homepage.dart';
import 'package:tripbudgeter/features/profile/custom_drawer/drawer_user_controller.dart';
import 'package:tripbudgeter/features/profile/custom_drawer/home_drawer.dart';

class RouteManager {
  static const String home = '/home';
  static const String login = "/login";
  static const String profile = '/profile';
  static const String register = '/register';
  static const String homeDrawer = '/homeDrawer';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case homeDrawer: 
        return MaterialPageRoute(builder: (_) => DrawerUserController());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Không tìm thấy trang: ${settings.name}')),
          ),
        );
    }
  }
}
