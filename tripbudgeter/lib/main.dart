import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripbudgeter/config/routes/routes.dart';
import 'package:tripbudgeter/features/about/view/about.dart';
import 'package:tripbudgeter/features/auth/view_models/auth_view_model.dart';
import 'package:tripbudgeter/features/auth/views/pages/login_page.dart';
import 'package:tripbudgeter/features/expenses/models/expense_model.dart';
import 'package:tripbudgeter/features/expenses/view_models/expense_view_model.dart';
import 'package:tripbudgeter/features/home/views/pages/SecondPage.dart';
import 'package:tripbudgeter/features/home/views/pages/gallerypage.dart';
import 'package:tripbudgeter/features/home/views/pages/homepage.dart';
import 'package:tripbudgeter/features/trips/views/pages/trip_detail.dart';

import 'features/reports/view_models/report_view_model.dart';
import 'features/trips/services/trip_detals_data.dart';
import 'features/trips/view_models/trip_view_model.dart';

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
        ChangeNotifierProvider(create: (context) => TripViewModel()),
        ChangeNotifierProvider(create: (context) => ExpenseViewModel()),
        ChangeNotifierProvider(create: (context) => ReportViewModel()),
      ],
      child: MaterialApp(
        title: 'Trip Budgeted',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        onGenerateRoute: RouteManager.generateRoute, 
      ),
    );
  }
}
