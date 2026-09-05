import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;

  const EmailVerificationScreen({
    super.key,
    required this.email,
  });

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends State<EmailVerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  bool checking = false;
  bool sending = false;

  Timer? _autoCheckTimer;

  @override
  void initState() {
    super.initState();

    // Poll in the background so the user lands on the next screen
    // automatically as soon as they tap the link in their inbox,
    // without needing to come back and press the button themselves.
    _autoCheckTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => checkVerification(showResultMessage: false),
    );
  }

  @override
  void dispose() {
    _autoCheckTimer?.cancel();
    super.dispose();
  }

  // ----------------------------------------------------------
  // CHECK VERIFICATION
  // ----------------------------------------------------------

  Future<void> checkVerification({
    bool showResultMessage = true,
  }) async {
    if (checking) return;

    setState(() {
      checking = true;
    });

    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        if (showResultMessage) {
          showMessage("Session expired. Please login again.");
        }
        return;
      }

      // Refresh Firebase Auth user
      await user.reload();

      final User? updatedUser = _auth.currentUser;

      if (updatedUser != null && updatedUser.emailVerified) {
        _autoCheckTimer?.cancel();

        // Update Firestore
        await _firestore
            .collection("users")
            .doc(updatedUser.uid)
            .update({
          "isVerified": true,
          "updatedAt": FieldValue.serverTimestamp(),
        });

        if (!mounted) return;

        // Sign out after verification
        await _auth.signOut();

        if (!mounted) return;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
          (route) => false,
        );

        showMessage("Email verified successfully. Please login.");
      } else if (showResultMessage) {
        showMessage(
          "Email is not verified yet. Please check your inbox.",
        );
      }
    } catch (e) {
      if (showResultMessage) {
        showMessage("Unable to check verification status.");
      }
    } finally {
      if (mounted) {
        setState(() {
          checking = false;
        });
      }
    }
  }

  // ----------------------------------------------------------
  // RESEND EMAIL
  // ----------------------------------------------------------

  Future<void> resendVerificationEmail() async {
    setState(() {
      sending = true;
    });

    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        showMessage("Session expired. Please signup again.");
        return;
      }

      await user.sendEmailVerification();

      showMessage(
        "Verification email sent again.",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "too-many-requests") {
        showMessage(
          "Too many requests. Please wait before trying again.",
        );
      } else {
        showMessage(
          e.message ?? "Unable to send verification email.",
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          sending = false;
        });
      }
    }
  }

  // ----------------------------------------------------------
  // MESSAGE
  // ----------------------------------------------------------

  void showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // BUILD
  // ----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF9),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // ------------------------------------------------
                // ICON
                // ------------------------------------------------

                Container(
                  width: 105,
                  height: 105,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5F5F2),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00796B)
                            .withOpacity(0.10),
                        blurRadius: 25,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.mark_email_read_outlined,
                    size: 52,
                    color: Color(0xFF00796B),
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Verify Your Email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF005F56),
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "We've sent a verification link to",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF667474),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  widget.email,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF00796B),
                  ),
                ),

                const SizedBox(height: 30),

                // ------------------------------------------------
                // CARD
                // ------------------------------------------------

                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xFFE1E8E7),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Open your email and click the verification link. "
                        "After verification, return here and tap the button below.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: Color(0xFF667474),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // CHECK BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed:
                              checking ? null : checkVerification,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF00796B),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(16),
                            ),
                          ),
                          child: checking
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child:
                                      CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text(
                                  "I've Verified My Email",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // RESEND
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: sending
                              ? null
                              : resendVerificationEmail,
                          style: OutlinedButton.styleFrom(
                            foregroundColor:
                                const Color(0xFF00796B),
                            side: const BorderSide(
                              color: Color(0xFF00796B),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(16),
                            ),
                          ),
                          child: sending
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child:
                                      CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "Resend Verification Email",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // LOGIN
                TextButton(
                  onPressed: () async {
                    await _auth.signOut();

                    if (!mounted) return;

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Back to Login",
                    style: TextStyle(
                      color: Color(0xFF00796B),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}