import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

class ClimateCropProductivityApp extends StatelessWidget {
  const ClimateCropProductivityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Climate & Crop Productivity DSS',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}