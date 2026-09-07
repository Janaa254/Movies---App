import 'dart:async';

import 'package:flutter/material.dart';

import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 2),
          () {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const OnboardingScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0D0C),

      body: Center(
        child: SizedBox(
          width: 130,
          height: 130,
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,

            errorBuilder: (
                context,
                error,
                stackTrace,
                ) {
              return const Icon(
                Icons.play_circle_outline,
                color: Color(0xFFFFC400),
                size: 100,
              );
            },
          ),
        ),
      ),
    );
  }
}