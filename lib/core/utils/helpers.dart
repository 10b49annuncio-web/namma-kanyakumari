import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Helpers {
  Helpers._();

  //==================================================
  // Keyboard
  //==================================================

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  //==================================================
  // Snackbar
  //==================================================

  static void showSnackBar(
    BuildContext context,
    String message, {
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
      ),
    );
  }

  //==================================================
  // Loading Dialog
  //==================================================

  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  //==================================================
  // Date Formatting
  //==================================================

  static String formatDate(DateTime date) {
    return DateFormat("dd MMM yyyy").format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat("dd MMM yyyy, hh:mm a").format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat("hh:mm a").format(date);
  }

  //==================================================
  // Clipboard
  //==================================================

  static Future<void> copyToClipboard(
    BuildContext context,
    String text,
  ) async {
    await Clipboard.setData(
      ClipboardData(text: text),
    );

    showSnackBar(
      context,
      "Copied to clipboard",
    );
  }

  //==================================================
  // Phone Call
  //==================================================

  static Future<void> call(String phoneNumber) async {
    final Uri uri = Uri.parse("tel:$phoneNumber");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  //==================================================
  // SMS
  //==================================================

  static Future<void> sendSMS(String phone) async {
    final Uri uri = Uri.parse("sms:$phone");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  //==================================================
  // Email
  //==================================================

  static Future<void> sendEmail(
    String email,
    String subject,
  ) async {
    final Uri uri = Uri(
      scheme: "mailto",
      path: email,
      queryParameters: {
        "subject": subject,
      },
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  //==================================================
  // Browser
  //==================================================

  static Future<void> openWebsite(
    String url,
  ) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  //==================================================
  // Google Maps
  //==================================================

  static Future<void> openMap(
    double latitude,
    double longitude,
  ) async {
    final Uri uri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude",
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  //==================================================
  // Share Text
  //==================================================

  static Future<void> share(String text) async {
    await Share.share(text);
  }

  //==================================================
  // Delay
  //==================================================

  static Future<void> delay(int milliseconds) async {
    await Future.delayed(
      Duration(milliseconds: milliseconds),
    );
  }

  //==================================================
  // Confirmation Dialog
  //==================================================

  static Future<bool?> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}