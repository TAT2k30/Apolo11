import 'package:flutter/material.dart';
import 'package:tripbudgeter/features/home/views/pages/homepage.dart';

class RouteManager {
  static const String home = '/home';
  static const String profile = '/profile';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      // case profile:
      //   return MaterialPageRoute(builder: (_) => ProfileScreen());
      // // Thêm các case khác theo route
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Không tìm thấy trang: ${settings.name}')),
          ),
        );
    }
  }
}
