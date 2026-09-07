import 'package:flutter/material.dart';

import '../onboarding_model.dart';
import '../onboarding_theme.dart';
import 'onboarding_button.dart';

class FirstOnboardingPage extends StatelessWidget {
  final OnboardingModel item;
  final VoidCallback onNext;

  const FirstOnboardingPage({
    super.key,
    required this.item,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // ================= BACKGROUND IMAGE =================

        Image.asset(
          item.image,
          fit: BoxFit.cover,
          errorBuilder: (
              context,
              error,
              stackTrace,
              ) {
            return Container(
              color: OnboardingTheme.background,
              child: const Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: Colors.white38,
                  size: 60,
                ),
              ),
            );
          },
        ),

        // ================= DARK GRADIENT =================

        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Color(0x11000000),
                Color(0x33000000),
                Color(0x88000000),
                Color(0xEE0B0D0C),
                Color(0xFF0B0D0C),
              ],
              stops: [
                0.0,
                0.38,
                0.52,
                0.68,
                0.84,
                1.0,
              ],
            ),
          ),
        ),

        // ================= BOTTOM CONTENT =================

        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                0,
                16,
                28,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: OnboardingTheme.firstTitle,
                  ),

                  const SizedBox(height: 22),

                  Text(
                    item.description,
                    textAlign: TextAlign.center,
                    style:
                    OnboardingTheme.firstDescription,
                  ),

                  const SizedBox(height: 28),

                  OnboardingButton(
                    text: 'Explore Now',
                    onPressed: onNext,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}