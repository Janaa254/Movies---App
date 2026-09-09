import 'package:flutter/material.dart';

import '../onboarding_model.dart';
import '../onboarding_theme.dart';
import 'onboarding_button.dart';

class StandardOnboardingPage extends StatelessWidget {
  final OnboardingModel item;
  final bool showBack;
  final bool isLastPage;

  final VoidCallback onNext;
  final VoidCallback onBack;

  const StandardOnboardingPage({
    super.key,
    required this.item,
    required this.showBack,
    required this.isLastPage,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: OnboardingTheme.background,
      child: Stack(
        children: [
          // ================= IMAGE =================

          Positioned.fill(
            child: Image.asset(
              item.image,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
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

          // ================= SMALL IMAGE GRADIENT =================

          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Color(0x440B0D0C),
                    Color(0xFF0B0D0C),
                  ],
                  stops: [
                    0.0,
                    0.45,
                    0.65,
                    0.78,
                  ],
                ),
              ),
            ),
          ),

          // ================= BOTTOM PANEL =================

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,

              padding: EdgeInsets.fromLTRB(
                16,
                31,
                16,
                showBack ? 48 : 38,
              ),

              decoration: const BoxDecoration(
                color: OnboardingTheme.cardBackground,

                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(38),
                  topRight: Radius.circular(38),
                ),
              ),

              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ================= TITLE =================

                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: OnboardingTheme.title,
                    ),

                    if (item.description.isNotEmpty) ...[
                      const SizedBox(height: 24),

                      // ================= DESCRIPTION =================

                      Text(
                        item.description,
                        textAlign: TextAlign.center,
                        style:
                        OnboardingTheme.description,
                      ),
                    ],

                    const SizedBox(height: 27),

                    // ================= NEXT =================

                    OnboardingButton(
                      text:
                      isLastPage ? 'Finish' : 'Next',
                      onPressed: onNext,
                    ),

                    // ================= BACK =================

                    if (showBack) ...[
                      const SizedBox(height: 17),

                      OnboardingButton(
                        text: 'Back',
                        outlined: true,
                        onPressed: onBack,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}