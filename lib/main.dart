import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mealselection/screens/mobile/mobile_home_screen.dart';
import 'package:mealselection/providers/user_provider.dart';
import 'package:mealselection/resources/firebase_options.dart';
import 'package:mealselection/responsive/responsive_layout_screen.dart';
import 'package:mealselection/screens/web/web_home_screen.dart';
import 'package:mealselection/screens/mobile/mobile_login_screen.dart';
import 'package:mealselection/screens/mobile/mobile_oboarding_screen.dart';
import 'package:mealselection/screens/mobile/mobile_signup_screen.dart';
import 'package:mealselection/screens/mobile/mobile_user_profile_screen.dart';
import 'package:mealselection/screens/web/web_login_screen.dart';
import 'package:mealselection/screens/web/web_onboarding_screen.dart';
import 'package:mealselection/screens/web/web_signup_screen.dart';
import 'package:mealselection/screens/web/web_user_profile_screen.dart';
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
          create: (_) => UserProvider(),
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
                  mobileScreenLayout: MobileHomeScreen(title: "Meal Selection"),
                  webScreenLayout: WebHomeScreen(title: "Meal Selection"),
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
            return const ResponsiveLayout(
              mobileScreenLayout: MobileLoginScreen(),
              webScreenLayout: WebLoginScreen(),
            );
          },
        ),
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        routes: {
          '/home': (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileHomeScreen(title: "Meal Selection"),
                webScreenLayout: WebHomeScreen(title: "Meal Selection"),
              ),
          '/login': (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileLoginScreen(),
                webScreenLayout: WebLoginScreen(),
              ),
          '/signup': (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileSignUpScreen(),
                webScreenLayout: WebSignUpScreen(),
              ),
          '/onboarding': (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileOnboardingScreen(),
                webScreenLayout: WebOnboardingScreen(),
              ),
          '/profile': (context) => ResponsiveLayout(
                mobileScreenLayout: MobileUserProfileScreen(
                    email: FirebaseAuth.instance.currentUser!.email!),
                webScreenLayout: WebUserProfileScreen(
                    email: FirebaseAuth.instance.currentUser!.email!),
              ),
        },
      ),
    );
  }
}
