import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import 'login_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends State<EmailVerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;
  bool isResending = false;
  Timer? _autoCheckTimer;

  @override
  void initState() {
    super.initState();

    // Poll in the background so the user is taken to Home automatically
    // as soon as they tap the link in their inbox, without needing to
    // come back and press the button themselves.
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

  Future<void> checkVerification({
    bool showResultMessage = true,
  }) async {
    if (isLoading) return;

    if (mounted) {
      setState(() => isLoading = true);
    }

    try {
      await _auth.currentUser?.reload();

      final User? user = _auth.currentUser;

      if (user != null && user.emailVerified) {
        _autoCheckTimer?.cancel();

        // Reflect the verified status in Firestore too.
        await _firestore
            .collection('users')
            .doc(user.uid)
            .update({'isVerified': true});

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email verified successfully.'),
          ),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
          (route) => false,
        );

        return;
      }

      if (showResultMessage && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email is not verified yet.'),
          ),
        );
      }
    } catch (e) {
      if (showResultMessage && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> resendEmail() async {
    if (isResending) return;

    setState(() => isResending = true);

    try {
      await _auth.currentUser?.sendEmailVerification();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification email sent again.'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() => isResending = false);
      }
    }
  }

  Future<void> _backToLogin() async {
    await _auth.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final email = _auth.currentUser?.email ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.mark_email_read,
              size: 100,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            const Text(
              'Verify Your Email',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              'A verification link has been sent to:\n\n$email',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : checkVerification,
                child: isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : const Text("I've Verified My Email"),
              ),
            ),

            const SizedBox(height: 15),

            TextButton(
              onPressed: isResending ? null : resendEmail,
              child: Text(
                isResending
                    ? 'Sending...'
                    : 'Resend Verification Email',
              ),
            ),

            TextButton(
              onPressed: _backToLogin,
              child: const Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}