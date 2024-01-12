import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mealselection/responsive/mobile_screen_layout.dart';
import 'package:mealselection/providers/user_provider.dart';
import 'package:mealselection/resources/firebase_options.dart';
import 'package:mealselection/responsive/responsive_layout_screen.dart';
import 'package:mealselection/responsive/web_screen_layout.dart';
import 'package:mealselection/screens/login_screen.dart';
import 'package:mealselection/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setPathUrlStrategy();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meal Selection',
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout:
                      MobileScreenLayout(title: "Meal Selection"),
                  webScreenLayout: WebScreenLayout(title: "Meal Selection"),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen();
          },
        ),
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        routes: {
          '/home': (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(title: "Meal Selection"),
                webScreenLayout: WebScreenLayout(title: "Meal Selection"),
              ),
        },
      ),
    );
  }
}
