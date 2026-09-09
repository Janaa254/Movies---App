import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart';

import 'l10n/app_localizations.dart';
import 'l10n/locale_controller.dart';

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
    return ValueListenableBuilder<Locale?>(
      valueListenable: appLocale,
      builder: (
          context,
          selectedLocale,
          child,
          ) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          locale: selectedLocale,

          onGenerateTitle: (context) {
            return AppLocalizations.of(context)!.appName;
          },

          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],

          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Arial',
            brightness: Brightness.dark,
            scaffoldBackgroundColor:
            const Color(0xff101010),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xffffc107),
              brightness: Brightness.dark,
            ),
          ),

          routes: {
            '/onboarding': (context) =>
            const OnboardingScreen(),

            '/login': (context) =>
            const LoginScreen(),

            '/register': (context) =>
            const RegisterScreen(),

            '/forget-password': (context) =>
            const ForgetPasswordScreen(),

            '/home': (context) => BlocProvider(
              create: (_) => HomeBloc(),
              child: const HomeScreen(),
            ),
          },

          home: const SplashScreen(),
        );
      },
    );
  }
}