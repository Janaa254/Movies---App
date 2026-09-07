import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/home/bloc/home_bloc.dart';
import 'features/home/screens/home_screen.dart';

void main() {
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
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff101010),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffffc107),
          brightness: Brightness.dark,
        ),
      ),
      home: BlocProvider(
        create: (_) => HomeBloc(),
        child: const HomeScreen(),
      ),
    );
  }
}