import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  final bool isLoading;
  final bool enabled;

  final double? width;
  final double height;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.width,
    this.height = AppSizes.buttonHeight,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,

      child: ElevatedButton(
        onPressed: (!enabled || isLoading)
            ? null
            : onPressed,

        style: ElevatedButton.styleFrom(
          elevation: 0,

          backgroundColor:
              backgroundColor ?? AppColors.primary,

          disabledBackgroundColor:
              Colors.grey.shade400,

          foregroundColor:
              foregroundColor ?? AppColors.white,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSizes.buttonRadius,
            ),
          ),
        ),

        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    const SizedBox(width: 8),
                  ],

                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}