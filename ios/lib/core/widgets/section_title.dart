import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;

  final String? actionText;

  final VoidCallback? onTap;

  final IconData? icon;

  final Color? color;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.actionText,
    this.onTap,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = color ?? AppColors.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //-------------------------------------------------
          // Leading Icon
          //-------------------------------------------------

          if (icon != null) ...[
            Icon(
              icon,
              color: themeColor,
              size: 26,
            ),
            const SizedBox(width: 10),
          ],

          //-------------------------------------------------
          // Title & Subtitle
          //-------------------------------------------------

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: themeColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                if (subtitle != null) ...[
                  const SizedBox(height: 4),

                  Text(
                    subtitle!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),

          //-------------------------------------------------
          // Action Button
          //-------------------------------------------------

          if (actionText != null)
            TextButton(
              onPressed: onTap,
              child: Text(
                actionText!,
                style: TextStyle(
                  color: themeColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}