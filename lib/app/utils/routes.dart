
import 'package:flutter/material.dart';
import 'package:front_spaced_repetition_system/app/features/user/screen/usr_creation.screen.dart';

import '../features/login/screen/login.screen.dart';

class AppRoutes {
  static const String initial   = '/';
  static const String usrCreation     = '/usrCreation';
  static const String homepage  = '/homepage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case usrCreation:
        return MaterialPageRoute(builder: (_) => const UserCreationScreen());
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
