import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _villageController = TextEditingController(text: 'Nagercoil');
  final _pincodeController = TextEditingController(text: '629001');

  String _selectedTaluk = 'Agastheeswaram';
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  final List<String> _taluks = [
    'Agastheeswaram',
    'Thovalai',
    'Kalkulam',
    'Vilavancode',
    'Thiruvattar',
    'Killiyoor',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _villageController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: AppColors.emergencyRed,
        ),
      );
      return;
    }

    final auth = Provider.of<AuthProvider>(context, listen: false);
    final success = await auth.register(
      email: _emailController.text,
      password: _passwordController.text,
      fullName: _nameController.text,
      phoneNumber: _phoneController.text,
      taluk: _selectedTaluk,
      village: _villageController.text,
      pincode: _pincodeController.text,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful! Verification email has been sent.'),
          backgroundColor: AppColors.statusResolved,
        ),
      );
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else if (auth.errorMessage != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(auth.errorMessage!),
          backgroundColor: AppColors.emergencyRed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Citizen Registration'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Register with District Portal',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.primaryDark,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Create your account to submit municipal grievances and track department progress',
                  style: TextStyle(fontSize: 13, color: isDark ? Colors.white60 : Colors.black54),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  prefixIcon: Icons.person_outline,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  controller: _emailController,
                  label: 'Email Address',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) =>
                      (v == null || !v.contains('@')) ? 'Please enter a valid email address' : null,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  controller: _phoneController,
                  label: 'Mobile Number (+91)',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (v) =>
                      (v == null || v.length < 10) ? 'Enter valid 10-digit mobile number' : null,
                ),
                const SizedBox(height: 14),
                // Taluk Selector
                DropdownButtonFormField<String>(
                  value: _selectedTaluk,
                  decoration: InputDecoration(
                    labelText: 'Revenue Taluk',
                    prefixIcon: const Icon(Icons.location_city, color: AppColors.primary, size: 20),
                    filled: true,
                    fillColor: isDark ? AppColors.surfaceDark : Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  items: _taluks
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedTaluk = val);
                  },
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomTextField(
                        controller: _villageController,
                        label: 'Village / Ward',
                        prefixIcon: Icons.map_outlined,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: CustomTextField(
                        controller: _pincodeController,
                        label: 'Pincode',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: (v) =>
                      (v == null || v.length < 6) ? 'Password must be at least 6 characters' : null,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  prefixIcon: Icons.lock_clock_outlined,
                  obscureText: _obscureConfirm,
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Please confirm your password' : null,
                ),
                const SizedBox(height: 24),
                CustomButton(
                  title: 'Create Account',
                  onPressed: _handleRegister,
                  isLoading: auth.isLoading,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
