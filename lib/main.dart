import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mealselection/auth/app.dart';
import 'package:mealselection/auth/firebase_options.dart';
import 'package:mealselection/models/lists.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setPathUrlStrategy();
  runApp(
    ChangeNotifierProvider(
      create: (context) => DeliciousChoices(),
      child: const MyApp(
        title: 'Authentication',
      ),
    ),
  );
}
