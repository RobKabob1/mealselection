//import 'dart:math';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mealselection/components/food_tile.dart';
import 'package:mealselection/models/food.dart';
import 'package:mealselection/models/lists.dart';
import 'package:provider/provider.dart';

class Breakfast extends StatefulWidget {
  final Food food;
  const Breakfast({super.key, required this.food});

  @override
  State<Breakfast> createState() => _BreakfastState();
}

class _BreakfastState extends State<Breakfast> {
  @override
  Widget build(BuildContext context) {
    //get the breakfast menu
    final items = context.read<DeliciousChoices>();
    final breakfastMenu = items.breakfastMenu;
    //choose a random item
    final randomIndex = Random().nextInt(breakfastMenu.length);
    //String randomName = breakfastMenu[randomIndex].name.toString();
    //print("breakfast updated: $randomName");
    //set State with that random item
    setState(() {
      randomIndex;
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Breakfast'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[350]),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Image.asset(
                    widget.food.imagePath,
                    height: 200,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    widget.food.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.refresh),
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
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                ),
                itemCount: breakfastMenu.length,
                itemBuilder: (context, index) => FoodTile(
                  food: breakfastMenu[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Breakfast(
                          food: breakfastMenu[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
