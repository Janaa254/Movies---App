import 'package:flutter/material.dart';

import '../auth/login_screen.dart';

import 'onboarding_data.dart';
import 'onboarding_theme.dart';

import 'widgets/first_onboarding_page.dart';
import 'widgets/standard_onboarding_page.dart';

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
        const Duration(milliseconds: 350),
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
      const Duration(milliseconds: 350),
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

        itemCount:
        onboardingData.length,

        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },

        itemBuilder: (
            context,
            index,
            ) {
          final item =
          onboardingData[index];

          // ================= FIRST PAGE =================

          if (index == 0) {
            return FirstOnboardingPage(
              item: item,
              onNext: nextPage,
            );
          }

          // ================= OTHER PAGES =================

          return StandardOnboardingPage(
            item: item,

            showBack: index >= 2,

            isLastPage:
            index ==
                onboardingData.length -
                    1,

            onNext: nextPage,

            onBack: previousPage,
          );
        },
      ),
    );
  }
}