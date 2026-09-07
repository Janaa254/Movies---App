import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

import 'onboarding/onboarding_screen.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';
import 'auth/forget_password_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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