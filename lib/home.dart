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
              //breakfast
              Expanded(
                child: IconButton(
                  iconSize: 20,
                  icon: Image.asset(
                    'images/screens/breakfast.png',
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Breakfast(
                          food: items.breakfastMenu[randomBreakfastIndex],
                        ),
                      ),
                    );
                  },
                ),
              ),
              //lunch
              Expanded(
                child: IconButton(
                  iconSize: 20,
                  icon: Image.asset('images/screens/lunch.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Lunch(
                          food: items.lunchMenu[randomLunchIndex],
                        ),
                      ),
                    );
                  },
                ),
              ),
              //dinner
              Expanded(
                child: IconButton(
                  iconSize: 20,
                  icon: Image.asset('images/screens/dinner.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dinner(
                          food: items.dinnerMenu[randomDinnerIndex],
                        ),
                      ),
                    );
                  },
                ),
              ),
              //restaurants
              Expanded(
                child: IconButton(
                  iconSize: 20,
                  icon: Image.asset(
                    'images/screens/restaurants.png',
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Restaurants(
                          food: items.restaurantList[randomRestaurantIndex],
                        ),
                      ),
                    );
                  },
                ),
              ),
              //snacks
              Expanded(
                child: IconButton(
                  iconSize: 20,
                  icon: Image.asset('images/screens/snacks.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Snacks(
                          food: items.snacksList[randomSnackIndex],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
