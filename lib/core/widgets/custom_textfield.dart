import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? labelText;

  final IconData? prefixIcon;
  final IconData? suffixIcon;

  final VoidCallback? onSuffixTap;

  final bool obscureText;
  final bool readOnly;
  final bool enabled;

  final int maxLines;
  final int? maxLength;

  final TextInputType keyboardType;

  final String? Function(String?)? validator;

  final ValueChanged<String>? onChanged;

  final VoidCallback? onTap;

  final TextInputAction textInputAction;

  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.onTap,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,

      validator: validator,

      onChanged: onChanged,

      onTap: onTap,

      keyboardType: keyboardType,

      textInputAction: textInputAction,

      obscureText: obscureText,

      readOnly: readOnly,

      enabled: enabled,

      maxLines: obscureText ? 1 : maxLines,

      maxLength: maxLength,

      decoration: InputDecoration(
        labelText: labelText,

        hintText: hintText,

        counterText: "",

        prefixIcon: prefixIcon == null
            ? null
            : Icon(
                prefixIcon,
                color: AppColors.primary,
              ),

        suffixIcon: suffixIcon == null
            ? null
            : IconButton(
                onPressed: onSuffixTap,
                icon: Icon(
                  suffixIcon,
                  color: AppColors.primary,
                ),
              ),

        filled: true,

        fillColor: AppColors.inputFill,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.textFieldRadius,
          ),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.textFieldRadius,
          ),
          borderSide: BorderSide(
            color: AppColors.border,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.textFieldRadius,
          ),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.textFieldRadius,
          ),
          borderSide: const BorderSide(
            color: AppColors.error,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.textFieldRadius,
          ),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),
      ),
    );
  }
}