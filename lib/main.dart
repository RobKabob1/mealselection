import 'package:flutter/material.dart';
import 'package:mealselection/home.dart';
import 'package:mealselection/models/lists.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(
    ChangeNotifierProvider(
      create: (context) => DeliciousChoices(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const Home(title: 'Meal Selection'),
      routes: {
        '/home': (context) => const Home(title: 'Meal Selection'),
      },
    );
  }
}
