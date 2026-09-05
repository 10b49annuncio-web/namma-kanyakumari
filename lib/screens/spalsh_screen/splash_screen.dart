import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/shared_pref_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkApp();
  }

  Future<void> _checkApp() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final bool firstTime = SharedPrefService.isFirstTime();

    if (firstTime) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.onboarding,
      );
    } else {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.login,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.splashLogo,
                  width: 220,
                ),

                const SizedBox(height: 30),

                const Text(
                  "Namma Kanyakumari",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Your Voice. Your District.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 50),

                const CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}