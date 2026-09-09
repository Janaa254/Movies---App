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
      backgroundColor: const Color(0xFF111312),

      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: const Color(0xFF111312),
            ),
          ),

          Align(
            alignment: const Alignment(0, -0.15),
            child: Image.asset(
              'assets/images/logo.png',
              width: 125,
              height: 125,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}