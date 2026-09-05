import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  /// Enable or disable logging globally.
  static const bool enableLogs = kDebugMode;

  //==================================================
  // DEBUG
  //==================================================

  static void debug(
    String message, {
    String tag = "DEBUG",
  }) {
    if (!enableLogs) return;

    developer.log(
      message,
      name: tag,
    );
  }

  //==================================================
  // INFO
  //==================================================

  static void info(
    String message, {
    String tag = "INFO",
  }) {
    if (!enableLogs) return;

    developer.log(
      "ℹ️ $message",
      name: tag,
    );
  }

  //==================================================
  // WARNING
  //==================================================

  static void warning(
    String message, {
    String tag = "WARNING",
  }) {
    if (!enableLogs) return;

    developer.log(
      "⚠️ $message",
      name: tag,
    );
  }

  //==================================================
  // ERROR
  //==================================================

  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String tag = "ERROR",
  }) {
    if (!enableLogs) return;

    developer.log(
      "❌ $message",
      name: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  //==================================================
  // SUCCESS
  //==================================================

  static void success(
    String message, {
    String tag = "SUCCESS",
  }) {
    if (!enableLogs) return;

    developer.log(
      "✅ $message",
      name: tag,
    );
  }

  //==================================================
  // NETWORK
  //==================================================

  static void network(
    String message, {
    String tag = "NETWORK",
  }) {
    if (!enableLogs) return;

    developer.log(
      "🌐 $message",
      name: tag,
    );
  }

  //==================================================
  // FIREBASE
  //==================================================

  static void firebase(
    String message, {
    String tag = "FIREBASE",
  }) {
    if (!enableLogs) return;

    developer.log(
      "🔥 $message",
      name: tag,
    );
  }

  //==================================================
  // AUTH
  //==================================================

  static void auth(
    String message, {
    String tag = "AUTH",
  }) {
    if (!enableLogs) return;

    developer.log(
      "🔐 $message",
      name: tag,
    );
  }

  //==================================================
  // API
  //==================================================

  static void api(
    String message, {
    String tag = "API",
  }) {
    if (!enableLogs) return;

    developer.log(
      "📡 $message",
      name: tag,
    );
  }

  //==================================================
  // AI
  //==================================================

  static void ai(
    String message, {
    String tag = "AI",
  }) {
    if (!enableLogs) return;

    developer.log(
      "🤖 $message",
      name: tag,
    );
  }

  //==================================================
  // LOCATION
  //==================================================

  static void location(
    String message, {
    String tag = "LOCATION",
  }) {
    if (!enableLogs) return;

    developer.log(
      "📍 $message",
      name: tag,
    );
  }

  //==================================================
  // JSON
  //==================================================

  static void json(
    Object json, {
    String tag = "JSON",
  }) {
    if (!enableLogs) return;

    developer.log(
      json.toString(),
      name: tag,
    );
  }
}