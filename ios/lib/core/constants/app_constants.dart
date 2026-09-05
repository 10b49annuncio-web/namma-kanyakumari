import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  //=========================
  // APP INFORMATION
  //=========================

  static const String appName = "Namma Kanyakumari";
  static const String appVersion = "1.0.0";
  static const String packageName = "com.nammakanyakumari.app";

  static const String tagline =
      "Your Voice. Your District.";

  //=========================
  // ASSETS
  //=========================

  static const String splashLogo =
      "assets/images/splash_logo.png";

  static const String appIcon =
      "assets/images/app_icon.png";

  static const String logo =
      "assets/images/logo.png";

  //=========================
  // ONBOARDING
  //=========================

  static const String onboarding1 =
      "assets/onboarding/onboarding1.png";

  static const String onboarding2 =
      "assets/onboarding/onboarding2.png";

  static const String onboarding3 =
      "assets/onboarding/onboarding3.png";

  static const String onboarding4 =
      "assets/onboarding/onboarding4.png";

  //=========================
  // ANIMATIONS
  //=========================

  static const String loadingAnimation =
      "assets/animations/loading.json";

  static const String successAnimation =
      "assets/animations/success.json";

  static const String emptyAnimation =
      "assets/animations/empty.json";

  //=========================
  // API
  //=========================

  static const String baseUrl =
      "https://api.nammakanyakumari.in";

  //=========================
  // MAP
  //=========================

  static const double defaultLatitude = 8.0883;

  static const double defaultLongitude = 77.5385;

  //=========================
  // SHARED PREFERENCES
  //=========================

  static const String firstTime = "first_time";

  static const String userToken = "user_token";

  static const String userId = "user_id";

  static const String language = "language";

  static const String theme = "theme";

  //=========================
  // FIREBASE COLLECTIONS
  //=========================

  static const String users = "users";

  static const String complaints = "complaints";

  static const String officers = "officers";

  static const String departments = "departments";

  static const String notifications = "notifications";

  static const String feedback = "feedback";

  //=========================
  // COMPLAINT STATUS
  //=========================

  static const String submitted = "Submitted";

  static const String verified = "Verified";

  static const String assigned = "Assigned";

  static const String inProgress = "In Progress";

  static const String resolved = "Resolved";

  static const String closed = "Closed";

  //=========================
  // EMERGENCY NUMBERS
  //=========================

  static const String police = "100";

  static const String ambulance = "108";

  static const String fire = "101";

  static const String womenHelpline = "181";

  static const String disaster = "1077";

  //=========================
  // UI
  //=========================

  static const double defaultPadding = 20;

  static const double borderRadius = 18;

  static const double cardRadius = 22;

  static const Duration animationDuration =
      Duration(milliseconds: 300);
}

class AppColors {
  AppColors._();

  static const Color primary =
      Color(0xFF00695C);

  static const Color secondary =
      Color(0xFF00ACC1);

  static const Color accent =
      Color(0xFF2E7D32);

  static const Color background =
      Color(0xFFF8FAFC);

  static const Color white =
      Colors.white;

  static const Color black =
      Colors.black;

  static const Color success =
      Color(0xFF4CAF50);

  static const Color warning =
      Color(0xFFFF9800);

  static const Color error =
      Color(0xFFD32F2F);

  static const Color grey =
      Color(0xFF757575);
}