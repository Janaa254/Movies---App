import 'package:flutter/material.dart';

import 'onboarding/onboarding_screen.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';
import 'auth/forget_password_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
      ),

      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forget-password': (context) =>
        const ForgetPasswordScreen(),
      },

      home: const OnboardingScreen(),
    );
  }
}