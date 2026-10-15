import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/dashboard_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';

  static Map<String, WidgetBuilder> get routes => {
        home: (context) => const HomeScreen(),
        login: (context) => const LoginScreen(),
        dashboard: (context) => const DashboardScreen(),
      };
}