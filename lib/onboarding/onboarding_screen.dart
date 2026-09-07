import 'package:flutter/material.dart';

import '../auth/login_screen.dart';

import 'onboarding_data.dart';
import 'onboarding_page.dart';
import 'onboarding_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {
  final PageController _pageController =
  PageController();

  int currentPage = 0;

  // ================= NEXT =================

  void nextPage() {
    if (currentPage <
        onboardingData.length - 1) {
      _pageController.nextPage(
        duration:
        const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );

      return;
    }

    finishOnboarding();
  }

  // ================= BACK =================

  void previousPage() {
    if (currentPage == 0) return;

    _pageController.previousPage(
      duration:
      const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  // ================= FINISH =================

  void finishOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const LoginScreen(),
      ),
    );
  }

  // ================= DISPOSE =================

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      OnboardingTheme.background,

      body: PageView.builder(
        controller: _pageController,

        itemCount: onboardingData.length,

        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },

        itemBuilder: (
            context,
            index,
            ) {
          return OnboardingPage(
            item: onboardingData[index],
            index: index,
            currentPage: currentPage,
            totalPages:
            onboardingData.length,
            onNext: nextPage,
            onBack: previousPage,
          );
        },
      ),
    );
  }
}