import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mealselection/resources/get_random_food.dart';
import 'package:mealselection/responsive/responsive_layout_screen.dart';
import 'package:mealselection/screens/mobile/mobile_oboarding_screen.dart';
import 'package:mealselection/screens/mobile/mobile_user_profile_screen.dart';
import 'package:mealselection/screens/web/web_onboarding_screen.dart';
import 'package:mealselection/screens/web/web_user_profile_screen.dart';
import 'package:mealselection/utils/colors.dart';

class WebHomeScreen extends StatefulWidget {
  final String title;
  const WebHomeScreen({super.key, required this.title});

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(child: Container()),
          SizedBox(
            width: 600,
            child: Column(
              children: [
                AppBar(
                  backgroundColor: mobileBackgroundColor,
                  title: Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 25,
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.question_mark_sharp),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResponsiveLayout(
                              mobileScreenLayout: MobileOnboardingScreen(),
                              webScreenLayout: WebOnboardingScreen(),
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.account_circle_rounded),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResponsiveLayout(
                              mobileScreenLayout: MobileUserProfileScreen(
                                  email: FirebaseAuth
                                      .instance.currentUser!.email!),
                              webScreenLayout: WebUserProfileScreen(
                                  email: FirebaseAuth
                                      .instance.currentUser!.email!),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                //breakfast
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        RandomFood().getRandomFoodAndGo(context, 'Breakfast');
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: const DecorationImage(
                            image: AssetImage('images/screens/breakfast.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                //lunch
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        RandomFood().getRandomFoodAndGo(context, 'Lunch');
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: const DecorationImage(
                            image: AssetImage('images/screens/lunch.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                //dinner
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        RandomFood().getRandomFoodAndGo(context, 'Dinner');
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: const DecorationImage(
                            image: AssetImage('images/screens/dinner.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                //restaurants
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        RandomFood().getRandomFoodAndGo(context, 'Restaurants');
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: const DecorationImage(
                            image: AssetImage('images/screens/restaurants.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                //snacks
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        RandomFood().getRandomFoodAndGo(context, 'Snacks');
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: const DecorationImage(
                            image: AssetImage('images/screens/snacks.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Flexible(child: Container()),
        ],
      ),
    );
  }
}
