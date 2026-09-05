import 'package:flutter/material.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

/// Central theme configuration for the application.
///
/// Usage:
/// ```dart
/// MaterialApp(
///   theme: AppTheme.lightTheme,
///   darkTheme: AppTheme.darkTheme,
///   themeMode: ThemeMode.system,
/// )
/// ```
class AppTheme {
  AppTheme._();

  /// Light Theme
  static ThemeData get lightTheme => LightTheme.theme;

  /// Dark Theme
  static ThemeData get darkTheme => DarkTheme.theme;
}