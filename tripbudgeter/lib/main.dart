import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripbudgeter/features/about/view/about.dart';
import 'package:tripbudgeter/features/auth/view_models/auth_view_model.dart';
import 'package:tripbudgeter/features/auth/views/pages/login_page.dart';
import 'package:tripbudgeter/features/home/views/pages/SecondPage.dart';
import 'package:tripbudgeter/features/home/views/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
      ],
      child: MaterialApp(
        title: 'Trip Budgeter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
