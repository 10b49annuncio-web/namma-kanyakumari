import 'package:flutter/services.dart';

class Validators {
  Validators._();

  //========================================
  // Required Field
  //========================================

  static String? requiredField(
    String? value, {
    String fieldName = "This field",
  }) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  //========================================
  // Name Validation
  //========================================

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }

    if (value.trim().length < 3) {
      return "Name must be at least 3 characters";
    }

    return null;
  }

  //========================================
  // Email Validation
  //========================================

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return "Enter a valid email address";
    }

    return null;
  }

  //========================================
  // Phone Validation
  //========================================

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }

    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value.trim())) {
      return "Enter a valid 10-digit mobile number";
    }

    return null;
  }

  //========================================
  // Password Validation
  //========================================

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Include at least one uppercase letter";
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Include at least one lowercase letter";
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Include at least one number";
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Include at least one special character";
    }

    return null;
  }

  //========================================
  // Confirm Password
  //========================================

  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Confirm password is required";
    }

    if (password != confirmPassword) {
      return "Passwords do not match";
    }

    return null;
  }

  //========================================
  // Complaint Description
  //========================================

  static String? validateComplaint(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Complaint description is required";
    }

    if (value.trim().length < 15) {
      return "Please provide more details";
    }

    return null;
  }

  //========================================
  // OTP
  //========================================

  static String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return "OTP is required";
    }

    if (value.length != 6) {
      return "OTP must be 6 digits";
    }

    return null;
  }

  //========================================
  // PIN Code
  //========================================

  static String? validatePincode(String? value) {
    if (value == null || value.isEmpty) {
      return "PIN code is required";
    }

    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return "Enter a valid PIN code";
    }

    return null;
  }

  //========================================
  // Aadhaar Number
  //========================================

  static String? validateAadhaar(String? value) {
    if (value == null || value.isEmpty) {
      return "Aadhaar number is required";
    }

    if (!RegExp(r'^\d{12}$').hasMatch(value)) {
      return "Enter a valid 12-digit Aadhaar number";
    }

    return null;
  }

  //========================================
  // URL
  //========================================

  static String? validateUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final urlRegex = RegExp(
      r'^(http|https):\/\/([\w-]+\.)+[\w-]+(\/[\w\-\.\/?%&=]*)?$',
    );

    if (!urlRegex.hasMatch(value.trim())) {
      return "Enter a valid URL";
    }

    return null;
  }

  //========================================
  // Input Formatters
  //========================================

  static final phoneFormatter = <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(10),
  ];

  static final otpFormatter = <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(6),
  ];

  static final aadhaarFormatter = <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(12),
  ];

  static final pinCodeFormatter = <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(6),
  ];
}