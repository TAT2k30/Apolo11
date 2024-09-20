import 'package:flutter/material.dart';

class ReportForTrip extends StatelessWidget {
  const ReportForTrip({super.key, required this.tripId});

  final int tripId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report for Trip'),
      ),
      body: Center(
        child: Text('Report for Trip $tripId'),
      ),
    );
  }
}