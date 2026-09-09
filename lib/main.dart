import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

import 'features/home/bloc/home_bloc.dart';
import 'features/home/screens/home_screen.dart';

import 'splash/splash_screen.dart';
import 'onboarding/onboarding_screen.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';
import 'auth/forget_password_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff101010),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffffc107),
          brightness: Brightness.dark,
        ),
      ),

      routes: {
        '/onboarding': (context) => const OnboardingScreen(),

        '/login': (context) => const LoginScreen(),

        '/register': (context) => const RegisterScreen(),

        '/forget-password': (context) =>
            const ForgetPasswordScreen(),

        '/home': (context) => BlocProvider(
              create: (_) => HomeBloc(),
              child: const HomeScreen(),
            ),
      },

      // App flow:
      // Splash -> Onboarding -> Login/Register -> Home
      home: const SplashScreen(),
    );
  }
}