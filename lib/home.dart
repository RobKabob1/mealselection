import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mealselection/breakfast.dart';
import 'package:mealselection/dinner.dart';
import 'package:mealselection/lunch.dart';
import 'package:mealselection/models/lists.dart';
import 'package:mealselection/restaurants.dart';
import 'package:mealselection/snacks.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //build a random choice
    final items = context.read<DeliciousChoices>();
    final randomBreakfastIndex = Random().nextInt(items.breakfastMenu.length);
    final randomLunchIndex = Random().nextInt(items.lunchMenu.length);
    final randomDinnerIndex = Random().nextInt(items.dinnerMenu.length);
    final randomRestaurantIndex = Random().nextInt(items.restaurantList.length);
    final randomSnackIndex = Random().nextInt(items.snacksList.length);
    setState(() {
      randomBreakfastIndex;
      randomLunchIndex;
      randomDinnerIndex;
      randomRestaurantIndex;
      randomSnackIndex;
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.account_circle_rounded), onPressed: () {}),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[350]),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              //breakfast
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Breakfast(
                            food: items.breakfastMenu[randomBreakfastIndex],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(55),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Lunch(
                            food: items.lunchMenu[randomLunchIndex],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(55),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dinner(
                            food: items.dinnerMenu[randomDinnerIndex],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(55),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Restaurants(
                            food: items.restaurantList[randomRestaurantIndex],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(55),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Snacks(
                            food: items.snacksList[randomSnackIndex],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(55),
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
      ),
    );
  }
}
