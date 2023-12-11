import 'package:flutter/material.dart';
import 'package:mealselection/home.dart';
import 'auth_gate.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required String title});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Selection',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
        shadowColor: Colors.transparent,
        canvasColor: Colors.transparent,
      ),
      home: const AuthGate(),
      routes: {
        '/home': (context) => const Home(title: 'Meal Selection'),
      },
    );
  }
}
