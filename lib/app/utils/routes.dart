
import 'package:flutter/material.dart';

import '../features/login/screen/login.screen.dart';

class AppRoutes {
  static const String initial   = '/';
  static const String login     = '/login';
  static const String homepage  = '/homepage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      // case login:
      //   return MaterialPageRoute(builder: (_) => const SignUpAppView());
      // case homepage:
      //   return MaterialPageRoute(builder: (_) => const DashboardScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
