import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_images.dart';
import '../constants/app_sizes.dart';
import 'primary_button.dart';

class AppErrorWidget extends StatelessWidget {
  final String title;
  final String message;

  final String? image;

  final String buttonText;

  final VoidCallback? onRetry;

  const AppErrorWidget({
    super.key,
    required this.title,
    required this.message,
    this.image,
    this.buttonText = "Retry",
    this.onRetry,
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
            //---------------------------------------
            // Illustration
            //---------------------------------------

            Image.asset(
              image ?? AppImages.noInternet,
              height: 220,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 30),

            //---------------------------------------
            // Title
            //---------------------------------------

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.error,
              ),
            ),

            const SizedBox(height: 15),

            //---------------------------------------
            // Message
            //---------------------------------------

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 35),

            //---------------------------------------
            // Retry Button
            //---------------------------------------

            SizedBox(
              width: 220,
              child: PrimaryButton(
                text: buttonText,
                icon: Icons.refresh,
                onPressed: onRetry,
              ),
            ),
          ],
        ),
      ),
    );
  }
}