import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String hintText;
  final String? labelText;

  final T? value;

  final List<DropdownMenuItem<T>> items;

  final ValueChanged<T?>? onChanged;

  final String? Function(T?)? validator;

  final IconData? prefixIcon;

  final bool enabled;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.items,
    this.labelText,
    this.value,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,

      items: items,

      onChanged: enabled ? onChanged : null,

      validator: validator,

      isExpanded: true,

      decoration: InputDecoration(
        labelText: labelText,

        hintText: hintText,

        prefixIcon: prefixIcon == null
            ? null
            : Icon(
                prefixIcon,
                color: AppColors.primary,
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
          borderSide: const BorderSide(
            color: AppColors.inputBorder,
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

      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.primary,
      ),

      dropdownColor: AppColors.white,

      borderRadius: BorderRadius.circular(16)
    );
  }
}