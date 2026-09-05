import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../home/home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  bool loading = false;
  bool obscurePassword = true;
  bool biometricEnabled = false;

  // ------------------------------------------------------------
  // Colors
  // ------------------------------------------------------------

  static const Color primary = Color(0xFF00695C);
  static const Color primaryDark = Color(0xFF004D40);
  static const Color background = Color(0xFFF6FAF9);
  static const Color fieldBackground = Color(0xFFF0F3F4);
  static const Color borderColor = Color(0xFFCBD5D3);
  static const Color textColor = Color(0xFF263533);
  static const Color secondaryText = Color(0xFF687674);

  // ------------------------------------------------------------
  // Login
  // ------------------------------------------------------------

  Future<void> login() async {
    FocusScope.of(context).unfocus();

    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty) {
      _showMessage('Please enter your email address.');
      emailFocus.requestFocus();
      return;
    }

    if (!_isValidEmail(email)) {
      _showMessage('Please enter a valid email address.');
      emailFocus.requestFocus();
      return;
    }

    if (password.isEmpty) {
      _showMessage('Please enter your password.');
      passwordFocus.requestFocus();
      return;
    }

    if (mounted) {
      setState(() => loading = true);
    }

    try {
      final UserCredential credential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = credential.user;

      if (user == null) {
        _showMessage('Unable to complete login.');
        return;
      }

      await user.reload();

      final User? currentUser = _auth.currentUser;

      if (currentUser != null && currentUser.emailVerified) {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      } else {
        await _auth.signOut();

        if (!mounted) return;

        _showMessage(
          'Please verify your email before logging in.',
        );
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message = 'Login failed. Please try again.';

      switch (e.code) {
        case 'user-not-found':
          message = 'No account found with this email.';
          break;

        case 'wrong-password':
          message = 'Incorrect password.';
          break;

        case 'invalid-email':
          message = 'Please enter a valid email address.';
          break;

        case 'invalid-credential':
          message = 'Invalid email or password.';
          break;

        case 'user-disabled':
          message = 'This account has been disabled.';
          break;

        case 'too-many-requests':
          message =
              'Too many attempts. Please try again later.';
          break;

        case 'network-request-failed':
          message =
              'Network error. Please check your internet connection.';
          break;
      }

      _showMessage(message);
    } catch (_) {
      if (!mounted) return;

      _showMessage(
        'Something went wrong. Please try again.',
      );
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  // ------------------------------------------------------------
  // Forgot Password
  // ------------------------------------------------------------

  Future<void> resetPassword() async {
    FocusScope.of(context).unfocus();

    final email = emailController.text.trim();

    if (email.isEmpty) {
      _showMessage('Enter your email address first.');
      emailFocus.requestFocus();
      return;
    }

    if (!_isValidEmail(email)) {
      _showMessage('Please enter a valid email address.');
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );

      if (!mounted) return;

      _showMessage(
        'Password reset email sent.',
        success: true,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message = 'Unable to send reset email.';

      switch (e.code) {
        case 'user-not-found':
          message = 'No account found with this email.';
          break;

        case 'invalid-email':
          message = 'Invalid email address.';
          break;
      }

      _showMessage(message);
    }
  }

  // ------------------------------------------------------------
  // Validation
  // ------------------------------------------------------------

  bool _isValidEmail(String email) {
    return RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    ).hasMatch(email);
  }

  // ------------------------------------------------------------
  // Message
  // ------------------------------------------------------------

  void _showMessage(
    String message, {
    bool success = false,
  }) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          backgroundColor:
              success ? primary : const Color(0xFF263238),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          content: Row(
            children: [
              Icon(
                success
                    ? Icons.check_circle_outline
                    : Icons.info_outline,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  // ------------------------------------------------------------
  // Navigate Signup
  // ------------------------------------------------------------

  void openSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SignupScreen(),
      ),
    );
  }

  // ------------------------------------------------------------
  // Dispose
  // ------------------------------------------------------------

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    emailFocus.dispose();
    passwordFocus.dispose();

    super.dispose();
  }

  // ------------------------------------------------------------
  // Build
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 24,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 48,
                ),
                child: Column(
                  children: [
                    _buildHeader(),

                    const SizedBox(height: 30),

                    _buildLoginCard(),

                    const SizedBox(height: 26),

                    _buildSignupFooter(),

                    const SizedBox(height: 20),

                    _buildFooter(),

                    SizedBox(
                      height: mediaQuery.viewInsets.bottom > 0
                          ? 20
                          : 10,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Header
  // ------------------------------------------------------------

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 108,
          height: 108,
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: primary.withOpacity(0.18),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Image.asset(
            AppImages.appIcon,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) {
              return const Icon(
                Icons.account_balance,
                size: 52,
                color: Colors.white,
              );
            },
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          'Namma Kanyakumari',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.6,
            color: primaryDark,
          ),
        ),

        const SizedBox(height: 6),

        const Text(
          'Your Voice. Your District.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
            color: secondaryText,
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Login Card
  // ------------------------------------------------------------

  Widget _buildLoginCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        28,
        30,
        28,
        28,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFE1E8E6),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.055),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome Back',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Sign in to your citizen account to access\n'
            'services and reports.',
            style: TextStyle(
              fontSize: 16,
              height: 1.55,
              color: secondaryText,
            ),
          ),

          const SizedBox(height: 30),

          _buildLabel('Email Address'),

          const SizedBox(height: 9),

          _buildEmailField(),

          const SizedBox(height: 22),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              GestureDetector(
                onTap: resetPassword,
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: primaryDark,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 9),

          _buildPasswordField(),

          const SizedBox(height: 20),

          _buildBiometricRow(),

          const SizedBox(height: 24),

          _buildLoginButton(),

          const SizedBox(height: 26),

          _buildDivider(),

          const SizedBox(height: 18),

          _buildSocialButtons(),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Label
  // ------------------------------------------------------------

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }

  // ------------------------------------------------------------
  // Email
  // ------------------------------------------------------------

  Widget _buildEmailField() {
    return TextField(
      controller: emailController,
      focusNode: emailFocus,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onSubmitted: (_) {
        passwordFocus.requestFocus();
      },
      style: const TextStyle(
        fontSize: 16,
        color: textColor,
      ),
      decoration: InputDecoration(
        hintText: 'Enter your registered email',
        hintStyle: const TextStyle(
          color: Color(0xFF7D8887),
        ),
        prefixIcon: const Icon(
          Icons.person_outline_rounded,
          color: Color(0xFF74807E),
          size: 25,
        ),
        filled: true,
        fillColor: fieldBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 19,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: borderColor,
            width: 1.3,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: primary,
            width: 2,
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Password
  // ------------------------------------------------------------

  Widget _buildPasswordField() {
    return TextField(
      controller: passwordController,
      focusNode: passwordFocus,
      obscureText: obscurePassword,
      textInputAction: TextInputAction.done,
      onSubmitted: (_) {
        if (!loading) {
          login();
        }
      },
      style: const TextStyle(
        fontSize: 16,
        color: textColor,
      ),
      decoration: InputDecoration(
        hintText: 'Enter your password',
        hintStyle: const TextStyle(
          color: Color(0xFF7D8887),
        ),
        prefixIcon: const Icon(
          Icons.lock_outline_rounded,
          color: Color(0xFF74807E),
          size: 24,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscurePassword = !obscurePassword;
            });
          },
          icon: Icon(
            obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: const Color(0xFF74807E),
          ),
        ),
        filled: true,
        fillColor: fieldBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 19,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: borderColor,
            width: 1.3,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: primary,
            width: 2,
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Biometric
  // ------------------------------------------------------------

  Widget _buildBiometricRow() {
    return Row(
      children: [
        const Icon(
          Icons.fingerprint_rounded,
          size: 34,
          color: primary,
        ),

        const SizedBox(width: 12),

        const Expanded(
          child: Text(
            'Biometric Login',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),

        Switch.adaptive(
          value: biometricEnabled,
          activeColor: primary,
          onChanged: (value) {
            setState(() {
              biometricEnabled = value;
            });
          },
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Login Button
  // ------------------------------------------------------------

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: loading ? null : login,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          disabledBackgroundColor:
              primary.withOpacity(0.65),
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: primary.withOpacity(0.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: loading
              ? const SizedBox(
                  key: ValueKey('loading'),
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
              : const Row(
                  key: ValueKey('login'),
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 14),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 25,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Divider
  // ------------------------------------------------------------

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Color(0xFFD9E0DE),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          child: Text(
            'OR LOGIN WITH',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
              color: Colors.grey.shade600,
            ),
          ),
        ),

        const Expanded(
          child: Divider(
            color: Color(0xFFD9E0DE),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Social Buttons
  // ------------------------------------------------------------

  Widget _buildSocialButtons() {
    return Row(
      children: [
        Expanded(
          child: _socialButton(
            image: AppImages.google,
            label: 'Google',
            onTap: () {
              _showMessage(
                'Google Sign-In will be connected next.',
              );
            },
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: _socialButton(
            image: AppImages.apple,
            label: 'Apple',
            onTap: () {
              _showMessage(
                'Apple Sign-In will be connected next.',
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _socialButton({
    required String image,
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 54,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          side: const BorderSide(
            color: borderColor,
            width: 1.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 22,
              height: 22,
              errorBuilder: (_, __, ___) {
                return Icon(
                  label == 'Google'
                      ? Icons.g_mobiledata
                      : Icons.apple,
                  size: 25,
                );
              },
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Signup Footer
  // ------------------------------------------------------------

  Widget _buildSignupFooter() {
    return GestureDetector(
      onTap: openSignup,
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: TextStyle(
            fontSize: 16,
            color: secondaryText,
          ),
          children: [
            TextSpan(
              text: "Don't have an account? ",
            ),
            TextSpan(
              text: 'Sign Up Now',
              style: TextStyle(
                color: primaryDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Footer
  // ------------------------------------------------------------

  Widget _buildFooter() {
    return Column(
      children: [
        const Text(
          'A smarter district starts with you.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: secondaryText,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          'Namma Kanyakumari • Citizen Services',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}