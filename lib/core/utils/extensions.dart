import 'package:flutter/material.dart';

///==========================================================
/// BuildContext Extensions
///==========================================================

extension ContextExtensions on BuildContext {
  // Screen Size
  Size get screenSize => MediaQuery.of(this).size;

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  // Keyboard
  bool get isKeyboardOpen =>
      MediaQuery.of(this).viewInsets.bottom > 0;

  // Theme
  ThemeData get theme => Theme.of(this);

  ColorScheme get colors => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  // Dark Mode
  bool get isDarkMode =>
      Theme.of(this).brightness == Brightness.dark;

  // Navigation

  void push(Widget page) {
    Navigator.push(
      this,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void pushReplacement(Widget page) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void pop() {
    Navigator.pop(this);
  }

  // Snackbar

  void showSnackBar(
    String message, {
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  // Dialog

  Future<void> showLoadingDialog() async {
    return showDialog(
      context: this,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void hideDialog() {
    Navigator.of(this, rootNavigator: true).pop();
  }
}

///==========================================================
/// String Extensions
///==========================================================

extension StringExtensions on String {
  bool get isEmail {
    return RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(this);
  }

  bool get isPhone {
    return RegExp(r'^[6-9]\d{9}$').hasMatch(this);
  }

  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  String get capitalize {
    if (isEmpty) return this;

    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String get titleCase {
    return split(" ")
        .map((e) => e.capitalize)
        .join(" ");
  }
}

///==========================================================
/// DateTime Extensions
///==========================================================

extension DateExtensions on DateTime {
  String get ddMMyyyy {
    return "${day.toString().padLeft(2, '0')}/"
        "${month.toString().padLeft(2, '0')}/"
        "$year";
  }

  String get time {
    final hour12 = hour > 12 ? hour - 12 : hour;
    final period = hour >= 12 ? "PM" : "AM";

    return "${hour12.toString().padLeft(2, '0')}:"
        "${minute.toString().padLeft(2, '0')} $period";
  }
}

///==========================================================
/// Padding Extensions
///==========================================================

extension PaddingExtensions on num {
  SizedBox get hSpace => SizedBox(height: toDouble());

  SizedBox get wSpace => SizedBox(width: toDouble());

  EdgeInsets get all => EdgeInsets.all(toDouble());

  EdgeInsets get horizontal =>
      EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get vertical =>
      EdgeInsets.symmetric(vertical: toDouble());
}

///==========================================================
/// Widget Extensions
///==========================================================

extension WidgetExtensions on Widget {
  Widget center() {
    return Center(child: this);
  }

  Widget expanded({int flex = 1}) {
    return Expanded(
      flex: flex,
      child: this,
    );
  }

  Widget paddingAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Widget paddingSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      child: this,
    );
  }

  Widget rounded(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: this,
    );
  }
}