import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mealselection/models/food.dart';
import 'package:mealselection/models/lists.dart';
import 'package:provider/provider.dart';

class Lunch extends StatefulWidget {
  final Food food;
  final String title;
  const Lunch({super.key, required this.food, required this.title});

  @override
  State<Lunch> createState() => _LunchState();
}

class _LunchState extends State<Lunch> {
  @override
  Widget build(BuildContext context) {
    //get the lunch menu and choose a random item
    final items = context.read<DeliciousChoices>();
    final randomLunchIndex = Random().nextInt(items.lunchMenu.length);
    setState(() {
      randomLunchIndex;
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[350],
        title: Text(
          widget.title,
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: 'Times New Roman'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/home', (route) => false);
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_rounded),
            onPressed: () {},
          ),
        ],
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
                    fit: BoxFit.fill,
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
                          builder: (context) => Lunch(
                            food: items.lunchMenu[randomLunchIndex],
                            title: 'Lunch',
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
              child: ReorderableListView(
                autoScrollerVelocityScalar: 100,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                onReorder: (int oldIndex, int newIndex) {
                  setState(
                    () {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final Food item = items.lunchMenu.removeAt(oldIndex);
                      items.lunchMenu.insert(newIndex, item);
                    },
                  );
                },
                children: [
                  for (int index = 0;
                      index < items.lunchMenu.length;
                      index += 1)
                    Card(
                      key: Key('$index'),
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Lunch(
                                food: items.lunchMenu[index],
                                title: 'Lunch',
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: SizedBox(
                                height: 50,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(items.lunchMenu[index].name,
                                      style: const TextStyle(fontSize: 20)),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.delete)),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
