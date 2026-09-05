import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_images.dart';
import '../constants/app_sizes.dart';
import '../widgets/primary_button.dart';

class EmptyWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  final String? image;

  final String? buttonText;

  final VoidCallback? onPressed;

  const EmptyWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.image,
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          AppSizes.defaultPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //--------------------------------------------------
            // Illustration
            //--------------------------------------------------

            Image.asset(
              image ?? AppImages.noData,
              height: 220,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 30),

            //--------------------------------------------------
            // Title
            //--------------------------------------------------

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 12),

            //--------------------------------------------------
            // Subtitle
            //--------------------------------------------------

            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),

            if (buttonText != null) ...[
              const SizedBox(height: 35),

              SizedBox(
                width: 220,
                child: PrimaryButton(
                  text: buttonText!,
                  onPressed: onPressed,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}