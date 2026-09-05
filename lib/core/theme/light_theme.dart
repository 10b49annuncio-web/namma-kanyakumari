import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class LightTheme {
  LightTheme._();

  static ThemeData theme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.light,

    primaryColor: AppColors.primary,

    scaffoldBackgroundColor: AppColors.background,

    fontFamily: 'Poppins',

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.white,
      error: AppColors.error,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.textPrimary,
      onError: AppColors.white,
    ),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.primary,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
    ),

    cardTheme: CardThemeData(
      color: AppColors.card,
      elevation: AppSizes.cardElevation,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        minimumSize: const Size(
          double.infinity,
          AppSizes.buttonHeight,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.buttonRadius,
          ),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(
          color: AppColors.primary,
        ),
        minimumSize: const Size(
          double.infinity,
          AppSizes.buttonHeight,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.buttonRadius,
          ),
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputFill,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppSizes.textFieldRadius,
        ),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppSizes.textFieldRadius,
        ),
        borderSide: const BorderSide(
          color: AppColors.inputBorder,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppSizes.textFieldRadius,
        ),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 2,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppSizes.textFieldRadius,
        ),
        borderSide: const BorderSide(
          color: AppColors.error,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppSizes.textFieldRadius,
        ),
        borderSide: const BorderSide(
          color: AppColors.error,
          width: 2,
        ),
      ),

      hintStyle: const TextStyle(
        color: AppColors.hint,
        fontSize: 15,
      ),
    ),

    iconTheme: const IconThemeData(
      color: AppColors.icon,
      size: AppSizes.iconMD,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 2,
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),

    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.primary,
      contentTextStyle: const TextStyle(
        color: AppColors.white,
        fontSize: 15,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return Colors.white;
        },
      ),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(
        AppColors.primary,
      ),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(
        AppColors.primary,
      ),
      trackColor: WidgetStateProperty.all(
        AppColors.primary.withOpacity(0.3),
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
      elevation: 10,
      type: BottomNavigationBarType.fixed,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.white,
      indicatorColor: AppColors.primary.withOpacity(.12),
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}