import 'package:flutter/material.dart';

import 'onboarding_model.dart';
import 'onboarding_theme.dart';
import 'onboarding_button.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel item;
  final int index;
  final int currentPage;
  final int totalPages;

  final VoidCallback onNext;
  final VoidCallback onBack;

  const OnboardingPage({
    super.key,
    required this.item,
    required this.index,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onBack,
  });

  String get buttonText {
    if (currentPage == 0) {
      return 'Explore Now';
    }

    if (currentPage == totalPages - 1) {
      return 'Finish';
    }

    return 'Next';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ================= IMAGE =================

        Positioned.fill(
          child: Image.asset(
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
        ),

        // ================= GRADIENT =================

        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color(0x11000000),
                  Color(0x44000000),
                  Color(0x99000000),
                  Color(0xEE0B0D0C),
                  Color(0xFF0B0D0C),
                ],
                stops: [
                  0.0,
                  0.35,
                  0.50,
                  0.65,
                  0.82,
                  1.0,
                ],
              ),
            ),
          ),
        ),

        // ================= CONTENT =================

        Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                0,
                16,
                22,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: index == 0
                        ? OnboardingTheme.firstTitleStyle
                        : OnboardingTheme.titleStyle,
                  ),

                  if (item.description.isNotEmpty) ...[
                    const SizedBox(height: 22),

                    Text(
                      item.description,
                      textAlign: TextAlign.center,
                      style:
                      OnboardingTheme.descriptionStyle,
                    ),

                    const SizedBox(height: 28),
                  ],

                  OnboardingButton(
                    text: buttonText,
                    onPressed: onNext,
                  ),

                  if (currentPage > 0) ...[
                    const SizedBox(height: 14),

                    OnboardingButton(
                      text: 'Back',
                      onPressed: onBack,
                      outlined: true,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}