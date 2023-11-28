import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mealselection/breakfast.dart';
import 'package:mealselection/models/lists.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // void randomFoodSource(context) {
  //   int randomIndex;
  //   String randomName;

  //   setState() {
  //     final items = context.read<DeliciousChoices>();
  //     final breakfastMenu = items.breakfastMenu;
  //     randomIndex = Random().nextInt(breakfastMenu.length);
  //     randomName = breakfastMenu[randomIndex].name.toString();
  //     print("home: $randomName");
  //   }
  //   //select a random item for the initial load
  // }

  // @override
  // // ignore: must_call_super
  // initState() {
  //   // ignore: avoid_print
  //   print("initState Called");
  //   randomFoodSource(context);
  // }

  @override
  Widget build(BuildContext context) {
    //build a random choice
    final items = context.read<DeliciousChoices>();
    final breakfastMenu = items.breakfastMenu;
    final randomIndex = Random().nextInt(breakfastMenu.length);
    setState(() {
      randomIndex;
      //print("home: $randomIndex");
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
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
                          food: breakfastMenu[randomIndex],
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
                  onPressed: () {},
                ),
              ),
              //dinner
              Expanded(
                child: IconButton(
                  iconSize: 20,
                  icon: Image.asset('images/screens/dinner.png'),
                  onPressed: () {},
                ),
              ),
              //restaurants
              Expanded(
                child: IconButton(
                  iconSize: 20,
                  icon: Image.asset(
                    'images/screens/restaurants.png',
                  ),
                  onPressed: () {},
                ),
              ),
              //snacks
              Expanded(
                child: IconButton(
                  iconSize: 20,
                  icon: Image.asset('images/screens/snacks.png'),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
