import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF00695C);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 20,
        ),
        child: Column(
          children: [
            const Spacer(),

            Hero(
              tag: image,
              child: Image.asset(
                image,
                height: MediaQuery.of(context).size.height * 0.40,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 40),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: primary,
                height: 1.2,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey.shade700,
                height: 1.6,
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}