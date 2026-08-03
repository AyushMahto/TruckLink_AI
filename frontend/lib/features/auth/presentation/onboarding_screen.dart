import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../models/onboarding_model.dart';
import '../widgets/navigation_buttons.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/page_indicator.dart';
// import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  void nextPage() {
    if (currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipPage() {
    _pageController.animateToPage(
      onboardingData.length - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  // void finish() {
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (_) => const LoginScreen()),
  //   );
  // }
  void finish() {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final lastPage = currentPage == onboardingData.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: OnboardingPage(
                      key: ValueKey(index),
                      model: onboardingData[index],
                    ),
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => PageIndicator(active: currentPage == index),
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              child: NavigationButtons(
                lastPage: lastPage,
                onNext: nextPage,
                onSkip: skipPage,
                onFinish: finish,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
