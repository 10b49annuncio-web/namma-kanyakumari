import 'package:flutter/material.dart';

import '../../screens/auth/login_screen.dart';
import '../../screens/auth/signup_screen.dart';
import '../../screens/home/home_screen.dart';
import '/screens/onboarding_screen.dart';
import '/screens/spalsh_screen/splash_screen.dart';

import 'app_routes.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Splash
      case AppRoutes.splash:
        return _material(const SplashScreen());

      // Onboarding
      case AppRoutes.onboarding:
        return _material(const OnboardingScreen());

      // Authentication
      case AppRoutes.login:
        return _material(const LoginScreen());

      case AppRoutes.signup:
        return _material(const SignupScreen());

      // Home
      case AppRoutes.home:
        return _material(const HomeScreen());

      // Default
      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute _material(Widget page) {
    return MaterialPageRoute(
      builder: (_) => page,
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text("Page Not Found"),
        ),
        body: const Center(
          child: Text(
            "404\nPage Not Found",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}