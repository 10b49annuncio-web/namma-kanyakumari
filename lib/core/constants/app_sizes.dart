import 'package:flutter/material.dart';

class AppSizes {
  AppSizes._();

  //==================================
  // PADDING
  //==================================

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 40.0;
  static const double xxxl = 48.0;

  static const double defaultPadding = 20.0;
  static const double screenPadding = 24.0;

  //==================================
  // SPACING
  //==================================

  static const double space4 = 4;
  static const double space8 = 8;
  static const double space12 = 12;
  static const double space16 = 16;
  static const double space20 = 20;
  static const double space24 = 24;
  static const double space32 = 32;
  static const double space40 = 40;
  static const double space48 = 48;
  static const double space56 = 56;
  static const double space64 = 64;

  //==================================
  // BORDER RADIUS
  //==================================

  static const double radiusXS = 8;
  static const double radiusSM = 12;
  static const double radiusMD = 16;
  static const double radiusLG = 20;
  static const double radiusXL = 24;
  static const double radiusXXL = 30;
  static const double radiusCircular = 100;

  //==================================
  // ICONS
  //==================================

  static const double iconXS = 16;
  static const double iconSM = 20;
  static const double iconMD = 24;
  static const double iconLG = 32;
  static const double iconXL = 40;
  static const double iconXXL = 48;

  //==================================
  // BUTTONS
  //==================================

  static const double buttonHeight = 56;
  static const double buttonRadius = 18;
  static const double buttonElevation = 0;

  //==================================
  // TEXTFIELDS
  //==================================

  static const double textFieldHeight = 58;
  static const double textFieldRadius = 16;

  //==================================
  // APP BAR
  //==================================

  static const double appBarHeight = 60;

  //==================================
  // BOTTOM NAVIGATION
  //==================================

  static const double bottomNavHeight = 70;

  //==================================
  // CARDS
  //==================================

  static const double cardRadius = 22;
  static const double cardElevation = 3;

  //==================================
  // IMAGES
  //==================================

  static const double splashLogo = 170;
  static const double onboardingImage = 320;
  static const double profileImage = 120;
  static const double complaintImage = 140;

  //==================================
  // AVATAR
  //==================================

  static const double avatarSmall = 40;
  static const double avatarMedium = 60;
  static const double avatarLarge = 90;

  //==================================
  // MAP
  //==================================

  static const double mapHeight = 250;

  //==================================
  // DIALOG
  //==================================

  static const double dialogRadius = 24;

  //==================================
  // ANIMATION
  //==================================

  static const Duration fastAnimation =
      Duration(milliseconds: 200);

  static const Duration normalAnimation =
      Duration(milliseconds: 300);

  static const Duration slowAnimation =
      Duration(milliseconds: 500);

  //==================================
  // SHADOW
  //==================================

  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 18,
      spreadRadius: 1,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ];
}