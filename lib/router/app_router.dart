import 'package:flutter/material.dart';
import 'package:login_with_bloc/screen/login_screen.dart';
import 'package:login_with_bloc/screen/register_screen.dart';

class RouteManager {
  static const String splashScreen = '/splash';
  // static const String homeScreen = '/loginScreen';
  static const String loginScreen = '/';
  static const String registerScreen = '/registerScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case registerScreen:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );

      default:
        throw const FormatException('Route not found! Check routes again!');
    }
  }
}
