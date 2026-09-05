class OnboardingModel {
  final String image;
  final String title;
  final String subtitle;

  const OnboardingModel({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

final List<OnboardingModel> onboardingData = [
  OnboardingModel(
    image: "assets/onboarding/onboarding1.png",
    title: "Welcome to\nNamma Kanyakumari",
    subtitle:
        "Connecting you directly with your local government for a smarter district.",
  ),

  OnboardingModel(
    image: "assets/onboarding/onboarding2.png",
    title: "Smart Issue Reporting",
    subtitle:
        "Our AI automatically identifies potholes, garbage, broken streetlights, water leakage, and other civic issues from your photos for faster resolution.",
  ),

  OnboardingModel(
    image: "assets/onboarding/onboarding3.png",
    title: "Track Every Step",
    subtitle:
        "Receive real-time updates as your complaint moves from verification to resolution with complete transparency.",
  ),

  OnboardingModel(
    image: "assets/onboarding/onboarding4.png",
    title: "Safe & Secure",
    subtitle:
        "Quickly access Police, Fire, Ambulance, Disaster Management, and other emergency services whenever you need them.",
  ),
];