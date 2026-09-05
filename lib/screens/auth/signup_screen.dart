import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_images.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool acceptedTerms = false;

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
  // Signup
  // ------------------------------------------------------------

  Future<void> signUp() async {
    FocusScope.of(context).unfocus();

    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String phone = phoneController.text.trim();
    final String password = passwordController.text;
    final String confirmPassword =
        confirmPasswordController.text;

    // ----------------------------------------------------------
    // Validation
    // ----------------------------------------------------------

    if (name.isEmpty) {
      _showMessage('Please enter your full name.');
      nameFocus.requestFocus();
      return;
    }

    if (name.length < 3) {
      _showMessage('Please enter a valid name.');
      nameFocus.requestFocus();
      return;
    }

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

    if (phone.isEmpty) {
      _showMessage('Please enter your phone number.');
      phoneFocus.requestFocus();
      return;
    }

    if (!_isValidPhone(phone)) {
      _showMessage(
        'Please enter a valid 10-digit phone number.',
      );
      phoneFocus.requestFocus();
      return;
    }

    if (password.isEmpty) {
      _showMessage('Please create a password.');
      passwordFocus.requestFocus();
      return;
    }

    if (password.length < 6) {
      _showMessage(
        'Password must contain at least 6 characters.',
      );
      passwordFocus.requestFocus();
      return;
    }

    if (password != confirmPassword) {
      _showMessage('Passwords do not match.');
      confirmPasswordFocus.requestFocus();
      return;
    }

    if (!acceptedTerms) {
      _showMessage(
        'Please accept the Terms & Privacy Policy.',
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // --------------------------------------------------------
      // Create Firebase account
      // --------------------------------------------------------

      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user == null) {
        _showMessage(
          'Unable to create your account.',
        );
        return;
      }

      // --------------------------------------------------------
      // Update Firebase display name
      // --------------------------------------------------------

      await user.updateDisplayName(name);

      // --------------------------------------------------------
      // Send verification email
      // --------------------------------------------------------

      await user.sendEmailVerification();

      // --------------------------------------------------------
      // Save user in Firestore
      // --------------------------------------------------------

      await _firestore
          .collection('users')
          .doc(user.uid)
          .set({
        'uid': user.uid,
        'name': name,
        'email': email,
        'phone': phone,
        'role': 'user',
        'isVerified': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // --------------------------------------------------------
      // Sign out until email is verified
      // --------------------------------------------------------

      await _auth.signOut();

      if (!mounted) return;

      await _showVerificationDialog(email);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message =
          'Unable to create your account.';

      switch (e.code) {
        case 'email-already-in-use':
          message =
              'An account already exists with this email.';
          break;

        case 'invalid-email':
          message =
              'Please enter a valid email address.';
          break;

        case 'weak-password':
          message =
              'Your password is too weak.';
          break;

        case 'operation-not-allowed':
          message =
              'Email/password authentication is disabled.';
          break;

        case 'network-request-failed':
          message =
              'Network error. Check your internet connection.';
          break;

        case 'too-many-requests':
          message =
              'Too many attempts. Please try again later.';
          break;

        default:
          message = e.message ??
              'Unable to create your account.';
      }

      _showMessage(message);
    } catch (_) {
      if (!mounted) return;

      _showMessage(
        'Something went wrong. Please try again.',
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  // ------------------------------------------------------------
  // Email validation
  // ------------------------------------------------------------

  bool _isValidEmail(String email) {
    return RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    ).hasMatch(email);
  }

  // ------------------------------------------------------------
  // Phone validation
  // ------------------------------------------------------------

  bool _isValidPhone(String phone) {
    final cleaned = phone.replaceAll(
      RegExp(r'\D'),
      '',
    );

    return cleaned.length == 10;
  }

  // ------------------------------------------------------------
  // Verification dialog
  // ------------------------------------------------------------

  Future<void> _showVerificationDialog(
    String email,
  ) async {
    if (!mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.mark_email_read_outlined,
                    size: 38,
                    color: primary,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Verify Your Email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'We sent a verification link to:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  email,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: primaryDark,
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  'Please verify your email before logging in.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: secondaryText,
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      'Continue to Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ------------------------------------------------------------
  // Message
  // ------------------------------------------------------------

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          backgroundColor: const Color(0xFF263238),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          content: Row(
            children: [
              const Icon(
                Icons.info_outline,
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
  // Build
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
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
                vertical: 20,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 40,
                ),
                child: Column(
                  children: [
                    _buildTopBar(),

                    const SizedBox(height: 20),

                    _buildHeader(),

                    const SizedBox(height: 28),

                    _buildSignupCard(),

                    const SizedBox(height: 24),

                    _buildLoginFooter(),

                    const SizedBox(height: 16),

                    _buildFooter(),
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
  // Top bar
  // ------------------------------------------------------------

  Widget _buildTopBar() {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFE0E7E5),
            ),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 19,
              color: textColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Header
  // ------------------------------------------------------------

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 82,
          height: 82,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: primary.withOpacity(0.16),
                blurRadius: 20,
                offset: const Offset(0, 9),
              ),
            ],
          ),
          child: Image.asset(
            AppImages.appIcon,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) {
              return const Icon(
                Icons.account_balance,
                size: 40,
                color: Colors.white,
              );
            },
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'Create Your Account',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: primaryDark,
          ),
        ),

        const SizedBox(height: 7),

        const Text(
          'Join Namma Kanyakumari and connect\n'
          'with your district.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            height: 1.5,
            color: secondaryText,
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Signup card
  // ------------------------------------------------------------

  Widget _buildSignupCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        24,
        26,
        24,
        26,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFE1E8E6),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 28,
            offset: const Offset(0, 13),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Full Name'),

          const SizedBox(height: 8),

          _buildTextField(
            controller: nameController,
            focusNode: nameFocus,
            hint: 'Enter your full name',
            icon: Icons.person_outline_rounded,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) {
              emailFocus.requestFocus();
            },
          ),

          const SizedBox(height: 18),

          _buildLabel('Email Address'),

          const SizedBox(height: 8),

          _buildTextField(
            controller: emailController,
            focusNode: emailFocus,
            hint: 'Enter your email address',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) {
              phoneFocus.requestFocus();
            },
          ),

          const SizedBox(height: 18),

          _buildLabel('Mobile Number'),

          const SizedBox(height: 8),

          _buildTextField(
            controller: phoneController,
            focusNode: phoneFocus,
            hint: 'Enter your 10-digit number',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            prefixText: '+91 ',
            onSubmitted: (_) {
              passwordFocus.requestFocus();
            },
          ),

          const SizedBox(height: 18),

          _buildLabel('Password'),

          const SizedBox(height: 8),

          _buildPasswordField(
            controller: passwordController,
            focusNode: passwordFocus,
            hint: 'Create a password',
            obscure: obscurePassword,
            onToggle: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
            onChanged: (_) {
              setState(() {});
            },
            onSubmitted: (_) {
              confirmPasswordFocus.requestFocus();
            },
          ),

          const SizedBox(height: 8),

          _buildPasswordStrength(),

          const SizedBox(height: 18),

          _buildLabel('Confirm Password'),

          const SizedBox(height: 8),

          _buildPasswordField(
            controller: confirmPasswordController,
            focusNode: confirmPasswordFocus,
            hint: 'Re-enter your password',
            obscure: obscureConfirmPassword,
            onToggle: () {
              setState(() {
                obscureConfirmPassword =
                    !obscureConfirmPassword;
              });
            },
            onSubmitted: (_) {
              if (!isLoading) {
                signUp();
              }
            },
          ),

          const SizedBox(height: 20),

          _buildTerms(),

          const SizedBox(height: 22),

          _buildCreateAccountButton(),
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
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }

  // ------------------------------------------------------------
  // Text field
  // ------------------------------------------------------------

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    required IconData icon,
    required TextInputType keyboardType,
    required TextInputAction textInputAction,
    String? prefixText,
    void Function(String)? onSubmitted,
  }) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      style: const TextStyle(
        fontSize: 15,
        color: textColor,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xFF7D8887),
        ),
        prefixText: prefixText,
        prefixStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: primaryDark,
        ),
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF74807E),
          size: 23,
        ),
        filled: true,
        fillColor: fieldBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 17,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: borderColor,
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: primary,
            width: 2,
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Password field
  // ------------------------------------------------------------

  Widget _buildPasswordField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    required bool obscure,
    required VoidCallback onToggle,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
  }) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscure,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
        fontSize: 15,
        color: textColor,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xFF7D8887),
        ),
        prefixIcon: const Icon(
          Icons.lock_outline_rounded,
          color: Color(0xFF74807E),
          size: 23,
        ),
        suffixIcon: IconButton(
          onPressed: onToggle,
          icon: Icon(
            obscure
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: const Color(0xFF74807E),
          ),
        ),
        filled: true,
        fillColor: fieldBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 17,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: borderColor,
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: primary,
            width: 2,
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Password strength
  // ------------------------------------------------------------

  Widget _buildPasswordStrength() {
    final password = passwordController.text;

    if (password.isEmpty) {
      return const SizedBox.shrink();
    }

    int strength = 0;

    if (password.length >= 6) strength++;
    if (password.contains(RegExp(r'[A-Z]'))) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;
    if (password.contains(
      RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
    )) {
      strength++;
    }

    String text;

    if (strength <= 1) {
      text = 'Weak password';
    } else if (strength == 2) {
      text = 'Medium password';
    } else if (strength == 3) {
      text = 'Good password';
    } else {
      text = 'Strong password';
    }

    return Row(
      children: [
        Expanded(
          child: Row(
            children: List.generate(
              4,
              (index) {
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(
                      right: index == 3 ? 0 : 4,
                    ),
                    decoration: BoxDecoration(
                      color: index < strength
                          ? primary
                          : const Color(0xFFDCE3E1),
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(width: 10),

        Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: strength <= 1
                ? Colors.red.shade600
                : primary,
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Terms
  // ------------------------------------------------------------

  Widget _buildTerms() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 22,
          height: 22,
          child: Checkbox(
            value: acceptedTerms,
            activeColor: primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onChanged: (value) {
              setState(() {
                acceptedTerms = value ?? false;
              });
            },
          ),
        ),

        const SizedBox(width: 10),

        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 1),
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: secondaryText,
                ),
                children: [
                  TextSpan(
                    text: 'I agree to the ',
                  ),
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryDark,
                    ),
                  ),
                  TextSpan(
                    text: ' and ',
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryDark,
                    ),
                  ),
                  TextSpan(
                    text: '.',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Create Account Button
  // ------------------------------------------------------------

  Widget _buildCreateAccountButton() {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: isLoading ? null : signUp,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          disabledBackgroundColor:
              primary.withOpacity(0.6),
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: primary.withOpacity(0.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isLoading
              ? const SizedBox(
                  key: ValueKey('loading'),
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : const Row(
                  key: ValueKey('create'),
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 24,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Login footer
  // ------------------------------------------------------------

  Widget _buildLoginFooter() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: TextStyle(
            fontSize: 15,
            color: secondaryText,
          ),
          children: [
            TextSpan(
              text: 'Already have an account? ',
            ),
            TextSpan(
              text: 'Login',
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
    return const Column(
      children: [
        Text(
          'A smarter district starts with you.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: secondaryText,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Namma Kanyakumari • Citizen Services',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: Color(0xFF9AA5A3),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Dispose
  // ------------------------------------------------------------

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    nameFocus.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();

    super.dispose();
  }
}