// onboarding_screen.dart
// NOTE: Skeleton file. Replace LoginScreen import with your project path.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'auth/login_screen.dart';
import '../core/constants/app_images.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<Map<String, String>> pages = const [
    {
      "image":AppImages.onboarding1,
      "title":"Welcome to Namma Kanyakumari",
      "subtitle":"Connecting you directly with your local government."
    },
    {
      "image":AppImages.onboarding2,
      "title":"Smart Issue Reporting",
      "subtitle":"AI identifies civic issues from your photos."
    },
    {
      "image":AppImages.onboarding3,
      "title":"Track Every Step",
      "subtitle":"Monitor complaint progress in real time."
    },
    {
      "image":AppImages.onboarding4,
      "title":"Safe & Secure",
      "subtitle":"Quick access to emergency services."
    },
  ];

  Future<void> finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("first_time", false);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xff00695C);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: finish,
                child: const Text("Skip"),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (i)=>setState(()=>currentPage=i),
                itemBuilder: (_,i){
                  final p=pages[i];
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            p["image"]!,
                            fit: BoxFit.contain,
                            errorBuilder: (_,__,___)=>const Icon(Icons.image,size:160),
                          ),
                        ),
                        const SizedBox(height:16),
                        Text(
                          p["title"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize:30,fontWeight:FontWeight.bold,color:primary),
                        ),
                        const SizedBox(height:12),
                        Text(
                          p["subtitle"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize:16,color:Colors.grey.shade700),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: pages.length,
              effect: const ExpandingDotsEffect(
                activeDotColor: primary,
                dotHeight: 10,
                dotWidth: 10,
              ),
            ),
            const SizedBox(height:24),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  if(currentPage>0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: (){
                          _controller.previousPage(duration: const Duration(milliseconds:300), curve: Curves.easeInOut);
                        },
                        child: const Text("Back"),
                      ),
                    ),
                  if(currentPage>0) const SizedBox(width:12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: primary, foregroundColor: Colors.white),
                      onPressed: (){
                        if(currentPage==pages.length-1){
                          finish();
                        }else{
                          _controller.nextPage(duration: const Duration(milliseconds:300), curve: Curves.easeInOut);
                        }
                      },
                      child: Text(currentPage==pages.length-1?"Get Started":"Next"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
