import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  //====================================================
  // PRIMARY BRAND COLORS
  //====================================================

  static const Color primary = Color(0xFF00695C);
  static const Color primaryLight = Color(0xFF00897B);
  static const Color primaryDark = Color(0xFF004D40);

  static const Color secondary = Color(0xFF00ACC1);
  static const Color accent = Color(0xFF2E7D32);

  //====================================================
  // BACKGROUND
  //====================================================

  static const Color background = Color(0xFFF8FAFC);
  static const Color scaffold = Color(0xFFFFFFFF);

  static const Color darkBackground = Color(0xFF121212);
  static const Color darkScaffold = Color(0xFF1E1E1E);

  //====================================================
  // TEXT COLORS
  //====================================================

  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF616161);
  static const Color textLight = Color(0xFFFFFFFF);

  static const Color hint = Color(0xFF9E9E9E);

  //====================================================
  // STATUS COLORS
  //====================================================

  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF2196F3);

  //====================================================
  // COMPLAINT STATUS
  //====================================================

  static const Color submitted = Color(0xFF42A5F5);
  static const Color verified = Color(0xFF26A69A);
  static const Color assigned = Color(0xFFFFB300);
  static const Color inProgress = Color(0xFFFB8C00);
  static const Color resolved = Color(0xFF43A047);
  static const Color closed = Color(0xFF757575);

  //====================================================
  // CARD COLORS
  //====================================================

  static const Color card = Colors.white;
  static const Color darkCard = Color(0xFF252525);

  //====================================================
  // BORDER
  //====================================================

  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);

  //====================================================
  // ICONS
  //====================================================

  static const Color icon = Color(0xFF424242);
  static const Color iconLight = Colors.white;

  //====================================================
  // BUTTONS
  //====================================================

  static const Color buttonPrimary = primary;
  static const Color buttonSecondary = secondary;
  static const Color buttonDisabled = Color(0xFFBDBDBD);

  //====================================================
  // INPUT FIELD
  //====================================================

  static const Color inputFill = Color(0xFFF5F5F5);
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color inputFocused = primary;

  //====================================================
  // MAP
  //====================================================

  static const Color mapMarker = Color(0xFFD32F2F);
  static const Color mapRoute = Color(0xFF1976D2);

  //====================================================
  // EMERGENCY
  //====================================================

  static const Color police = Color(0xFF1565C0);
  static const Color ambulance = Color(0xFFD32F2F);
  static const Color fire = Color(0xFFFF5722);
  static const Color disaster = Color(0xFF6A1B9A);

  //====================================================
  // SHADOW
  //====================================================

  static Color shadow = Colors.black.withOpacity(0.08);

  //====================================================
  // COMMON COLORS
  //====================================================

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color grey = Color(0xFF9E9E9E);
}