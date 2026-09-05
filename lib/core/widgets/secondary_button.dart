import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  final bool isLoading;
  final bool enabled;

  final double? width;
  final double height;

  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;

  final IconData? icon;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.width,
    this.height = AppSizes.buttonHeight,
    this.borderColor,
    this.textColor,
    this.backgroundColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: (!enabled || isLoading)
            ? null
            : onPressed,
        style: OutlinedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              backgroundColor ?? Colors.transparent,
          side: BorderSide(
            color: borderColor ?? AppColors.primary,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSizes.buttonRadius,
            ),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  color: textColor ?? AppColors.primary,
                ),
              )
            : Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: 20,
                      color:
                          textColor ?? AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      color:
                          textColor ?? AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: .3,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}